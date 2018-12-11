## Synthetic data generation for end-to-end TIR tracking [[paper]](https://arxiv.org/pdf/1806.01013.pdf)

## Instructions
This project is to transfer RGB tracking videos to TIR tracking videos in order to complement the TIR data for training. 
We give two kind of models corresponding for two-stage of our porject (The generated model training stage and tracker fine-tuning stage).


## Analysis for RGB and TIR
<br>
<p align="center"><img width="100%" height='100%'src="Ganres.png" /></p>

- Average activation of filters from the first layer of pre-trained AlexNet on the test set of KAIST [1] for RGB and TIR images :
<br>
<p align="center"><img width="40%" height='40%'src="aar.png" /></p> <p align="center"><img width="30%" height='30%'src="histgrad.png" /></p>

- Histogram of the gradient magnitude for real and synthetic TIR data computed on the test set of KAIST[1] :


## Models
- Download generated models:

    [pix2pix model](https://drive.google.com/file/d/1qSISMRN6w9EUUGz2-FQIVUCxRKphy-Ra/view?usp=sharing)

    [CycleGAN model A](https://drive.google.com/file/d/1CdhjXZvFUvzuJbt6RyKxlMuKOLYlL6ex/view?usp=sharing); 
    [CycleGAN model B](https://drive.google.com/file/d/1N3mFsiSwCjUrBfy7nNCejhK0bYmvCtyJ/view?usp=sharing)

- Video examples for transferred models (from left to right: RGB, ground-truth, pix2pix, CycleGAN) :

    [Video](https://drive.google.com/file/d/1kGoH4qfOcOpHQHxNr4tucGK4LCT-AzLi/view?usp=sharing)


- Download fine-tuned models:

    [VGG model](https://drive.google.com/file/d/1J_jl6DMRL0f503TOwRKHOsNH6DnJYyqM/view?usp=sharing)

    [ResNet model](https://drive.google.com/file/d/1gdcd1OSfz8LnOjea3AtYqp9UTtn61EST/view?usp=sharing)



## References
[1] Hwang, Soonmin and Park, Jaesik and Kim, Namil and Choi, Yukyung and So Kweon, In.  
    Multispectral pedestrian detection: Benchmark dataset and baseline.  
    In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2015.  
    



## Contact
For further inquries please contact with me: lichao@cvc.uab.es. Or submit a bug report on the Github site of the project.
