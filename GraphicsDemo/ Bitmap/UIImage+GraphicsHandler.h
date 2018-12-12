//
//  UIImage+GraphicsHandler.h
//  Advertisement
//
//  Created by  kcs on 2018/1/22.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GraphicsHandler)

/**
 重绘到指定大小
 @param size 指定的大小
 @return 新图片
 */
- (UIImage *)redrawInSize:(CGSize)size;

/**
 重绘到指定区域
 @param rect 指定的区域
 @return 新图片
 */
- (UIImage *)redrawInRect:(CGRect)rect;

/**
 切圆角
 @return 新图片（圆角半径是图片size的一半）
 */
- (UIImage *)clipCorner;

/**
 切圆角
 @param radius 圆角的半径
 @return 新图片
 */
- (UIImage *)clipCornerWithRadius:(CGFloat)radius;

/**
 切圆角
 @param radius 圆角的半径
 @param offset 圆心的偏移量
 @return 新图片
 */
- (UIImage *)clipCircleWithRadius:(CGFloat)radius centerOffset:(CGVector)offset;

/**
 切圆角
 @param radius 圆角半径
 @param insets 剪切区域的内边距
 @param color 边框颜色，不需要边框，传nil
 @return 新图片
 */
- (UIImage *)clipCornerWithRadius:(CGFloat)radius edgeInsets:(UIEdgeInsets)insets borderColor:(UIColor *)color;

/**
 裁剪图片
 @param path 裁剪的路径
 @param inside 是否裁剪path内部的区域
 @param color 边框颜色，不需要边框，传nil
 @return 新图片
 */
- (UIImage *)clipWithPath:(UIBezierPath *)path inside:(BOOL)inside borderColor:(UIColor *)color;

/**
 添加文本水印
 @param text 文本
 @param point 文本左上角位置
 @param attrDic 富文本属性
 @return 新图片
 */
- (UIImage *)addWaterText:(NSString *)text textPoint:(CGPoint)point attribute:(NSDictionary *)attrDic;

/**
 添加图片水印
 @param image 水印图片
 @param rect 水印绘制的区域
 @return 新图片
 */
- (UIImage *)addWaterImage:(UIImage *)image inRect:(CGRect)rect;

/**
 添加背景图片
 @param bgImage 背景图片
 @return 合成的图片
 */
- (UIImage *)addBackgroundImage:(UIImage *)bgImage;

@end
