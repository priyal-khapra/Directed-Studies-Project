import tensorflow as tf
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image
import numpy as np
import cv2

model = load_model('VGG16.h5')

# Path to your test image
img_path = 'test_image3.jpg' 

# Load the image and resize it to 224x224
img = image.load_img(img_path, target_size=(224, 224))

# Convert the image to an array
img_array = image.img_to_array(img)

# Expand dimensions to match model input shape: (1, 224, 224, 3)
img_array = np.expand_dims(img_array, axis=0)

# Normalize pixel values (0–255 → 0–1)
img_array = img_array / 255.0

predictions = model.predict(img_array)
print(predictions)
