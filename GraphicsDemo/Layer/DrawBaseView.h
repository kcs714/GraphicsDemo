//
//  DrawBaseView.h
//  AnimalTableDemo
//
//  Created by  kcs on 2018/2/8.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawInfo.h"
#import "DrawManager.h"

@interface DrawBaseView : UIView

/**
 绘图管理者
 */
@property(nonatomic, strong, readonly)DrawManager *drawMag;

/**
 绘制文字信息
 @[
     @{@"fontSize": @(13.0), @"fontColor": [UIColor blackColor], @"textAlignment": @(NSTextAlignmentCenter), @"drawInset": UIEdgeInsetsMake(2, 0, 2, 0), @"textInfo": @[DrawInfo *]}
 ]
 */
@property(nonatomic, strong)NSArray<NSDictionary *> *textDrawArr;

/**
 绘制图片信息
 @[
     @{@"radius": @(5.0), @"borderWidth": @(1.0), @"borderColor": [UIColor redColor], @"imageInfo": @[DrawInfo *]}
 ]
 */
@property(nonatomic, strong)NSArray<NSDictionary *> *imageDrawArr;

/**
 刷新数据（子类重写，并调用[super refresh:data]）
 @param data 数据
 */
- (void)refresh:(id)data;

/**
 点击事件（子类重写）
 @param gesture 手势UITapGestureRecognizer
 */
- (void)tapGesture:(UITapGestureRecognizer *)gesture;

@end
