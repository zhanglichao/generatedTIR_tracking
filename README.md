# Synthetic data generation for end-to-end thermal infrared tracking

# Abstract: 
The usage of both off-the-shelf and end-to-end trained deep networks have significantly improved performance of visual tracking on RGB videos. However, the lack of large labeled datasets hampers the usage of convolutional neural networks for tracking in thermal infrared (TIR) images. Therefore, most state of the art methods on tracking for TIR data are still based on handcrafted features. To address this problem, we propose to use image-to-image translation models. These models allow us to translate the abundantly available labeled RGB data to synthetic TIR data. We explore both the usage of paired and unpaired image translation models for this purpose. These methods provide us with a large labeled dataset of synthetic TIR sequences, on which we can train end-to-end optimal features for tracking. To the best of our knowledge we are the first to train end-to-end features for TIR tracking.
We perform extensive experiments on VOT-TIR2017 dataset. We show that a network trained on a large dataset of synthetic TIR data obtains better performance than one trained on the available real TIR data. Combining both data sources leads to further improvement. In addition, when we combine the network with motion features we outperform the state of the art with a relative gain of over 10\%, clearly showing the efficiency of using synthetic data to train end-to-end TIR trackers.


# Instructions

- Average activation of filters from the first layer of pre-trained AlexNet on the test set of KAIST [1] for RGB and TIR images :
<br>
<p align="center"><img width="60%" height='50%'src="aar.png" /></p>


- Histogram of the gradient magnitude for real and synthetic TIR data computed on the test set of KAIST[1] :
<br>
<p align="center"><img width="50%" height='50%'src="histgrad.png" /></p>



- Download generated models:

[pix2pix model](https://drive.google.com/file/d/1qSISMRN6w9EUUGz2-FQIVUCxRKphy-Ra/view?usp=sharing)

[Cyclegan model A](https://drive.google.com/file/d/1CdhjXZvFUvzuJbt6RyKxlMuKOLYlL6ex/view?usp=sharing); 
[Cyclegan model B](https://drive.google.com/file/d/1N3mFsiSwCjUrBfy7nNCejhK0bYmvCtyJ/view?usp=sharing)

- Download fine-tuned models:

[VGG model](https://drive.google.com/file/d/1J_jl6DMRL0f503TOwRKHOsNH6DnJYyqM/view?usp=sharing)

[ResNet model](https://drive.google.com/file/d/1gdcd1OSfz8LnOjea3AtYqp9UTtn61EST/view?usp=sharing)





## References
[1] Hwang, Soonmin and Park, Jaesik and Kim, Namil and Choi, Yukyung and So Kweon, In.  
    Multispectral pedestrian detection: Benchmark dataset and baseline.  
    In Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2015.  
    



# Contact
If you run into any problems with this code, please submit a bug report on the Github site of the project. For another inquries pleace contact with me: lichao@cvc.uab.es
