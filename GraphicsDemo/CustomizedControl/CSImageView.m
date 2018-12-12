//
//  CSImageView.m
//  GraphicsDemo
//
//  Created by  kcs on 2018/2/23.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "CSImageView.h"

@implementation CSImageView


- (void)drawRect:(CGRect)rect {
    [_image drawInRect:rect];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self setNeedsDisplay];
}

@end
