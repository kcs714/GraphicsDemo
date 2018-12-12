//
//  DrawBaseView.m
//  AnimalTableDemo
//
//  Created by  kcs on 2018/2/8.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "DrawBaseView.h"

@interface DrawBaseView()

@property(nonatomic, strong)DrawManager *drawMag;

@end

@implementation DrawBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.drawMag = [DrawManager new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 画文字
    for (NSDictionary *infoDic in self.textDrawArr) {
        self.drawMag.fontSize = [infoDic[@"fontSize"] floatValue];
        self.drawMag.fontColor = infoDic[@"fontColor"];
        self.drawMag.textAlignment = [infoDic[@"textAlignment"] integerValue];
        NSValue *insetValue = infoDic[@"drawInset"];
        self.drawMag.edgeInset = insetValue.UIEdgeInsetsValue;
        for (DrawInfo *info in infoDic[@"textInfo"]) {
            [self.drawMag drawText:info.text inRect:info.drawRect];
        }
    }
    // 画图片
    for (NSDictionary *infoDic in self.imageDrawArr) {
        CGFloat radius = [infoDic[@"radius"] floatValue];
        CGFloat borderWidth = [infoDic[@"borderWidth"] floatValue];
        UIColor *borderColor = infoDic[@"borderColor"];
        borderColor = borderColor != nil ? borderColor : [UIColor clearColor];
        for (DrawInfo *info in infoDic[@"imageInfo"]) {
            if (info.image) {
                [self.drawMag drawImage:info.image inRect:info.drawRect radius:radius borderWidth:borderWidth borderColor:borderColor context:context];
            }
        }
    }
}

- (void)refresh:(id)data {
    [self setNeedsDisplay];
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture {
}

@end
