#!/bin/bash
#SBATCH --export=ALL
#SBATCH --get-user-env=L
#SBATCH --job-name=Directed-Test
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16G
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --output=job.o%J
#SBATCH --error=job.e%J

echo "=============================="
echo " Job started on $(date)"
echo " Running on node: $(hostname)"
echo " SLURM_JOB_ID: $SLURM_JOB_ID"
echo "=============================="

# -------------------------------
# 1. Load required modules
# -------------------------------
module purge
module load intel-python/2022.1.0
module load CUDA/12.4.1

# -------------------------------
# 2. Activate your project venv
# -------------------------------
source /scratch/user/priyalkhapra/directed1/venv/bin/activate

# -------------------------------
# 3. (Optional) Configure cache and proxies
# -------------------------------
export HF_HOME=/scratch/user/priyalkhapra/hf_cache
export http_proxy="http://10.73.132.63:8080"
export https_proxy="http://10.73.132.63:8080"

# -------------------------------
# 4. Install dependencies (safe mode)
# -------------------------------
echo "[INFO] Ensuring dependencies are installed..."
pip install --upgrade pip
pip install --no-index --find-links=./wheels -r /scratch/user/priyalkhapra/directed/requirements.txt

# -------------------------------
# 5. Run ESRGAN processing first
# -------------------------------
# echo "=============================="
# echo "[INFO] Running ESRGAN/test.py ..."
# echo "=============================="
# cd /scratch/user/priyalkhapra/directed/ESRGAN || { echo "[ERROR] ESRGAN folder not found!"; exit 1; }

# start_time_esrgan=$(date +%s)
# python -u test.py
# exit_code_esrgan=$?
# end_time_esrgan=$(date +%s)
# duration_esrgan=$((end_time_esrgan - start_time_esrgan))

# printf "\n[ESRGAN] Completed with exit code %d in %d seconds\n" "$exit_code_esrgan" "$duration_esrgan"

# -------------------------------
# 6. Then run air_pollution processing
# -------------------------------
echo "=============================="
echo "[INFO] Running air_pollution/test.py ..."
echo "=============================="
cd /scratch/user/priyalkhapra/directed/air_pollution || { echo "[ERROR] air_pollution folder not found!"; exit 1; }

start_time_air=$(date +%s)
python -u test.py
exit_code_air=$?
end_time_air=$(date +%s)
duration_air=$((end_time_air - start_time_air))

printf "\n[air_pollution] Completed with exit code %d in %d seconds\n" "$exit_code_air" "$duration_air"

# -------------------------------
# 7. Final timing + summary
# -------------------------------
total_duration=$((duration_esrgan + duration_air))
hours=$((total_duration / 3600))
minutes=$(((total_duration % 3600) / 60))
seconds=$((total_duration % 60))

echo "=============================="
printf "[%s] All jobs completed.\n" "$(date)"
printf "Total runtime: %02d:%02d:%02d\n" "$hours" "$minutes" "$seconds"
echo "=============================="
