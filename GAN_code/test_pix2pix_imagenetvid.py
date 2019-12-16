import time
import os
import pdb
from options.test_options import TestOptions
from data.data_loader import CreateDataLoader
from models.models import create_model
from util.visualizer import Visualizer
from util import html
from PIL import Image
import torch
import collections
opt = TestOptions().parse()
opt.nThreads = 1   # test code only supports nThreads = 1
opt.batchSize = 1  # test code only supports batchSize = 1
opt.serial_batches = True  # no shuffle
opt.no_flip = True  # no flip
model = create_model(opt)

pathbase = '/home/lichao/tracking/datasets/ILSVRC2015_crops/Data/VID/train'
level1 = sorted(os.listdir(pathbase))
for folder1 in level1:
    level2 = sorted(os.listdir(os.path.join(pathbase, folder1)))    
    for folder2 in level2:    
        opt.dataroot = os.path.join(pathbase, folder1, folder2)
        data_loader = CreateDataLoader(opt)
        dataset = data_loader.load_data()
        visualizer = Visualizer(opt)
        # create website
        #web_dir = os.path.join(opt.results_dir, folder1, '%s_%s' % (opt.phase, opt.which_epoch))
        web_dir = os.path.join(opt.results_dir, folder1, folder2)
        #webpage = html.HTML(web_dir, 'Experiment = %s, Phase = %s, Epoch = %s' % (opt.name, opt.phase, opt.which_epoch))
        # test    
        for i, data in enumerate(dataset):
            
            model.set_input(data)            
            model.test()
            img_path = model.get_image_paths()
            resimg_path = img_path[0].replace('ILSVRC2015_crops','ILSVRC2015_crops_i'); resimg_path=resimg_path.replace('jpg','JPEG')
            if os.path.isfile(resimg_path):
                continue
            visuals0 = model.get_current_visuals()
            visuals1 = visuals0.items()
            visuals2 = [ii for ii in visuals1 if ii[0]=='fake_B']
            visuals = collections.OrderedDict(visuals2)
            print('%04d: process image... %s' % (i, img_path))
            visualizer.save_images(web_dir, visuals, img_path, aspect_ratio=[data['A_sz'][0][0],data['A_sz'][1][0]])
