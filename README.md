![AutoObjectRemoval](https://socialify.git.ci/bjoernpl/AutoObjectRemoval/image?description=1&font=Inter&language=1&owner=1&pattern=Brick%20Wall&theme=Dark)
# AutoObjectRemoval

This system combines advances in instance segmentation ([Detectron2](https://github.com/facebookresearch/detectron2))
with recent advances in object removal ([Flow-edge Guided Video Completion](https://github.com/vt-vl-lab/FGVC))
by Gao et al. 2020.

It allows automatic removal of all objects included in the MS COCO dataset that the Detectron2 model was trained on.
This can be further extended by using any other object detection framework or other pretrained models. 

The benefit of this setup is to take the manual work out of the masking process. Where before each frame had to be 
meticulously masked, now Detectron2 does most of this work. If necessary, masks can always be manually edited before 
the object removal step.

## Example
Note that this is still WIP. Most likely in some frames player is still visible because the mask does not cover him entirely. I've added some
padding to the mask to get better coverage but results seemed only slightly better.        
<img src="https://github.com/bjoernpl/gifs/raw/main/original.gif" alt="Databay showcase gif" title="Databay showcase gif" width="300"/>
<img src="https://github.com/bjoernpl/gifs/raw/main/masks.gif" alt="Databay showcase gif" title="Databay showcase gif" width="300"/>
<img src="https://github.com/bjoernpl/gifs/raw/main/removed.gif" alt="Databay showcase gif" title="Databay showcase gif" width="300"/>

## Installation
This process takes a few steps for installing each of the recommended libraries. It uses two conda environments
because ``pytorch 0.4.0`` and ``pytorch 1.6.0``are both required.
#### Step 1. Prerequisites
- ``conda``
- ``python 3.6`` on `linux` is recommended.
- ``cuda 9.0`` is required for DeepFill compilation
- ``gcc & g++ >= 5`` are required for Detectron compilation
#### Step 2. Clone this repo
Clone this repo and the required submodules:
- [vt-vl-lab/FGVC](https://github.com/vt-vl-lab/FGVC)
- [nbei/Deep-Flow-Guided-Video-Inpainting](https://github.com/nbei/Deep-Flow-Guided-Video-Inpainting)
- [princeton-vl/Raft](https://github.com/princeton-vl/RAFT)

```
git clone --recursive git@github.com:bjoernpl/AutoObjectRemoval.git
```

#### Step 3. Install DFVI
Install everything here in a conda env named ``FGVC``.
```
conda create -n FGVC python=3.6
conda activate FGVC 
pip install -r ./DFVI/requirements.txt
bash ./DFVI/install_scripts.sh
conda deactivate
```
For more info on the installation and issues see 
[the DFVI repo](https://github.com/nbei/Deep-Flow-Guided-Video-Inpainting#install--requirements).
#### Step 4. Install raft
Install everything here in a conda env named ``raft``.
```
conda create --name raft python=3.6
conda activate raft
conda install pytorch=1.6.0 torchvision=0.7.0 cudatoolkit=10.1 -c pytorch
conda install matplotlib
conda install tensorboard
conda install scipy
conda install opencv
./RAFT/download_models.sh
```
For more info on this see the [RAFT repo](https://github.com/princeton-vl/RAFT#requirements).

#### Step 5. Install Detectron2 and other requirements
First you will need to create another env for the project requirements. I chose to use the already created
and activated env ``raft`` but this can also be a separate env.

First install requirements with:
```
pip install -r ./requirements.txt
```
Next install Detectron2 by following 
[their install guide](https://github.com/facebookresearch/detectron2/blob/master/INSTALL.md) or running:
```
python -m pip install 'git+https://github.com/facebookresearch/detectron2.git'
```

#### Done!
You can now run the demo notebook by running ``jupyter lab`` or `jupyter notebook` or using the IDE of your choice.

## Future work
Right now this can only be run by using the demo notebook but once I get the performance where I want it to be,
I'll make a script to run it directly from the command line or even as a library.

## References
Thanks to the creators of these projects and all contributors.


##### vt-vl-lab/FGVC
```
@inproceedings{Gao-ECCV-FGVC,
    author    = {Gao, Chen and Saraf, Ayush and Huang, Jia-Bin and Kopf, Johannes},
    title     = {Flow-edge Guided Video Completion},
    booktitle = {European Conference on Computer Vision},
    year      = {2020}
}
```
##### nbei/Deep-Flow-Guided-Video-Inpainting
```
@InProceedings{Xu_2019_CVPR,
    author = {Xu, Rui and Li, Xiaoxiao and Zhou, Bolei and Loy, Chen Change},
    title = {Deep Flow-Guided Video Inpainting},
    booktitle = {The IEEE Conference on Computer Vision and Pattern Recognition (CVPR)},
    month = {June},
    year = {2019}
}
```
##### princeton-vl/RAFT
```
@misc{teed2020raft,
      title={RAFT: Recurrent All-Pairs Field Transforms for Optical Flow}, 
      author={Zachary Teed and Jia Deng},
      year={2020},
      eprint={2003.12039},
      archivePrefix={arXiv},
      primaryClass={cs.CV}
}
```
##### facebookresearch/detectron2
```
@misc{wu2019detectron2,
  author =       {Yuxin Wu and Alexander Kirillov and Francisco Massa and
                  Wan-Yen Lo and Ross Girshick},
  title =        {Detectron2},
  howpublished = {\url{https://github.com/facebookresearch/detectron2}},
  year =         {2019}
}
```
