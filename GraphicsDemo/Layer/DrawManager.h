//
//  DrawManager.h
//  AnimalTableDemo
//
//  Created by  kcs on 2018/2/8.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPointValue(point) [NSValue valueWithCGPoint:point]

@interface DrawManager : NSObject

#pragma MARK - 基本设置

@property(nonatomic, assign)CGFloat lineWidth; //线宽
@property(nonatomic, assign)CGFloat dashMargin; //虚线间隔长度（如果画实线，传 0）
@property(nonatomic, strong)UIColor *drawColor; //绘制的颜色
@property(nonatomic, assign)CGPathDrawingMode drawMode; //绘制形式（描线 / 填充）

@property(nonatomic, assign)CGFloat fontSize; //文字大小
@property(nonatomic, strong)UIColor *fontColor; //文字颜色
@property(nonatomic, assign)NSTextAlignment textAlignment; //文字对齐方式
@property(nonatomic, assign)NSLineBreakMode lineBreakMode; //文字折断方式
@property(nonatomic, assign)CGFloat lineSpacing; //行间距
@property(nonatomic, assign)UIEdgeInsets edgeInset; //绘制的内边距

#pragma MARK - 绘制图片

/**
 绘制图片
 @param image 图片
 @param rect 绘制区域
 @param context 上下文
 */
- (void)drawImage:(UIImage *)image inRect:(CGRect)rect context:(CGContextRef)context;

/**
 绘制图片
 @param image 图片
 @param rect 绘制区域
 @param radius 圆角半径
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param context 上下文
 */
- (void)drawImage:(UIImage *)image inRect:(CGRect)rect radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor context:(CGContextRef)context;

#pragma MARK - 绘制文字

/**
 绘制文字
 @param string 文字
 @param rect 绘制区域
 */
- (void)drawText:(NSString *)string inRect:(CGRect)rect;

/**
 绘制文字
 @param string 文字
 @param fontSize 字体大小
 @param fontColor 字体颜色
 @param textAlignment 字体对齐方式
 @param lineSpacing 行间距
 @param rect 绘制区域
 @param edgeInset 内边距
 */
- (void)drawText:(NSString *)string fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor textAlignment:(NSTextAlignment)textAlignment lineSpacing:(CGFloat)lineSpacing inRect:(CGRect)rect edgeInset:(UIEdgeInsets)edgeInset;


#pragma MARK - 绘制图形

/**
 画线
 @param point1 起点
 @param point2 终点
 @param context 上下文
 */
- (void)drawLine:(CGPoint)point1 toPoint:(CGPoint)point2 context:(CGContextRef)context;

/**
 画线
 @param pointValues CGPoint 的 Value 数组（可使用宏：kPointValue(CGPoint)）
 @param dashMargin 虚线间隔长度（如果画实现，传 0）
 @param lineWidth 线宽
 @param lineColor 线颜色
 @param context 上下文
 */
- (void)drawLine:(NSArray<NSValue *> *)pointValues dashMargin:(CGFloat)dashMargin lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor context:(CGContextRef)context;

/**
 画圆
 @param center 圆心
 @param radius 半径
 @param context 上下文
 */
- (void)drawArc:(CGPoint)center radius:(CGFloat)radius context:(CGContextRef)context;

/**
 画椭圆
 @param rect 绘画区域
 @param context 上下文
 */
- (void)drawEllipseInRect:(CGRect)rect context:(CGContextRef)context;

/**
 画矩形
 @param rect 绘图区域
 @param radius 圆角半径
 @param context 上下文
 */
- (void)drawRect:(CGRect)rect radius:(CGFloat)radius context:(CGContextRef)context;

/**
 画矩形
 @param rect 绘图区域
 @param radiusX 圆角X轴方向的半径
 @param radiusY 圆角Y轴方向的半径
 @param context 上下文
 */
- (void)drawRect:(CGRect)rect radiusX:(CGFloat)radiusX radiusY:(CGFloat)radiusY context:(CGContextRef)context;

/**
 画圆环
 @param center 圆环中心
 @param radiusMax 大圆半径
 @param radiusMin 小圆半径
 @param color 颜色
 @param context 上下文
 */
- (void)drawArcRing:(CGPoint)center radiusMax:(CGFloat)radiusMax radiusMin:(CGFloat)radiusMin color:(UIColor *)color context:(CGContextRef)context;

/**
 画椭圆环
 @param rect 绘图区域
 @param insets 内边距（决定小椭圆的大小）
 @param color 颜色
 @param context 上下文
 */
- (void)drawEllipseRingInRect:(CGRect)rect edgeInsets:(UIEdgeInsets)insets color:(UIColor *)color context:(CGContextRef)context;

/**
 画矩形环
 @param rect 绘图区域
 @param insets 内边距（决定小矩形的大小）
 @param radiusX 圆角X轴方向的半径
 @param radiusY 圆角Y轴方向的半径
 @param color 颜色
 @param context 上下文
 */
- (void)drawRectRing:(CGRect)rect edgeInsets:(UIEdgeInsets)insets radiusX:(CGFloat)radiusX radiusY:(CGFloat)radiusY color:(UIColor *)color context:(CGContextRef)context;

/**
 线性渐变色
 @param startPoint 起点
 @param endPoint 终点
 @param rect 渐变区域
 @param startColor 起始颜色
 @param endColor 结束颜色
 @param context 上下文
 */
- (void)drawLinearGradien:(CGPoint)startPoint endPoint:(CGPoint)endPoint inRect:(CGRect)rect startColor:(UIColor *)startColor endColor:(UIColor *)endColor tcontext:(CGContextRef)context;

/**
 半径方向渐变
 @param startCenter 起始圆心
 @param startRadius 起始半径
 @param endCenter 结束圆心
 @param endRadius 结束半径
 @param rect 渐变区域
 @param startColor 起始颜色
 @param endColor 结束颜色
 @param context 上下文
 */
- (void)drawRadialGradien:(CGPoint)startCenter startRadius:(CGFloat)startRadius endCenter:(CGPoint)endCenter endRadius:(CGFloat)endRadius inRect:(CGRect)rect startColor:(UIColor *)startColor endColor:(UIColor *)endColor tcontext:(CGContextRef)context;


@end
