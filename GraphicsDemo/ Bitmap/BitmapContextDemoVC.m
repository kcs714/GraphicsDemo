//
//  BitmapContextDemoVC.m
//  GraphicsDemo
//
//  Created by  kcs on 2018/2/23.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "BitmapContextDemoVC.h"
#import "UIImage+GraphicsHandler.h"
#import "UIColor+Image.h"
#import "UIView+Redraw.h"

#define kScreenS [UIScreen mainScreen].bounds.size

@interface BitmapContextDemoVC ()

@property(nonatomic, strong)UIImageView *imgView;

@end

@implementation BitmapContextDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubviews];
}

- (void)setupSubviews {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    imgView.center = CGPointMake(kScreenS.width * 0.5, CGRectGetHeight(imgView.frame) * 0.5 + 70);
    imgView.layer.borderColor = [UIColor cyanColor].CGColor;
    imgView.layer.borderWidth = 2.0;
    self.imgView = imgView;
    [self.view addSubview:imgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + 5, kScreenS.width, 30)];
    lab.text = @"示例图片";
    lab.textColor = [UIColor redColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    UIButton *btn1 = [self getButton:CGRectMake(0, CGRectGetMaxY(lab.frame) + 20, kScreenS.width, 30) tag:1 title:@"截屏"];
    [self.view addSubview:btn1];
    UIButton *btn2 = [self getButton:CGRectMake(0, CGRectGetMaxY(btn1.frame) + 5, kScreenS.width, 30) tag:2 title:@"生成图片"];
    [self.view addSubview:btn2];
    UIButton *btn3 = [self getButton:CGRectMake(0, CGRectGetMaxY(btn2.frame) + 5, kScreenS.width, 30) tag:3 title:@"裁剪图片"];
    [self.view addSubview:btn3];
    UIButton *btn4 = [self getButton:CGRectMake(0, CGRectGetMaxY(btn3.frame) + 5, kScreenS.width, 30) tag:4 title:@"默认图片"];
    [self.view addSubview:btn4];
}

- (UIButton *)getButton:(CGRect)frame tag:(NSUInteger)tag title:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnEvent:(UIButton *)sender {
    if (sender.tag == 1) {
        self.imgView.image = [self.view captureLayer];
    } else if (sender.tag == 2) {
        self.imgView.image = [[UIColor purpleColor] generateImage:kScreenS];
    } else if (sender.tag == 3) {
        self.imgView.image = [self.imgView.image clipCornerWithRadius:100 edgeInsets:UIEdgeInsetsMake(50, 50, 50, 50) borderColor:[UIColor magentaColor]];
    } else if (sender.tag == 4) {
        self.imgView.image = [UIImage imageNamed:@"auto.jpg"];
    }
}

@end
