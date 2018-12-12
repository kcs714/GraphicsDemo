//
//  UIColor+Image.m
//  AnimalTableDemo
//
//  Created by  kcs on 2018/1/23.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "UIColor+Image.h"

@implementation UIColor (Image)

- (UIImage *)generateImage:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
