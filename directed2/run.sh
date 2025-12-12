#!/bin/bash
#SBATCH --job-name=Directed-Test
#SBATCH --output=job.o%J
#SBATCH --error=job.e%J
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16G
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1

echo "=============================="
echo " Job started on $(date)"
echo " Running on node: $(hostname)"
echo "=============================="

module purge
module load CUDA/12.4.1

echo "[INFO] Activating conda environment..."
source /sw/eb/sw/Miniconda3/23.10.0-1/etc/profile.d/conda.sh
conda activate /scratch/user/priyalkhapra/.conda/envs/yolo_2

echo "[INFO] Using Python: $(which python)"
echo "[INFO] Using Pip:    $(which pip)"

# echo "[INFO] Checking PyTorch..."
# python -c "import torch; print('Torch version:', torch.__version__); print('CUDA available:', torch.cuda.is_available()); print('GPU:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'None')"

echo "[INFO] Running yolo..."
cd /scratch/user/priyalkhapra/directed2/yolov5 || exit 1
python -u detect_test.py

echo "[INFO] Job finished on $(date)"
