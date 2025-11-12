# -*- coding: utf-8 -*-
# @Time : 20-6-9 下午3:06
# @Author : zhuying
# @Company : Minivision
# @File : test.py
# @Software : PyCharm

import os
import cv2
import numpy as np
import argparse
import warnings
import time

from src.anti_spoof_predict import AntiSpoofPredict
from src.generate_patches import CropImage
from src.utility import parse_model_name
warnings.filterwarnings('ignore')


SAMPLE_IMAGE_PATH = ""


# 因为安卓端APK获取的视频流宽高比为3:4,为了与之一致，所以将宽高比限制为3:4
def check_image(image):
    height, width, channel = image.shape
    # Relaxed check - just verify image has valid dimensions
    # Original check was too strict for webcam images
    if width < 50 or height < 50:
        print("Image is too small!")
        return False
    else:
        return True


def test(image_name=None, model_dir="./resources/anti_spoof_models", device_id=0, image=None):
    """
    Test function that supports both file path and direct image array.
    
    Args:
        image_name: Path to image file (legacy support)
        model_dir: Directory containing anti-spoof models
        device_id: GPU device ID (0 for CPU)
        image: Direct image array (for webcam feed)
    
    Returns:
        label: 1 for real face, 0 for fake face, None for error
    """
    model_test = AntiSpoofPredict(device_id)
    image_cropper = CropImage()
    
    # Support both image path and direct image array
    if image is None and image_name is not None:
        image = cv2.imread(SAMPLE_IMAGE_PATH + image_name)
    elif image is None:
        print("Error: No image provided")
        return None
    
    result = check_image(image)
    if result is False:
        # Don't print error for webcam, just return None
        return None
    
    image_bbox = model_test.get_bbox(image)
    prediction = np.zeros((1, 3))
    test_speed = 0
    # sum the prediction from single model's result
    for model_name in os.listdir(model_dir):
        h_input, w_input, model_type, scale = parse_model_name(model_name)
        param = {
            "org_img": image,
            "bbox": image_bbox,
            "scale": scale,
            "out_w": w_input,
            "out_h": h_input,
            "crop": True,
        }
        if scale is None:
            param["crop"] = False
        img = image_cropper.crop(**param)
        start = time.time()
        prediction += model_test.predict(img, os.path.join(model_dir, model_name))
        test_speed += time.time()-start

    # draw result of prediction
    label = np.argmax(prediction)
    value = prediction[0][label]/2
    if label == 1:
        print("Image '{}' is Real Face. Score: {:.2f}.".format(image_name if image_name else "webcam", value))
        result_text = "RealFace Score: {:.2f}".format(value)
        color = (255, 0, 0)
    else:
        print("Image '{}' is Fake Face. Score: {:.2f}.".format(image_name if image_name else "webcam", value))
        result_text = "FakeFace Score: {:.2f}".format(value)
        color = (0, 0, 255)
    print("Prediction cost {:.2f} s".format(test_speed))
    
    # Only save image if image_name is provided (not for webcam)
    if image_name is not None:
        cv2.rectangle(
            image,
            (image_bbox[0], image_bbox[1]),
            (image_bbox[0] + image_bbox[2], image_bbox[1] + image_bbox[3]),
            color, 2)
        cv2.putText(
            image,
            result_text,
            (image_bbox[0], image_bbox[1] - 5),
            cv2.FONT_HERSHEY_COMPLEX, 0.5*image.shape[0]/1024, color)

        format_ = os.path.splitext(image_name)[-1]
        result_image_name = image_name.replace(format_, "_result" + format_)
        cv2.imwrite(SAMPLE_IMAGE_PATH + result_image_name, image)
    
    return label


if __name__ == "__main__":
    desc = "test"
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument(
        "--device_id",
        type=int,
        default=0,
        help="which gpu id, [0/1/2/3]")
    parser.add_argument(
        "--model_dir",
        type=str,
        default="./resources/anti_spoof_models",
        help="model_lib used to test")
    parser.add_argument(
        "--image_name",
        type=str,
        default="C:/Users/renue/OneDrive/Desktop/project code/Python/Silent-Face-Anti-Spoofing-master/Silent-Face-Anti-Spoofing-master/images/sample/image_T1.jpg",
        help="image used to test")
    args = parser.parse_args()
    test(args.image_name, args.model_dir, args.device_id)
