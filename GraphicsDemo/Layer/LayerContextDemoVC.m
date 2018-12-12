//
//  LayerContextDemoVC.m
//  GraphicsDemo
//
//  Created by  kcs on 2018/2/14.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "LayerContextDemoVC.h"
#import "LayerContextTestView.h"

@interface LayerContextDemoVC ()

@property(nonatomic, strong)LayerContextTestView *testView;

@end

@implementation LayerContextDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    LayerContextTestView *testView = [[LayerContextTestView alloc] initWithFrame:CGRectMake(0, 64, 375, 500)];
    testView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:testView];
    self.testView = testView;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 600, 375, 30)];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"刷新数据" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnEvent:(UIButton *)event {
    [self.testView refresh:nil];
}

@end
