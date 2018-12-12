//
//  CustomizedDemoVC.m
//  GraphicsDemo
//
//  Created by  kcs on 2018/2/23.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "CustomizedDemoVC.h"
#import "CSImageView.h"

@interface CustomizedDemoVC ()

@end

@implementation CustomizedDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CSImageView *imgView = [[CSImageView alloc] initWithFrame:CGRectMake(50, 80, 200, 300)];
    [self.view addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"auto.jpg"];
}

@end
