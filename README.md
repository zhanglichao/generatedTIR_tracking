## Synthetic data generation for end-to-end TIR tracking [[paper]](https://arxiv.org/pdf/1806.01013.pdf)

## Citation
Please cite our paper if you are inspired by this idea.

```
@article{zhang2018synthetic,
  title={Synthetic data generation for end-to-end thermal infrared tracking},
  author={Zhang, Lichao and Gonzalez-Garcia, Abel and van de Weijer, Joost and Danelljan, Martin and Khan, Fahad Shahbaz},
  journal={IEEE Transactions on Image Processing},
  volume={28},
  number={4},
  pages={1837--1850},
  year={2018},
  publisher={IEEE}
}
```
## Instructions
This project is to transfer RGB tracking videos to TIR tracking videos in order to complement the TIR data for training. 
We give two kinds of models corresponding for two-stage of our porject (The transferring stage and the fine-tuning stage).


## Analysis for RGB and TIR
<br>
<p align="center">
  <img width="80%" height='80%'src="Ganres.png" />
</p>
<p align="center">
  <em>Results for the two image translation methods considered: pix2pix and CycleGAN. On the test set of KAIST[1].</em>
</p>


<br>
<p align="center">
  <img src="/aar.png" width="40%" />
  <img src="/histgrad.png" width="35%" />
</p>
<p align="center">
  <em>The left is the Average activation of filters from the first layer of pre-trained AlexNet. The right is the Histogram of the gradient magnitude for real and synthetic TIR data.</em>
</p>


## Models
- Download generated models:

    The unifid project for both pix2pix and CycleGAN is in the [link](https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix).

    [pix2pix model](https://drive.google.com/file/d/1qSISMRN6w9EUUGz2-FQIVUCxRKphy-Ra/view?usp=sharing)

    [CycleGAN model A](https://drive.google.com/file/d/1CdhjXZvFUvzuJbt6RyKxlMuKOLYlL6ex/view?usp=sharing); 
    [CycleGAN model B](https://drive.google.com/file/d/1N3mFsiSwCjUrBfy7nNCejhK0bYmvCtyJ/view?usp=sharing)

- Video examples for transferred models (from left to right: RGB, ground-truth, pix2pix, CycleGAN) :

    [Video](https://drive.google.com/file/d/1kGoH4qfOcOpHQHxNr4tucGK4LCT-AzLi/view?usp=sharing)


- Download fine-tuned models (after download, put them in the file ECO_tir/feature_extraction/networks):

    [VGG model](https://drive.google.com/file/d/1J_jl6DMRL0f503TOwRKHOsNH6DnJYyqM/view?usp=sharing)

    [ResNet model](https://drive.google.com/file/d/1gdcd1OSfz8LnOjea3AtYqp9UTtn61EST/view?usp=sharing)

## Results
- Download results to compare:

    [VGG result](https://drive.google.com/file/d/1gqJzaFPNX2rB7f907B8uzU691bi8cy82/view?usp=sharing)

    [ResNet result](https://drive.google.com/file/d/1bY0Rl8CXO8PmU8PzoZxrnYvu7QkbYvrF/view?usp=sharing)

## References
[1] Hwang, Soonmin and Park, Jaesik and Kim, Namil and Choi, Yukyung and So Kweon, In.  
    Multispectral pedestrian detection: Benchmark dataset and baseline.  
    In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2015.  
    



## Contact
For further inquries please contact with me: lichao@cvc.uab.es. Or submit a bug report on the Github site of the project.
