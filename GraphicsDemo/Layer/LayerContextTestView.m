//
//  LayerContextTestView.m
//  GraphicsDemo
//
//  Created by  kcs on 2018/2/14.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "LayerContextTestView.h"

#define kScreenS [UIScreen mainScreen].bounds.size
#define kLeftMargin 15
#define kRightMargin 15

#define kColor_51 [UIColor colorWithWhite:51.0/255.0 alpha:1.0]
#define kColor_153 [UIColor colorWithWhite:153.0/255.0 alpha:1.0]
#define kColor_234 [UIColor colorWithWhite:234.0/255.0 alpha:1.0]
#define kColor_255_72_0 [UIColor colorWithRed:255.0/255.0 green:72.0/255.0 blue:0.0/255.0 alpha:1.0]

@interface LayerContextTestView()

@property(nonatomic, strong)DrawInfo *titleInfo;

@property(nonatomic, strong)DrawInfo *textInfo21;
@property(nonatomic, strong)DrawInfo *textInfo22;
@property(nonatomic, strong)DrawInfo *textInfo23;
@property(nonatomic, strong)DrawInfo *textInfo24;

@property(nonatomic, strong)DrawInfo *textInfo31;
@property(nonatomic, strong)DrawInfo *textInfo32;
@property(nonatomic, strong)DrawInfo *textInfo33;
@property(nonatomic, strong)DrawInfo *textInfo34;
@property(nonatomic, strong)DrawInfo *textInfo35;
@property(nonatomic, strong)DrawInfo *textInfo36;
@property(nonatomic, strong)DrawInfo *textInfo37;
@property(nonatomic, strong)DrawInfo *textInfo38;

@property(nonatomic, strong)DrawInfo *textInfo41;
@property(nonatomic, strong)DrawInfo *textInfo42;
@property(nonatomic, strong)DrawInfo *textInfo43;
@property(nonatomic, strong)DrawInfo *textInfo44;
@property(nonatomic, strong)DrawInfo *textInfo45;
@property(nonatomic, strong)DrawInfo *textInfo46;

@property(nonatomic, strong)DrawInfo *img1Info;
@property(nonatomic, strong)DrawInfo *img2Info;

@end

@implementation LayerContextTestView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.titleInfo = [DrawInfo new];
        
        self.textInfo21 = [DrawInfo new];
        self.textInfo22 = [DrawInfo new];
        self.textInfo23 = [DrawInfo new];
        self.textInfo24 = [DrawInfo new];
        
        self.textInfo31 = [DrawInfo new];
        self.textInfo32 = [DrawInfo new];
        self.textInfo33 = [DrawInfo new];
        self.textInfo34 = [DrawInfo new];
        self.textInfo35 = [DrawInfo new];
        self.textInfo36 = [DrawInfo new];
        self.textInfo37 = [DrawInfo new];
        self.textInfo38 = [DrawInfo new];
        
        self.textInfo41 = [DrawInfo new];
        self.textInfo42 = [DrawInfo new];
        self.textInfo43 = [DrawInfo new];
        self.textInfo44 = [DrawInfo new];
        self.textInfo45 = [DrawInfo new];
        self.textInfo46 = [DrawInfo new];
        
        self.img1Info = [DrawInfo new];
        self.img2Info = [DrawInfo new];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat titleHeight = 41.0;
    CGFloat minX = kLeftMargin, minY = titleHeight, width = kScreenS.width - kLeftMargin - kRightMargin, height = 324;
    CGFloat cellHeight1 = 48.0, cellHeight2 = 113.0;

    // 画线
    self.drawMag.lineWidth = 1.0;
    self.drawMag.drawColor = kColor_234;
    [self.drawMag drawRect:CGRectMake(minX, minY, width, height) radius:0 context:context];
    [self.drawMag drawLine:CGPointMake(minX + 72, minY) toPoint:CGPointMake(minX + 72, minY + height) context:context];
    [self.drawMag drawLine:CGPointMake(minX, minY+cellHeight1) toPoint:CGPointMake(minX+width, minY+cellHeight1) context:context];
    [self.drawMag drawLine:CGPointMake(minX, minY+cellHeight1*2) toPoint:CGPointMake(minX+width, minY+cellHeight1*2) context:context];
    [self.drawMag drawLine:CGPointMake(minX, minY+cellHeight1*2+cellHeight2) toPoint:CGPointMake(minX+width, minY+cellHeight1*2+cellHeight2) context:context];

    // 画文字
    // 画图片
    [super drawRect:rect];
}

- (void)refresh:(id)data {
    CGFloat titleHeight = 41.0;
    CGFloat minY = titleHeight;
    CGFloat cellHeight1 = 48.0, cellHeight2 = 113.0;
    
    CGFloat leftBase1 = kLeftMargin + 16;
    CGFloat leftBase2 = kLeftMargin + 86;
    CGFloat rightBase1 = kScreenS.width - 15 - 10;
    CGFloat topBase1 = minY + cellHeight1 * 2;
    CGFloat topBase2 = minY + cellHeight1 * 2 + cellHeight2;
    
    self.titleInfo.text = @"成人退改详情";
    self.titleInfo.drawRect = CGRectMake(kLeftMargin, 10, kScreenS.width - kLeftMargin - kRightMargin, 21);
    NSDictionary *textInfo1 = @{@"fontSize": @(15.0), @"fontColor": kColor_51, @"textAlignment": @(NSTextAlignmentLeft), @"drawInset": [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 0)] , @"textInfo": @[self.titleInfo]};
    
    self.textInfo21.text = @"航位";
    self.textInfo21.drawRect = CGRectMake(leftBase1, minY+15, 40, 18);
    self.textInfo22.text = @"票面价";
    self.textInfo22.drawRect = CGRectMake(leftBase1, minY+cellHeight1+15, 40, 18);
    self.textInfo23.text = @"票面价";
    self.textInfo23.drawRect = CGRectMake(leftBase1, topBase1 + 48, 40, 18);
    self.textInfo24.text = @"同舱改期费";
    self.textInfo24.drawRect = CGRectMake(leftBase1, topBase2 + 48, 40, 40);
    NSDictionary *textInfo2 = @{@"fontSize": @(13.0), @"fontColor": kColor_153, @"textAlignment": @(NSTextAlignmentCenter), @"drawInset": [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 0)] , @"textInfo": @[self.textInfo21, self.textInfo22, self.textInfo23, self.textInfo24]};
    
    self.textInfo31.text = @"经济舱（E）";
    self.textInfo31.drawRect = CGRectMake(leftBase2, minY+15, 110, 18);
    self.textInfo32.text = @"￥388（不含税）";
    self.textInfo32.drawRect = CGRectMake(leftBase2, minY+cellHeight1+15, 110, 18);
    self.textInfo33.text = @"起飞前两小时之内";
    self.textInfo33.drawRect = CGRectMake(leftBase2, topBase1 + 15, 110, 18);
    self.textInfo34.text = @"起飞前两小时之内";
    self.textInfo34.drawRect = CGRectMake(leftBase2, topBase1 + 48, 110, 18);
    self.textInfo35.text = @"起飞后";
    self.textInfo35.drawRect = CGRectMake(leftBase2, topBase1 + 81, 110, 18);
    self.textInfo36.text = @"起飞前两小时之内";
    self.textInfo36.drawRect = CGRectMake(leftBase2, topBase2 + 15, 110, 18);
    self.textInfo37.text = @"起飞前两小时之内";
    self.textInfo37.drawRect = CGRectMake(leftBase2, topBase2 + 48, 110, 18);
    self.textInfo38.text = @"起飞后";
    self.textInfo38.drawRect = CGRectMake(leftBase2, topBase2 + 81, 110, 18);
    NSDictionary *textInfo3 = @{@"fontSize": @(13.0), @"fontColor": kColor_51, @"textAlignment": @(NSTextAlignmentLeft), @"drawInset": [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 0)] , @"textInfo": @[self.textInfo31, self.textInfo32, self.textInfo33, self.textInfo34, self.textInfo35, self.textInfo36, self.textInfo37, self.textInfo38]};
    
    self.textInfo41.text = @"￥230/人（50%）";
    self.textInfo41.drawRect = CGRectMake(rightBase1-120, topBase1 + 15, 120, 18);
    self.textInfo42.text = @"只退机建燃油";
    self.textInfo42.drawRect = CGRectMake(rightBase1-120, topBase1 + 48, 120, 18);
    self.textInfo43.text = @"￥230/人（50%）";
    self.textInfo43.drawRect = CGRectMake(rightBase1-120, topBase1 + 81, 120, 18);
    self.textInfo44.text = @"￥230/人（50%）";
    self.textInfo44.drawRect = CGRectMake(rightBase1-120, topBase2 + 15, 120, 18);
    self.textInfo45.text = @"只退机建燃油";
    self.textInfo45.drawRect = CGRectMake(rightBase1-120, topBase2 + 48, 120, 18);
    self.textInfo46.text = @"￥230/人（50%）";
    self.textInfo46.drawRect = CGRectMake(rightBase1-120, topBase2 + 81, 120, 18);
    NSDictionary *textInfo4 = @{@"fontSize": @(13.0), @"fontColor": kColor_255_72_0, @"textAlignment": @(NSTextAlignmentRight), @"drawInset": [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 0)] , @"textInfo": @[self.textInfo41, self.textInfo42, self.textInfo43, self.textInfo44, self.textInfo45, self.textInfo46]};
    
    
    self.img1Info.image = [UIImage imageNamed:@"navMessage31"];;
    self.img1Info.drawRect = CGRectMake(kScreenS.width-15-30, 8.5, 24, 24);
    self.img2Info.image = [UIImage imageNamed:@"head8"];
    self.img2Info.drawRect = CGRectMake(kScreenS.width-15-80, 8.5, 24, 24);
    NSDictionary *imageInfo1 = @{@"radius": @(0.0), @"borderWidth": @(0.0), @"borderColor": [UIColor clearColor], @"imageInfo": @[self.img1Info]};
    NSDictionary *imageInfo2 = @{@"radius": @(8.0), @"borderWidth": @(0.5), @"borderColor": [UIColor greenColor], @"imageInfo": @[self.img2Info]};
    
    self.textDrawArr = @[textInfo1, textInfo2, textInfo3, textInfo4];
    self.imageDrawArr = @[imageInfo1, imageInfo2];
    
    [super refresh:data];
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [gesture locationInView:gesture.view];
        if (CGRectContainsPoint(self.img1Info.eventRect, point)) {
            NSLog(@">>>>>> img1Info clicked");
        } else if (CGRectContainsPoint(self.img2Info.eventRect, point)) {
            NSLog(@">>>>>> img2Info clicked");
        }
    }
}

@end
