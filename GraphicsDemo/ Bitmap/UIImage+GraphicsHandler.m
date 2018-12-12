//
//  UIImage+GraphicsHandler.m
//  Advertisement
//
//  Created by  kcs on 2018/1/22.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "UIImage+GraphicsHandler.h"

@implementation UIImage (GraphicsHandler)

- (UIImage *)redrawInSize:(CGSize)size {
    return [self redrawInRect:CGRectMake(0, 0, size.width, size.height)];
}

- (UIImage *)redrawInRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [[UIScreen mainScreen] scale]);
    [self drawInRect:rect];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

- (UIImage *)clipCorner {
    return [self clipCornerWithRadius:self.size.width * 0.5];
}

- (UIImage *)clipCornerWithRadius:(CGFloat)radius {
    return [self clipCornerWithRadius:radius edgeInsets:UIEdgeInsetsZero borderColor:nil];
}

- (UIImage *)clipCircleWithRadius:(CGFloat)radius centerOffset:(CGVector)offset {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0.5 * self.size.width + offset.dx, 0.5 * self.size.height + offset.dy) radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    return [self clipWithPath:path inside:NO borderColor:nil];
}

- (UIImage *)clipCornerWithRadius:(CGFloat)radius edgeInsets:(UIEdgeInsets)insets borderColor:(UIColor *)color {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(insets.left, insets.top, self.size.width - insets.left - insets.right, self.size.height - insets.top - insets.bottom) cornerRadius:radius];
    path.lineWidth = 5;
    return [self clipWithPath:path inside:NO borderColor:color];
}

- (UIImage *)clipWithPath:(UIBezierPath *)path inside:(BOOL)inside borderColor:(UIColor *)color {
    if (!path) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextSaveGState(context);
    if (inside) {
        CGContextTranslateCTM(context, 0, self.size.height);
        CGContextScaleCTM(context, 1, -1);
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextTranslateCTM(context, 0, self.size.height);
        CGContextScaleCTM(context, 1, -1);
        CGContextAddPath(context, path.CGPath);
        CGContextClip(context);
        CGContextClearRect(context, rect);
    } else {
        CGContextAddPath(context, path.CGPath);
        CGContextClip(context);
        CGContextTranslateCTM(context, 0, self.size.height);
        CGContextScaleCTM(context, 1, -1);
        CGContextDrawImage(context, rect, self.CGImage);
    }
    CGContextRestoreGState(context);
    if (color != nil) {
        CGContextSetLineCap(context, path.lineCapStyle);
        CGContextSetLineWidth(context, path.lineWidth);
        CGContextSetAllowsAntialiasing(context, true); //保真，消除叠加
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextBeginPath(context);
        CGContextAddPath(context, path.CGPath);
        CGContextStrokePath(context);
    }
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)addWaterText:(NSString *)text textPoint:(CGPoint)point attribute:(NSDictionary *)attrDic {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [text drawAtPoint:point withAttributes:attrDic];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)addWaterImage:(UIImage *)image inRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)addBackgroundImage:(UIImage *)bgImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [bgImage drawInRect:rect];
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
