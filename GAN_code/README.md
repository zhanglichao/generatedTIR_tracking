
## examplar command for testing on GOT-10k dataset

python test_pix2pix_got.py --dataroot /home/lichao/tracking/datasets/GOT-10k/train --name thermal_pix2pix_1ch_all_batch4 --model test --dataset_mode single --which_model_netG unet_256 --which_direction AtoB --norm batch --how_many 10000000 --which_epoch 25 --results_dir /home/lichao/tracking/datasets/GOT-10k_i/train --output_nc 1 --no_dropout --loadSize 256 --gpu_ids 1



## reference

```
The original project is in the website[https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix].
```
