//
//  PDFHandler.h
//  AnimalTableDemo
//
//  Created by  kcs on 2018/2/13.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PDFDrawer;

typedef void(^PageBlock)(PDFDrawer *drawer);


/**
 画图类
 */
@interface PDFDrawer : NSObject

@property(nonatomic, assign)CGFloat lineWidth; //线宽，默认0.5
@property(nonatomic, assign)CGFloat dashMargin; //虚线间隔长度，默认0，表示实线
@property(nonatomic, strong)UIColor *drawColor; //绘制的颜色，默认黑色
@property(nonatomic, assign)CGPathDrawingMode drawMode; //绘制形式（描线 / 填充）

@property(nonatomic, assign)CGFloat fontSize; //文字大小，默认15号字
@property(nonatomic, strong)UIColor *fontColor; //文字颜色，默认黑色

@property(nonatomic, assign, readonly)CGContextRef pdfContext; // PDF上下文

/**
 画线
 @param point1 起点
 @param point2 终点
 */
- (void)drawLine:(CGPoint)point1 toPoint:(CGPoint)point2;

/**
 画矩形
 @param rect 绘图区域
 @param radiusX 圆角X轴方向的半径
 @param radiusY 圆角Y轴方向的半径
 */

- (void)drawRect:(CGRect)rect radiusX:(CGFloat)radiusX radiusY:(CGFloat)radiusY;

/**
 画椭圆、圆
 @param rect 绘画区域
 */
- (void)drawEllipseInRect:(CGRect)rect;

/**
 画图片
 @param image 图片
 @param rect 绘制区域
 @param radius 图片圆角
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
- (void)drawImage:(UIImage *)image inRect:(CGRect)rect radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 画文字
 @param text 文字
 @param rect 绘制区域
 */
- (void)drawText:(NSString *)text inRect:(CGRect)rect;

/**
 添加 URL 跳转
 @param urlStr url字符串
 @param infoText 相关信息
 @param rect 添加的区域
 */
- (void)addURL:(NSString *)urlStr infoText:(NSString *)infoText inRect:(CGRect)rect;

/**
 设置目的地
 @param destName 目的地名称
 @param destPoint 目的点
 */
- (void)setDestination:(NSString *)destName destPoint:(CGPoint)destPoint;

/**
 设置点击跳转到目的地的区域
 @param destName 目的地名称
 @param infoText 相关信息
 @param destRect 可点击区域
 */
- (void)jumpToDestination:(NSString *)destName infoText:(NSString *)infoText destRect:(CGRect)destRect;

@end


/**
 PDF操作类
 */
@interface PDFHandler : NSObject

@property(nonatomic, copy)NSString *passWord; // 设置密码，默认无密码
@property(nonatomic, assign)BOOL canPrint; // 设置是否可以打印，默认可以
@property(nonatomic, assign)BOOL canCopy; // 设置是否可以复制，默认可以

/**
 初始化对象
 @param pageRect 区域，默认(0, 0, 374, 529)(对应于iPhone6s)
 @param path 存储路径
 @return 实例
 */
- (instancetype)initWithPageRect:(CGRect)pageRect path:(NSString *)path;

/**
 添加一页PDF
 @param pageInfo 附加的页面属性，使用最下面列出的 key
 @param pageBlock 内容填写回调
 @return 本对象
 */
- (PDFHandler *)addPage:(NSDictionary *)pageInfo pageBlock:(PageBlock)pageBlock;

/**
 生成 PDF 文档
 @param rect 区域
 @param path 存储路径
 @param pdfBlock 填写PDF内容回调
 */
+ (void)generatePDF:(CGRect)rect path:(NSString *)path pdfBlock:(PageBlock)pdfBlock;


// 设置页面属性所使用的 key
FOUNDATION_EXPORT NSString * const kPDFPageMediaBox;       //对应的value值是CGRect包装成NSValue
FOUNDATION_EXPORT NSString * const kPDFPageCropBox;        //对应的value值是CGRect包装成NSValue
FOUNDATION_EXPORT NSString * const kPDFPageBleedBox;       //对应的value值是CGRect包装成NSValue
FOUNDATION_EXPORT NSString * const kPDFPageTrimBox;        //对应的value值是CGRect包装成NSValue
FOUNDATION_EXPORT NSString * const kPDFPageArtBox;         //对应的value值是CGRect包装成NSValue
FOUNDATION_EXPORT NSString * const kPDFPageTitle;          //对应的value值是NSString
FOUNDATION_EXPORT NSString * const kPDFPageCreator;        //对应的value值是NSString

@end
