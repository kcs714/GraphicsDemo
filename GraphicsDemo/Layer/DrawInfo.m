//
//  DrawInfo.m
//  AnimalTableDemo
//
//  Created by  kcs on 2018/2/8.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "DrawInfo.h"

@implementation DrawInfo

- (instancetype)init {
    if (self = [super init]) {
        _eventInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return self;
}

- (void)setDrawRect:(CGRect)drawRect {
    _drawRect = drawRect;
    _eventRect = CGRectMake(CGRectGetMinX(drawRect) - _eventInset.left, CGRectGetMinY(drawRect) - _eventInset.top, CGRectGetWidth(drawRect) + _eventInset.left + _eventInset.right, CGRectGetWidth(drawRect) + _eventInset.top + _eventInset.bottom);
}

@end
