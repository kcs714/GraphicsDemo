//
//  UIView+Redraw.m
//  AnimalTableDemo
//
//  Created by  kcs on 2018/1/23.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "UIView+Redraw.h"

@implementation UIView (Redraw)

- (UIImage *)captureLayer {
    return [self captureLayerInRect:self.bounds];
}

- (UIImage *)captureLayerInRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    [self.layer renderInContext:context];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
