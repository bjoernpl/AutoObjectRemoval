#!/bin/bash
cd ./FGVC/tool
conda activate $1
python video_completion.py \
       --mode object_removal \
       --path $2 \
       --path_mask $3 \
       --outroot $4 \
       --seamless
echo "done"