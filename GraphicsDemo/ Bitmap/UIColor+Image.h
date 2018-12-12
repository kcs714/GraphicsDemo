//
//  UIColor+Image.h
//  AnimalTableDemo
//
//  Created by  kcs on 2018/1/23.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Image)

/**
 生成图片
 @param size 大小
 @return 图片
 */
- (UIImage *)generateImage:(CGSize)size;

@end
