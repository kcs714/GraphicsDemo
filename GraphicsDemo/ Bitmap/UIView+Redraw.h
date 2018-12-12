//
//  UIView+Redraw.h
//  AnimalTableDemo
//
//  Created by  kcs on 2018/1/23.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Redraw)

/**
 截全屏
 @return 截屏图片
 */
- (UIImage *)captureLayer;

/**
 截屏指定区域
 @param rect 指定区域
 @return 截屏图片
 */
- (UIImage *)captureLayerInRect:(CGRect)rect;

@end
