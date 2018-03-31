//
//  ViewController.m
//  LCLScrollView
//
//  Created by lichanglai on 2018/3/31.
//  Copyright © 2018年 sankai. All rights reserved.
//

#import "ViewController.h"
#import "LCLScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *imageNames = @[@"IMG_9704.JPG",@"IMG_9709.JPG",@"IMG_9711.JPG",@"IMG_9712.JPG",@"IMG_9715.JPG",@"IMG_9717.JPG",@"IMG_9721.JPG",@"IMG_9726.JPG",@"IMG_9728.JPG"];
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < imageNames.count; i ++) {
        [images addObject:[UIImage imageNamed:imageNames[i]]];
    }
    
    LCLScrollView *scrollView = [[LCLScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.images = images;
    scrollView.isAutoScroll = YES;
    [self.view addSubview:scrollView];
    [scrollView build];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
