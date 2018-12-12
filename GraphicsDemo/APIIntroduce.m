//
//  APIIntroduce.m
//  GraphicsDemo
//
//  Created by  kcs on 2018/2/22.
//  Copyright © 2018年 KCS. All rights reserved.
//  API 介绍

#import <Foundation/Foundation.h>

/******************************************************/
/******************** UIGraphics.h ********************/

// 获取当前栈顶的图层上下文(返回 not retained 对象)
CGContextRef __nullable UIGraphicsGetCurrentContext(void)
// 图层上下文入栈
void UIGraphicsPushContext(CGContextRef context)
// 图层上下文出栈
void UIGraphicsPopContext(void)
// 在当前图层上下文中填充指定的矩形区域，可以指定填充模式
void UIRectFillUsingBlendMode(CGRect rect, CGBlendMode blendMode)
// 在当前图形上下文中，用填充颜色和 kCGBlendModeCopy 混合模式来填充指定区域
void UIRectFill(CGRect rect)
// 绘制一个矩形框，可以指定绘制模式
void UIRectFrameUsingBlendMode(CGRect rect, CGBlendMode blendMode)
// 用填充颜色和 kCGBlendModeCopy 混合模式绘制一个矩形框
void UIRectFrame(CGRect rect)
// 剪切矩形区域内的路径
void UIRectClip(CGRect rect)


//>>> 位图上下文

// 开启位图上下文
void UIGraphicsBeginImageContext(CGSize size)
// 开启位图上下文
void UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)
// 获取位图上下文中绘制的图片
UIImage * __nullable UIGraphicsGetImageFromCurrentImageContext(void)
// 关闭位图上下文
void UIGraphicsEndImageContext(void)


//>>> PDF上下文

// 开启 PDF上下文，path：PDF存储的路径，bounds：绘制的区域，documentInfo：PDF配置
BOOL UIGraphicsBeginPDFContextToFile(NSString *path, CGRect bounds, NSDictionary * __nullable documentInfo)
// 开启 PDF上下文，data：存储的路径，bounds：绘制的区域，documentInfo：PDF配置
void UIGraphicsBeginPDFContextToData(NSMutableData *data, CGRect bounds, NSDictionary * __nullable documentInfo)
// 关闭 PDF上下文
void UIGraphicsEndPDFContext(void)
// 开启一个 PDF page，page 有默认大小
void UIGraphicsBeginPDFPage(void)
// 开启一个 PDF page，可以对 page 的大小进行编辑，也可以设置其它属性
void UIGraphicsBeginPDFPageWithInfo(CGRect bounds, NSDictionary * __nullable pageInfo)
// 获取上下文的可绘制区域
CGRect UIGraphicsGetPDFContextBounds(void)
// 指定区域设置 url 链接，即点击此区域可以跳转到对应的链接
void UIGraphicsSetPDFContextURLForRect(NSURL *url, CGRect rect)
// 设置当跳转到本页时要显示的点
void UIGraphicsAddPDFContextDestinationAtPoint(NSString *name, CGPoint point)
// 设置当跳转到本页时要显示的区域
void UIGraphicsSetPDFContextDestinationForRect(NSString *name, CGRect rect)


/*****************************************************/
/******************** CGContext.h ********************/

//>>> 管理图形上下文

// 保存当前上下文的绘制状态
void CGContextSaveGState(CGContextRef cg_nullable c)
// 还原上次保存的上下文的绘制状态
void CGContextRestoreGState(CGContextRef cg_nullable c)
// 获取上下文 ID
CFTypeID CGContextGetTypeID(void)
// 图形上下文的引用计数+1
CGContextRef cg_nullable CGContextRetain(CGContextRef cg_nullable c)
// 图形上下文的引用计数-1
void CGContextRelease(CGContextRef cg_nullable c)
// 强制所有挂起的绘图操作在一个窗口上下文中立即被渲染到目标设备
void CGContextFlush(CGContextRef cg_nullable c)
// 将一个窗口的图像上下文内容更新，即所有的绘图操作都会在下次同步到窗口上
void CGContextSynchronize(CGContextRef cg_nullable c)
// 开始一个透明层，auxiliaryInfo：一般传NULL
void CGContextBeginTransparencyLayer(CGContextRef cg_nullable c, CFDictionaryRef __nullable auxiliaryInfo)
// 开始一个指定区域的透明层，auxiliaryInfo：一般传NULL
void CGContextBeginTransparencyLayerWithRect(CGContextRef cg_nullable c, CGRect rect, CFDictionaryRef __nullable auxInfo)
// 结束透明层
void CGContextEndTransparencyLayer(CGContextRef cg_nullable c)


//>>> CTM变换

// 上下文作缩放变换，sx：X轴的缩放系数， sy：Y轴的缩放系数
void CGContextScaleCTM(CGContextRef cg_nullable c, CGFloat sx, CGFloat sy)
// 上下文作偏移变换，tx：X轴的偏移量， ty：Y轴的偏移量
void CGContextTranslateCTM(CGContextRef cg_nullable c, CGFloat tx, CGFloat ty)
// 上下文作旋转变换，angle：旋转的角度
void CGContextRotateCTM(CGContextRef cg_nullable c, CGFloat angle)
// 上下文合并一个变换，transform：2D变换
void CGContextConcatCTM(CGContextRef cg_nullable c, CGAffineTransform transform)
// 获取上下文的变换
CGAffineTransform CGContextGetCTM(CGContextRef cg_nullable c)


//>>> 设置路径的绘制状态

// 设置线宽
void CGContextSetLineWidth(CGContextRef cg_nullable c, CGFloat width)
// 设置线帽样式
void CGContextSetLineCap(CGContextRef cg_nullable c, CGLineCap cap)
// 设置线的联接点样式
void CGContextSetLineJoin(CGContextRef cg_nullable c, CGLineJoin join)
// 设置连接线的斜接限制
void CGContextSetMiterLimit(CGContextRef cg_nullable c, CGFloat limit)
// 设置虚线的样式，phase：从第几个点开始画起，lengths：虚线的样式 [10,5]表示每隔5个点就画一条长度为10的线，count：lengths数组的长度
void CGContextSetLineDash(CGContextRef cg_nullable c, CGFloat phase, const CGFloat * __nullable lengths, size_t count)
// 设置弯曲的路径中的图形上下文的准确性
void CGContextSetFlatness(CGContextRef cg_nullable c, CGFloat flatness)
// 设置透明度
void CGContextSetAlpha(CGContextRef cg_nullable c, CGFloat alpha)
// 设置叠加状态
void CGContextSetBlendMode(CGContextRef cg_nullable c, CGBlendMode mode)
// 设置填充颜色
void CGContextSetFillColorWithColor(CGContextRef cg_nullable c, CGColorRef cg_nullable color)
// 设置描边颜色
void CGContextSetStrokeColorWithColor(CGContextRef cg_nullable c, CGColorRef cg_nullable color)
// 设置填充的颜色通道，space：颜色通道
void CGContextSetFillColorSpace(CGContextRef cg_nullable c, CGColorSpaceRef cg_nullable space)
// 设置描边的颜色通道，space：颜色通道
void CGContextSetStrokeColorSpace(CGContextRef cg_nullable c, CGColorSpaceRef cg_nullable space)
// 设置填充颜色，components：填充颜色的 RGBA 值
void CGContextSetFillColor(CGContextRef cg_nullable c, const CGFloat * cg_nullable components)
// 设置描边颜色，components：描边颜色的 RGBA 值
void CGContextSetStrokeColor(CGContextRef cg_nullable c, const CGFloat * cg_nullable components)
// 设置填充图案模式，pattern：填充图案模式，components：描边颜色的 RGBA 值
void CGContextSetFillPattern(CGContextRef cg_nullable c, CGPatternRef cg_nullable pattern, const CGFloat * cg_nullable components)
// 设置描边图案模式，pattern：描边图案模式，components：描边颜色的 RGBA 值
void CGContextSetStrokePattern(CGContextRef cg_nullable c, CGPatternRef cg_nullable pattern, const CGFloat * cg_nullable components)
// 设置图案模式的平铺范围，防止铺设一半的情况
void CGContextSetPatternPhase(CGContextRef cg_nullable c, CGSize phase)
// 设置填充颜色，依赖灰度颜色空间，gray：灰度，alpha：透明度
void CGContextSetGrayFillColor(CGContextRef cg_nullable c, CGFloat gray, CGFloat alpha)
// 设置描边颜色，依赖灰度颜色空间，gray：灰度，alpha：透明度
void CGContextSetGrayStrokeColor(CGContextRef cg_nullable c, CGFloat gray, CGFloat alpha)
// 设置填充颜色，依赖RGBA的颜色空间
void CGContextSetRGBFillColor(CGContextRef cg_nullable c, CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
// 设置描边颜色，依赖RGBA的颜色空间
void CGContextSetRGBStrokeColor(CGContextRef cg_nullable c, CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
// 设置填充颜色，依赖CMYK颜色空间
void CGContextSetCMYKFillColor(CGContextRef cg_nullable c, CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha)
// 设置描边颜色，依赖CMYK颜色空间
void CGContextSetCMYKStrokeColor(CGContextRef cg_nullable c, CGFloat cyan, CGFloat magenta, CGFloat yellow, CGFloat black, CGFloat alpha)
// 设置渲染模式，intent：渲染模式（如：饱和度匹配），枚举值
void CGContextSetRenderingIntent(CGContextRef cg_nullable c, CGColorRenderingIntent intent)


//>>> 构建路径

// 从新构建路径
void CGContextBeginPath(CGContextRef cg_nullable c)
// 移到某一点，准备画线
void CGContextMoveToPoint(CGContextRef cg_nullable c, CGFloat x, CGFloat y)
// 画线，从当前点画到新传入的点，x：点的X值， y：点的Y值
void CGContextAddLineToPoint(CGContextRef cg_nullable c, CGFloat x, CGFloat y)
// 画贝塞尔三次曲线，cp1x/cp1y：控制点1的X/Y坐标， cp2x/cp2y：控制点2的X/Y坐标， x/y：终点的X/Y坐标
void CGContextAddCurveToPoint(CGContextRef cg_nullable c, CGFloat cp1x, CGFloat cp1y, CGFloat cp2x, CGFloat cp2y, CGFloat x, CGFloat y)
// 画贝塞尔二次曲线，cpx/cpy：控制点的X/Y坐标，x/y：终点的X/Y坐标
void CGContextAddQuadCurveToPoint(CGContextRef cg_nullable c, CGFloat cpx, CGFloat cpy, CGFloat x, CGFloat y)
// 关闭路径，就是连接所画路径起点和终点
void CGContextClosePath(CGContextRef cg_nullable c)
// 画矩形
void CGContextAddRect(CGContextRef cg_nullable c, CGRect rect)
// 画多个矩形，rects：数组，形如：CGRect rects[] = {CGRect1,CGRect2}，count：rects数组内容的数量
void CGContextAddRects(CGContextRef cg_nullable c, const CGRect * __nullable rects, size_t count)
// 画多条线，points：数组，形如：CGPoint points[] = {CGPoint1,CGPoint2}，count：rects数组内容的数量
void CGContextAddLines(CGContextRef cg_nullable c, const CGPoint * __nullable points, size_t count)
// 画椭圆，rect：绘制的椭圆的大小
void CGContextAddEllipseInRect(CGContextRef cg_nullable c, CGRect rect)
// 画圆，x/y：圆心坐标点，radius：半径，startAngle/endAngle：起始角度/终止角度，clockwise：顺时针/逆时针
void CGContextAddArc(CGContextRef cg_nullable c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
// 画圆角，从当前点到点(x1,y1),再到点(x2,y2)构成一个角，把这个角变成圆角，去掉切点到点(x2,y2)间的线段，radius：圆角半径
void CGContextAddArcToPoint(CGContextRef cg_nullable c, CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2, CGFloat radius)
// 画路径
void CGContextAddPath(CGContextRef cg_nullable c, CGPathRef cg_nullable path)
// 使用绘制当前路径时覆盖的区域作为当前CGContextRef中的新路径
void CGContextReplacePathWithStrokedPath(CGContextRef cg_nullable c)


//>>> 绘制路径

// 绘制路径，mode：绘图模式
void CGContextDrawPath(CGContextRef cg_nullable c, CGPathDrawingMode mode)
// 填充模式绘制路径
void CGContextFillPath(CGContextRef cg_nullable c)
// 使用奇偶填充规则绘制路径
void CGContextEOFillPath(CGContextRef cg_nullable c)
// 描边模式绘制路径
void CGContextStrokePath(CGContextRef cg_nullable c)
// 填充模式绘制矩形
void CGContextFillRect(CGContextRef cg_nullable c, CGRect rect)
// 填充模式绘多个矩形，rects：数组，形如：CGRect rects[] = {CGRect1,CGRect2}，count：rects数组内容的数量
void CGContextFillRects(CGContextRef cg_nullable c, const CGRect * __nullable rects, size_t count)
// 描边模式绘制矩形
void CGContextStrokeRect(CGContextRef cg_nullable c, CGRect rect)
// 描边模式绘制矩形，并设置线宽
void CGContextStrokeRectWithWidth(CGContextRef cg_nullable c, CGRect rect, CGFloat width)
// 清除指定区域内已经绘制的内容
void CGContextClearRect(CGContextRef cg_nullable c, CGRect rect)
// 填充模式绘制椭圆，rect：椭圆所在的区域
void CGContextFillEllipseInRect(CGContextRef cg_nullable c, CGRect rect)
// 描边模式绘制椭圆，rect：椭圆所在的区域
void CGContextStrokeEllipseInRect(CGContextRef cg_nullable c, CGRect rect)
// 描边模式绘制多条线段，points：数组，内容为偶数个，形如：CGPoint points[] = {CGPoint1,CGPoint2}，count：rects数组内容的数量
void CGContextStrokeLineSegments(CGContextRef cg_nullable c, const CGPoint * __nullable points, size_t count)


//>>> 操作路径

// 当前路径是否为空
bool CGContextIsPathEmpty(CGContextRef cg_nullable c)
// 获取当前路径中最后绘制的点
CGPoint CGContextGetPathCurrentPoint(CGContextRef cg_nullable c)
// 获取包含当前路径的最小矩形
CGRect CGContextGetPathBoundingBox(CGContextRef cg_nullable c)
// 复制当前路径
CGPathRef __nullable CGContextCopyPath(CGContextRef cg_nullable c)
// 当前路径是否包含指定的点，point：指定的点，mode：绘图模式
bool CGContextPathContainsPoint(CGContextRef cg_nullable c, CGPoint point, CGPathDrawingMode mode)
// 设置剪切路径（使用非零绕数规则）
void CGContextClip(CGContextRef cg_nullable c)
// 设置剪切路径（使用奇偶规则）
void CGContextEOClip(CGContextRef cg_nullable c)
// 重新设置剪切路径（使用非零绕数规则）
void CGContextResetClip(CGContextRef c);
// 设置剪切的区域，且绘制图片到此区域，rect：区域，mask：图片
void CGContextClipToMask(CGContextRef cg_nullable c, CGRect rect, CGImageRef cg_nullable mask)
// 获取剪切路径所在的最小区域
CGRect CGContextGetClipBoundingBox(CGContextRef cg_nullable c)
// 设置剪切的矩形区域
void CGContextClipToRect(CGContextRef cg_nullable c, CGRect rect)
// 设置多个剪切的矩形区域，rects：数组，形如：CGRect rects[] = {CGRect1,CGRect2}，count：rects数组内容的数量
void CGContextClipToRects(CGContextRef cg_nullable c, const CGRect *  rects, size_t count)


//>>> 绘制文本

// 设置字符间距
void CGContextSetCharacterSpacing(CGContextRef cg_nullable c, CGFloat spacing)
// 设置文本的绘制位置
void CGContextSetTextPosition(CGContextRef cg_nullable c, CGFloat x, CGFloat y)
// 获取当前上下文的文本的绘制位置
CGPoint CGContextGetTextPosition(CGContextRef cg_nullable c)
// 设置文本变换
void CGContextSetTextMatrix(CGContextRef cg_nullable c, CGAffineTransform t)
// 获取当前上下文的文本变换
CGAffineTransform CGContextGetTextMatrix(CGContextRef cg_nullable c)
// 设置文本绘制模式
void CGContextSetTextDrawingMode(CGContextRef cg_nullable c, CGTextDrawingMode mode)
// 设置字体
void CGContextSetFont(CGContextRef cg_nullable c, CGFontRef cg_nullable font)
// 设置字体大小
void CGContextSetFontSize(CGContextRef cg_nullable c, CGFloat size)
// 指定位置绘制对应的字符，CGGlyph数组个数和CGPoint数组个数要对应
void CGContextShowGlyphsAtPositions(CGContextRef cg_nullable c, const CGGlyph * cg_nullable glyphs, const CGPoint * cg_nullable Lpositions, size_t count)
// 设置抗锯齿开启或关闭
void CGContextSetShouldAntialias(CGContextRef cg_nullable c, bool shouldAntialias)
// 设置抗锯齿开启或关闭
void CGContextSetAllowsAntialiasing(CGContextRef cg_nullable c, bool allowsAntialiasing)
// 设置字体平滑
void CGContextSetShouldSmoothFonts(CGContextRef cg_nullable c, bool shouldSmoothFonts)
// 设置字体平滑
void CGContextSetAllowsFontSmoothing(CGContextRef cg_nullable c, bool allowsFontSmoothing)
// 设置启动或禁用子像素定位
void CGContextSetShouldSubpixelPositionFonts(CGContextRef cg_nullable c, bool shouldSubpixelPositionFonts)
// 设置是否允许子像素定位
void CGContextSetAllowsFontSubpixelPositioning(CGContextRef cg_nullable c, bool allowsFontSubpixelPositioning)
// 设置启动或禁用子像素细化
void CGContextSetShouldSubpixelQuantizeFonts(CGContextRef cg_nullable c, bool shouldSubpixelQuantizeFonts)
// 设置是否允许子像素细化
void CGContextSetAllowsFontSubpixelQuantization(CGContextRef cg_nullable c, bool allowsFontSubpixelQuantization)
// 设置字体，相当于 CGContextSetFont＋CGContextSetFontSize
void CGContextSelectFont(CGContextRef cg_nullable c, const char * cg_nullable name, CGFloat size, CGTextEncoding textEncoding)
// 在当前点绘制指定文本
void CGContextShowText(CGContextRef cg_nullable c, const char * cg_nullable string, size_t length)
// 在指定点绘制指定文本
void CGContextShowTextAtPoint(CGContextRef cg_nullable c, CGFloat x, CGFloat y, const char * cg_nullable string, size_t length)
// 在当前点绘制一个数组的字形
void CGContextShowGlyphs(CGContextRef cg_nullable c, const CGGlyph * __nullable g, size_t count)
// 在指定点绘制一个数组的字形
void CGContextShowGlyphsAtPoint(CGContextRef cg_nullable c, CGFloat x, CGFloat y, const CGGlyph * __nullable glyphs, size_t count)
// 绘制具有不同的偏移量的一个数组字形
void CGContextShowGlyphsWithAdvances(CGContextRef cg_nullable c, const CGGlyph * __nullable glyphs, const CGSize * __nullable advances, size_t count)


//>>> 绘制图像

// 绘制图片到指定区域
void CGContextDrawImage(CGContextRef cg_nullable c, CGRect rect, CGImageRef cg_nullable image)
// 平铺模式绘制图片到指定区域
void CGContextDrawTiledImage(CGContextRef cg_nullable c, CGRect rect, CGImageRef cg_nullable image)
// 获取当前上下文插值的质量水平（插值(Interpolation)是在不天生像素的环境下增长图像像素大小的一种方法，在周围像素色彩的根蒂根基上用算术公式计算亡失像素的色彩。）
CGInterpolationQuality CGContextGetInterpolationQuality(CGContextRef cg_nullable c)
// 设置插入像素的质量等级（填补对丢失像素的一种方法）
void CGContextSetInterpolationQuality(CGContextRef cg_nullable c, CGInterpolationQuality quality)


//>>> 绘制PDF

// 绘制一页PDF
void CGContextDrawPDFPage(CGContextRef cg_nullable c, CGPDFPageRef cg_nullable page)
// 基于页面的图形上下文中开始了新的一页
void CGContextBeginPage(CGContextRef cg_nullable c, const CGRect * __nullable mediaBox)
// 在基于页面的图形上下文结束当前的页面
void CGContextEndPage(CGContextRef cg_nullable c)
// 绘制PDF文档
void CGContextDrawPDFDocument(CGContextRef cg_nullable c, CGRect rect, CGPDFDocumentRef cg_nullable document, int page)


//>>> 绘制阴影渐变

// 设置彩色阴影，offset：阴影的位置，blur：模糊度，color：阴影颜色
void CGContextSetShadowWithColor(CGContextRef cg_nullable c, CGSize offset, CGFloat blur, CGColorRef __nullable color)
// 设置默认阴影，offset：阴影的位置，blur：模糊度
void CGContextSetShadow(CGContextRef cg_nullable c, CGSize offset, CGFloat blur)
// 绘制线性渐变色，gradient：渐变的颜色，startPoint：起点，endPoint：终点，options：渐变是否超越起始点和终止点
void CGContextDrawLinearGradient(CGContextRef cg_nullable c, CGGradientRef cg_nullable gradient, CGPoint startPoint, CGPoint endPoint, CGGradientDrawingOptions options)
// 绘制扩散渐变色，gradient：渐变的颜色，startCenter/startRadius：起始的圆心/半径，endCenter/endRadius：结束的圆心/半径，options：渐变是否超越起始点和终止点
void CGContextDrawRadialGradient(CGContextRef cg_nullable c, CGGradientRef cg_nullable gradient, CGPoint startCenter, CGFloat startRadius, CGPoint endCenter, CGFloat endRadius, CGGradientDrawingOptions options)
// 绘制CGShadingRef对象，CGShadingRef是渐变色对象
void CGContextDrawShading(CGContextRef cg_nullable c, cg_nullable CGShadingRef shading)


//>>> 设备空间和用户空间之间的转换

// 获取Quartz转换用户空间和设备空间的仿射变换
CGAffineTransform CGContextGetUserSpaceToDeviceSpaceTransform(CGContextRef cg_nullable c)
// 用户空间的点转换到设备空间，像素要变化（乘/除 分辨率）
CGPoint CGContextConvertPointToDeviceSpace(CGContextRef cg_nullable c, CGPoint point)
// 设备空间的点转换到用户空间
CGPoint CGContextConvertPointToUserSpace(CGContextRef cg_nullable c, CGPoint point)
// 用户空间的CGSize转换到设备空间
CGSize CGContextConvertSizeToDeviceSpace(CGContextRef cg_nullable c, CGSize size)
// 设备空间的CGSize转换到用户空间
CGSize CGContextConvertSizeToUserSpace(CGContextRef cg_nullable c, CGSize size)
// 用户空间的CGRect转换到设备空间
CGRect CGContextConvertRectToDeviceSpace(CGContextRef cg_nullable c, CGRect rect)
// 设备空间的CGRect转换到用户空间
CGRect CGContextConvertRectToUserSpace(CGContextRef cg_nullable c, CGRect rect)


/***********************************************************/
/******************** CGBitmapContext.h ********************/

typedef void (* CGBitmapContextReleaseDataCallback)(void * __nullable releaseInfo, void * __nullable data)
CGContextRef __nullable CGBitmapContextCreateWithData(void * __nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef cg_nullable space, uint32_t bitmapInfo, CGBitmapContextReleaseDataCallback __nullable releaseCallback, void * __nullable releaseInfo)
CGContextRef __nullable CGBitmapContextCreate(void * __nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef cg_nullable space, uint32_t bitmapInfo)
// 获取位图上下文的图片数据
void * __nullable CGBitmapContextGetData(CGContextRef cg_nullable context)
// 获取位图上下文区域的宽
size_t CGBitmapContextGetWidth(CGContextRef cg_nullable context)
// 获取位图上下文区域的高
size_t CGBitmapContextGetHeight(CGContextRef cg_nullable context)
//
size_t CGBitmapContextGetBitsPerComponent(CGContextRef cg_nullable context)
//
size_t CGBitmapContextGetBitsPerPixel(CGContextRef cg_nullable context)
//
size_t CGBitmapContextGetBytesPerRow(CGContextRef cg_nullable context)
// 获取位图上下文的颜色空间
CGColorSpaceRef __nullable CGBitmapContextGetColorSpace(CGContextRef cg_nullable context)
//
CGImageAlphaInfo CGBitmapContextGetAlphaInfo(CGContextRef cg_nullable context)
CGBitmapInfo CGBitmapContextGetBitmapInfo(CGContextRef cg_nullable context)
CGImageRef __nullable CGBitmapContextCreateImage(CGContextRef cg_nullable context)


/********************************************************/
/******************** CGPDFContext.h ********************/

CGContextRef __nullable CGPDFContextCreate(CGDataConsumerRef cg_nullable consumer, const CGRect *__nullable mediaBox, CFDictionaryRef __nullable auxiliaryInfo)
// 创建PDF上下文，url：PDF文件存储路径，mediaBox：PDF绘制区域，auxiliaryInfo：PDF信息，密码...
CGContextRef __nullable CGPDFContextCreateWithURL(CFURLRef cg_nullable url, const CGRect * __nullable mediaBox, CFDictionaryRef __nullable auxiliaryInfo)
// 关闭PDF
void CGPDFContextClose(CGContextRef cg_nullable context)
// 开始绘制一页PDF
void CGPDFContextBeginPage(CGContextRef cg_nullable context, CFDictionaryRef __nullable pageInfo)
// 结束绘制一页PDF
void CGPDFContextEndPage(CGContextRef cg_nullable context)
void CGPDFContextAddDocumentMetadata(CGContextRef cg_nullable context, CFDataRef __nullable metadata)
// 添加URL跳转
void CGPDFContextSetURLForRect(CGContextRef cg_nullable context, CFURLRef  url, CGRect rect)
// 设置跳转到目的地
void CGPDFContextAddDestinationAtPoint(CGContextRef cg_nullable context, CFStringRef  name, CGPoint point)
// 设置跳转目的地的点击区域
void CGPDFContextSetDestinationForRect(CGContextRef cg_nullable context, CFStringRef  name, CGRect rect)
// 以下是PDF、PDF页面的属性的 key 值
const CFStringRef  kCGPDFContextMediaBox
const CFStringRef  kCGPDFContextCropBox
const CFStringRef  kCGPDFContextBleedBox
const CFStringRef  kCGPDFContextTrimBox
const CFStringRef  kCGPDFContextArtBox
const CFStringRef  kCGPDFContextTitle
const CFStringRef  kCGPDFContextAuthor
const CFStringRef  kCGPDFContextSubject
const CFStringRef  kCGPDFContextKeywords
const CFStringRef  kCGPDFContextCreator
const CFStringRef  kCGPDFContextOwnerPassword
const CFStringRef  kCGPDFContextUserPassword
const CFStringRef  kCGPDFContextEncryptionKeyLength
const CFStringRef  kCGPDFContextAllowsPrinting
const CFStringRef  kCGPDFContextAllowsCopying
const CFStringRef  kCGPDFContextOutputIntent
const CFStringRef  kCGPDFXOutputIntentSubtype
const CFStringRef  kCGPDFXOutputConditionIdentifier
const CFStringRef  kCGPDFXOutputCondition
const CFStringRef  kCGPDFXRegistryName
const CFStringRef  kCGPDFXInfo
const CFStringRef  kCGPDFXDestinationOutputProfile
const CFStringRef  kCGPDFContextOutputIntents
const CFStringRef  kCGPDFContextAccessPermissions
void CGPDFContextSetOutline(CGContextRef context, __nullable CFDictionaryRef outline)
