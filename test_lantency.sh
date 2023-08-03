#!/bin/bash

export CUDA_VISIBLE_DEVICES=2
model_path=/root/paddlejob/workspace/output/lzc/vllm/open_llama_13b
num_iters=100

for bsz in 1 2 4 8 16; do
for input_len in 300; do
for output_len in 100; do
echo  "--bsz=$bsz --input_len=$input_len --output_len=$output_len"
# /work/liuzichang/nsight-systems/2022.1.1/bin/nsys profile --stats=true -t cuda --duration=4 --delay=50 -o EBCode_mp1_bf16_850_25.nsys-rep \
python benchmarks/benchmark_latency.py \
    --model ${model_path} \
    --input-len ${input_len} \
    --output-len ${output_len} \
    --batch-size ${bsz} \
    --num-iters ${num_iters}
done
done
done