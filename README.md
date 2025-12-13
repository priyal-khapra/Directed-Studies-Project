## 📁 Directed Studies Project: ESRGAN for Computer Vision Integrity

This repository contains the code, models, and experimental results for a directed studies project investigating the impact of Enhanced Super-Resolution Generative Adversarial Networks (ESRGAN) on the integrity of downstream computer vision tasks (Image Classification and Object Detection).

The project focuses on using ESRGAN to restore low-resolution (LR) and heavily compressed images to high-resolution (HR), and subsequently analyzing how well this restoration preserves the features necessary for robust classification and detection.

-----

### 🌟 Key Project Goals

1.  **Implement ESRGAN:** Successfully set up and run a pre-trained ESRGAN model for $4\times$ image upscaling.
2.  **Classification Consistency:** Evaluate if ESRGAN-reconstructed images maintain the classification accuracy of an air pollution classifier (built on VGG16) when compared to original HR images.
3.  **Object Detection Integrity:** Quantify the effect of ESRGAN reconstruction on the detection performance (bounding box accuracy and confidence intervals) of a YOLOv5 object detector.

### 🛠️ Setup and Installation

The project primarily uses Python and PyTorch. It is highly recommended to use a machine with a CUDA-enabled NVIDIA GPU for timely execution.

#### 1\. Clone the Repository

```bash
git clone https://github.com/priyal-khapra/Directed-Studies-Project.git
cd Directed-Studies-Project
```

#### 2\. Environment Setup

Create and activate a virtual environment (recommended):

```bash
python -m venv venv
source venv/bin/activate  # On Linux/macOS
# venv\Scripts\activate   # On Windows
```

#### 3\. Install Dependencies

Install the required Python libraries. Ensure you install the correct PyTorch version compatible with your CUDA setup.

```bash
pip install torch torchvision torchaudio  # Adjust based on CUDA version
pip install opencv-python numpy pandas matplotlib
pip install tensorflow keras  # Required for the VGG16 Classification experiment
```

### 🧬 ESRGAN Super-Resolution Pipeline

This section details how to run the core super-resolution process.

#### 1\. Download Model Weights

Download the pre-trained ESRGAN model weights (`RRDB_ESRGAN_x4.pth`) and place them into the designated directory.

  * **Model:** `RRDB_ESRGAN_x4.pth` (Provides $4\times$ upscaling)
  * **Destination:** `ESRGAN/models/`

*(Link to model weights can typically be found in the original ESRGAN documentation or within the original project structure.)*

#### 2\. Run Inference

1.  Place your low-resolution (LR) or compressed images into the `ESRGAN/LR/` folder.

2.  Navigate to the `ESRGAN/` directory and run the test script:

    ```bash
    cd ESRGAN
    python test.py
    ```

3.  The super-resolved (SR) images will be saved in the `ESRGAN/results/` folder.

-----

### 🧪 Experiment 1: Pollution Classification

This experiment uses a VGG16-based classifier to check if the ESRGAN reconstruction preserves the subtle visual cues related to city air pollution.

  * **Model:** Sequential API with **VGG16** (Transfer Learning)
  * **Classes:** 6 air quality categories (`a_Good` to `f_Severe`)
  * **Code Location:** `experiments/exp1_classification/`

**Procedure Files:**

  * `train_classifier.py`: Script used to train the VGG16 model (achieved 95% test accuracy).
  * `classify_images.py`: Script to classify the three sets of images: Original HR, Compressed LR, and ESRGAN SR.
  * `data/`: Contains sample images used for testing across the categories.

-----

### 🔬 Experiment 2: Object Detection and Confidence Analysis

This experiment uses YOLOv5 to quantify the preservation of detection accuracy and confidence intervals after the compression and ESRGAN reconstruction cycle.

  * **Model:** **YOLOv5s** (COCO-pretrained)
  * **Metrics:** Bounding Box IoU, Confidence Score Difference ($\Delta\text{Conf}$)
  * **Code Location:** `experiments/exp2_object_detection/`

**Procedure Files:**

1.  **Detection Script:** Uses the official `detect.py` from the YOLOv5 repository (included or linked).
      * Run detection on the Original HR image and output to JSON.
      * Run detection on the ESRGAN SR image and output to JSON.
2.  **Analysis Script:**
      * `analyze_confidence.py`: Script to parse the two JSON output files, match corresponding detected objects, calculate IoU, and compute the $\Delta\text{Conf}$ for each object.

### 📝 Project Report

The complete, detailed project report, which includes a full analysis of the findings, acknowledgements, and references, is available in the root directory:

  * [`Project_Report_ESRGAN_Integrity.pdf`]([https://www.google.com/search?q=./Project_Report_ESRGAN_Integrity.pdf](https://drive.google.com/file/d/1gxnF6CO68JEU4_bNVRoWAYFkxFZBSjx8/view?usp=sharing))

### 🎓 Acknowledgement

This project was conducted under the direction of **Professor Duncan M. "Hank" Walker** (Texas A\&M University), whose expertise and guidance were instrumental to the project's success.
