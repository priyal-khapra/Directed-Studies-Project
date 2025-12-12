import torch
import cv2
import json
import os

# ------------------------------
# 1. Load model
# ------------------------------
model = torch.hub.load("ultralytics/yolov5", "yolov5s")

# Input image
img_path = "everyday_v_comp.jpeg"
# img_path = "../ESRGAN/results/everyday_comp_rlt.png"

# Output location (change this to wherever you want)
# OUTPUT_IMAGE = "everyday_output.jpeg"
# OUTPUT_JSON  = "everyday_output.json"

OUTPUT_IMAGE = "everyday_output_v_comp.jpeg"
OUTPUT_JSON  = "everyday_output_v_comp.json"


# ------------------------------
# 2. Run inference
# ------------------------------
results = model(img_path)

# ------------------------------
# 3. Extract predictions
# ------------------------------
preds = results.pandas().xyxy[0]

# Build metadata
output = []
for _, row in preds.iterrows():
    output.append({
        "class_name": row["name"],
        "confidence": float(row["confidence"])
    })

# ------------------------------
# 4. Manually save annotated image
# ------------------------------
# results.render() returns a list of images with bounding boxes drawn
annotated_img = results.render()[0]

# Save the annotated image to YOUR custom path
cv2.imwrite(OUTPUT_IMAGE, annotated_img)

# ------------------------------
# 5. Save JSON metadata
# ------------------------------
with open(OUTPUT_JSON, "w") as f:
    json.dump(output, f, indent=4)

print(f"Saved annotated image to: {OUTPUT_IMAGE}")
print(f"Saved detection metadata to: {OUTPUT_JSON}")
