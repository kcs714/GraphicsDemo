//
//  PDFHandler.m
//  AnimalTableDemo
//
//  Created by  kcs on 2018/2/13.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "PDFHandler.h"

@interface PDFDrawer()

@property(nonatomic, assign)CGContextRef pdfContext;
@property(nonatomic, assign)CGRect pageRect;

@end

@implementation PDFDrawer

- (instancetype)init {
    if (self = [super init]) {
        self.lineWidth = 0.5f;
        self.dashMargin = 0.0f;
        self.drawColor = [UIColor blackColor];
        self.drawMode = kCGPathStroke;
        self.fontSize = 15.0;
        self.fontColor = [UIColor blackColor];
    }
    return self;
}

// 画线
- (void)drawLine:(CGPoint)point1 toPoint:(CGPoint)point2 {
    if (self.pdfContext == NULL) {
        return;
    }
    CGContextSaveGState(self.pdfContext);
    CGContextTranslateCTM(self.pdfContext, 0, CGRectGetHeight(self.pageRect));
    CGContextScaleCTM(self.pdfContext, 1, -1);
    if (self.dashMargin != 0) {
        CGFloat lengths[] = {self.dashMargin, self.dashMargin};
        CGContextSetLineDash(self.pdfContext, 0, lengths, 2);
    }
    CGContextSetLineWidth(self.pdfContext, self.lineWidth);
    CGContextSetStrokeColorWithColor(self.pdfContext, self.drawColor.CGColor);
    CGContextSetFillColorWithColor(self.pdfContext, self.drawColor.CGColor);
    CGContextBeginPath(self.pdfContext);
    CGContextMoveToPoint(self.pdfContext, point1.x, point1.y);
    CGContextAddLineToPoint(self.pdfContext, point2.x, point2.y);
    CGContextDrawPath(self.pdfContext, self.drawMode);
    CGContextRestoreGState(self.pdfContext);
}

// 画矩形
- (void)drawRect:(CGRect)rect radiusX:(CGFloat)radiusX radiusY:(CGFloat)radiusY {
    if (self.pdfContext == NULL) {
        return;
    }
    CGContextSaveGState(self.pdfContext);
    CGContextTranslateCTM(self.pdfContext, 0, CGRectGetHeight(self.pageRect));
    CGContextScaleCTM(self.pdfContext, 1, -1);
    CGContextSetLineWidth(self.pdfContext, self.lineWidth);
    CGContextSetStrokeColorWithColor(self.pdfContext, self.drawColor.CGColor);
    CGContextSetFillColorWithColor(self.pdfContext, self.drawColor.CGColor);
    if (self.dashMargin != 0) {
        CGFloat lengths[] = {self.dashMargin, self.dashMargin};
        CGContextSetLineDash(self.pdfContext, 0, lengths, 2);
    }
    
    CGContextBeginPath(self.pdfContext);
    
    CGFloat xMin = CGRectGetMinX(rect);
    CGFloat xMax = CGRectGetMaxX(rect);
    CGFloat x1 = xMin + radiusX;
    CGFloat x2 = xMax - radiusX;
    CGFloat yMin = CGRectGetMinY(rect);
    CGFloat yMax = CGRectGetMaxY(rect);
    CGFloat y1 = yMin + radiusY;
    CGFloat y2 = yMax - radiusY;
    
    CGContextMoveToPoint(self.pdfContext, xMin, y1);
    CGContextAddLineToPoint(self.pdfContext, xMin, y2);
    CGContextAddQuadCurveToPoint(self.pdfContext, xMin, yMax, x1, yMax);
    CGContextAddLineToPoint(self.pdfContext, x2, yMax);
    CGContextAddQuadCurveToPoint(self.pdfContext, xMax, yMax, xMax, y2);
    CGContextAddLineToPoint(self.pdfContext, xMax, y1);
    CGContextAddQuadCurveToPoint(self.pdfContext, xMax, yMin, x2, yMin);
    CGContextAddLineToPoint(self.pdfContext, x1, yMin);
    CGContextAddQuadCurveToPoint(self.pdfContext, xMin, yMin, xMin, y1);
    CGContextClosePath(self.pdfContext);
    
    CGContextDrawPath(self.pdfContext, self.drawMode);
    CGContextRestoreGState(self.pdfContext);
}

// 画椭圆、圆
- (void)drawEllipseInRect:(CGRect)rect {
    if (self.pdfContext == NULL) {
        return;
    }
    CGContextSaveGState(self.pdfContext);
    CGContextTranslateCTM(self.pdfContext, 0, CGRectGetHeight(self.pageRect));
    CGContextScaleCTM(self.pdfContext, 1, -1);
    CGContextSetLineWidth(self.pdfContext, self.lineWidth);
    CGContextSetStrokeColorWithColor(self.pdfContext, self.drawColor.CGColor);
    CGContextSetFillColorWithColor(self.pdfContext, self.drawColor.CGColor);
    if (self.dashMargin != 0) {
        CGFloat lengths[] = {self.dashMargin, self.dashMargin};
        CGContextSetLineDash(self.pdfContext, 0, lengths, 2);
    }
    CGContextBeginPath(self.pdfContext);
    if (self.drawMode == kCGPathStroke) {
        CGContextStrokeEllipseInRect(self.pdfContext, rect);
    } else if (self.drawMode == kCGPathFill) {
        CGContextFillEllipseInRect(self.pdfContext, rect);
    }
    CGContextRestoreGState(self.pdfContext);
}

// 画图片
- (void)drawImage:(UIImage *)image inRect:(CGRect)rect radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    if (self.pdfContext == NULL) {
        return;
    }
    CGContextSaveGState(self.pdfContext);
    CGContextTranslateCTM(self.pdfContext, 0.0, CGRectGetHeight(self.pageRect) - CGRectGetMaxY(rect) - CGRectGetMinY(rect));
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat xMin = CGRectGetMinX(rect);
    CGFloat xMax = CGRectGetMaxX(rect);
    CGFloat x1 = xMin + radius;
    CGFloat x2 = xMax - radius;
    CGFloat yMin = CGRectGetMinY(rect);
    CGFloat yMax = CGRectGetMaxY(rect);
    CGFloat y1 = yMin + radius;
    CGFloat y2 = yMax - radius;
    [path moveToPoint:CGPointMake(xMin, y1)];
    [path addLineToPoint:CGPointMake(xMin, y2)];
    [path addArcWithCenter:CGPointMake(x1, y2) radius:radius startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
    [path addLineToPoint:CGPointMake(x2, yMax)];
    [path addArcWithCenter:CGPointMake(x2, y2) radius:radius startAngle:M_PI_2 endAngle:0 clockwise:NO];
    [path addLineToPoint:CGPointMake(xMax, y1)];
    [path addArcWithCenter:CGPointMake(x2, y1) radius:radius startAngle:0 endAngle:M_PI_2 * 3 clockwise:NO];
    [path addLineToPoint:CGPointMake(x1, yMin)];
    [path addArcWithCenter:CGPointMake(x1, y1) radius:radius startAngle:M_PI_2 * 3 endAngle:M_PI clockwise:NO];
    [path closePath];
    CGContextAddPath(self.pdfContext, path.CGPath);
    CGContextClip(self.pdfContext);

    CGContextDrawImage(self.pdfContext, rect, image.CGImage);
    CGContextRestoreGState(self.pdfContext);
    
    CGContextSaveGState(self.pdfContext);
    if (borderWidth && borderColor != nil) {
        CGContextTranslateCTM(self.pdfContext, 0, CGRectGetHeight(self.pageRect));
        CGContextScaleCTM(self.pdfContext, 1, -1);
        CGContextSetLineWidth(self.pdfContext, borderWidth);
        CGContextSetStrokeColorWithColor(self.pdfContext, borderColor.CGColor);
        CGContextSetLineCap(self.pdfContext, path.lineCapStyle);
        CGContextSetAllowsAntialiasing(self.pdfContext, true); //保真，消除叠加
        CGContextBeginPath(self.pdfContext);
        CGContextAddPath(self.pdfContext, path.CGPath);
        CGContextStrokePath(self.pdfContext);
    }
    CGContextRestoreGState(self.pdfContext);
}

// 画文字
- (void)drawText:(NSString *)text inRect:(CGRect)rect {
    if (self.pdfContext == NULL) {
        return;
    }
    CGContextSaveGState(self.pdfContext);
    CGContextTranslateCTM(self.pdfContext, 0.0, CGRectGetHeight(self.pageRect));
    CGContextScaleCTM(self.pdfContext, 1.0, -1.0);
    [text drawInRect:rect withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.fontSize], NSForegroundColorAttributeName: self.fontColor}];
    CGContextRestoreGState(self.pdfContext);
}

// 添加 URL 跳转
- (void)addURL:(NSString *)urlStr infoText:(NSString *)infoText inRect:(CGRect)rect {
    if (self.pdfContext == NULL || urlStr.length <= 0) {
        return;
    }
    [self drawText:infoText inRect:rect];
    CGContextSaveGState(self.pdfContext);
    NSURL *furl = [NSURL URLWithString:urlStr];
    CFURLRef fileURL = (__bridge CFURLRef)furl;
    rect.origin.y += (CGRectGetHeight(self.pageRect)-CGRectGetMaxY(rect)-CGRectGetMinY(rect));
    CGPDFContextSetURLForRect(self.pdfContext, fileURL, rect);
    CGContextRestoreGState(self.pdfContext);
}

// 跳转目的地
- (void)setDestination:(NSString *)destName destPoint:(CGPoint)destPoint {
    if (self.pdfContext == NULL && destName.length > 0) {
        return;
    }
    CGContextSaveGState(self.pdfContext);
    destPoint.y = CGRectGetHeight(self.pageRect) - destPoint.y;
    CFStringRef cDestName = CFStringCreateWithCString(NULL, destName.UTF8String, kCFStringEncodingUTF8);
    CGPDFContextAddDestinationAtPoint(self.pdfContext, cDestName, destPoint);
    CGContextRestoreGState(self.pdfContext);
}

- (void)jumpToDestination:(NSString *)destName infoText:(NSString *)infoText destRect:(CGRect)destRect {
    if (self.pdfContext == NULL && destName.length > 0) {
        return;
    }
    [self drawText:infoText inRect:destRect];
    CGContextSaveGState(self.pdfContext);
    destRect.origin.y += (CGRectGetHeight(self.pageRect)-CGRectGetMaxY(destRect)-CGRectGetMinY(destRect));
    CFStringRef cDestName = CFStringCreateWithCString(NULL, destName.UTF8String, kCFStringEncodingUTF8);
    CGPDFContextSetDestinationForRect(self.pdfContext, cDestName, destRect);
    CGContextRestoreGState(self.pdfContext);
}

@end



@interface PDFHandler()

@property(nonatomic, assign)CGContextRef pdfContext; // PDF上下文
@property(nonatomic, copy)NSString *path; // 存储路径
@property(nonatomic, assign)CGRect pageRect; // 页面区域
@property(nonatomic, assign)CFMutableDictionaryRef pdfInfoRef; // PDF info
@property(nonatomic, strong)PDFDrawer *drawer; // 绘图工具类

@end

@implementation PDFHandler

- (instancetype)initWithPageRect:(CGRect)pageRect path:(NSString *)path {
    if (self = [super init]) {
        _pageRect = pageRect;
        _path = path;
        // iPhone6s -> 326
        // 1 inch = 2.54cm = 25.4mm
        // A4纸：210mm X 297mm
        // 宽：210 / 25.4 * 326 = 2695pixel
        // 高：297 / 25.4 * 326 = 3812pixel
        // 宽高都缩小7.2倍 (374, 529)
        self.pageRect = CGRectMake(0, 0, 374, 529);
    }
    return self;
}

- (void)dealloc {
    if (_pdfInfoRef) {
        CFRelease(_pdfInfoRef);
    }
    if (_pdfContext) {
        CGPDFContextClose(_pdfContext);
        CGContextRelease(_pdfContext);
    }
}

- (PDFHandler *)addPage:(NSDictionary *)pageInfo pageBlock:(PageBlock)pageBlock {
    if (pageBlock) {
        UIGraphicsPushContext(self.pdfContext);
        CFMutableDictionaryRef infoRef = [self getCFDic:pageInfo];
        CGPDFContextBeginPage(self.pdfContext, infoRef);
        CFRelease(infoRef);
        pageBlock(self.drawer);
        CGPDFContextEndPage(self.pdfContext);
        UIGraphicsPopContext();
    }
    return self;
}

- (CFMutableDictionaryRef)getCFDic:(NSDictionary *)dic {
    CFMutableDictionaryRef InfoRef = CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFTypeRef valueRef0 = (CFTypeRef)CFDataCreate(NULL, (const UInt8 *)&_pageRect, sizeof(_pageRect));
    CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextMediaBox, valueRef0);
    NSArray *keyArr = dic.allKeys;
    for (int i = 0; i < keyArr.count; ++i) {
        NSString *tempStr = keyArr[i];
        id value = dic[tempStr];
        if ([value isKindOfClass:[NSValue class]]) {
            CGRect tempRect = ((NSValue *)value).CGRectValue;
            CFTypeRef valueRef = (CFTypeRef)CFDataCreate(NULL, (const UInt8 *)&tempRect, sizeof(tempRect));
            if ([tempStr isEqualToString:kPDFPageMediaBox]) {
                CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextMediaBox, valueRef);
            } else if ([tempStr isEqualToString:kPDFPageTrimBox]) {
                CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextTrimBox, valueRef);
            } else if ([tempStr isEqualToString:kPDFPageCropBox]) {
                CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextCropBox, valueRef);
            } else if ([tempStr isEqualToString:kPDFPageBleedBox]) {
                CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextBleedBox, valueRef);
            } else if ([tempStr isEqualToString:kPDFPageArtBox]) {
                CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextArtBox, valueRef);
            }
            CFRelease(valueRef);
        } else if ([value isKindOfClass:[NSString class]]) {
            NSString *valueStr = (NSString *)value;
            CFStringRef strRef = CFStringCreateWithCString(NULL, valueStr.UTF8String, kCFStringEncodingUTF8);
            if ([tempStr isEqualToString:kPDFPageTitle]) {
                CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextTitle, strRef);
            } else if ([tempStr isEqualToString:kPDFPageCreator]) {
                CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextCreator, strRef);
            }
            CFRelease(strRef);
        }
    }
    return InfoRef;
}

// 展示PDF
- (void)loadPDF {
    
}

- (PDFDrawer *)drawer {
    if (!_drawer) {
        _drawer = [PDFDrawer new];
        _drawer.pageRect = self.pageRect;
        _drawer.pdfContext= self.pdfContext;
    }
    return _drawer;
}

- (CGContextRef)pdfContext {
    if (!_pdfContext) {
        CFStringRef pathRef = CFStringCreateWithCString(NULL, self.path.UTF8String, kCFStringEncodingUTF8);
        _pdfContext = CreatePDFContext(&_pageRect, pathRef, self.pdfInfoRef);
        CFRelease(pathRef);
    }
    return _pdfContext;
}

- (CFMutableDictionaryRef)pdfInfoRef {
    if (!_pdfInfoRef) {
        _pdfInfoRef = CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
    return _pdfInfoRef;
}

- (void)setPassWord:(NSString *)passWord {
    _passWord = passWord;
    if (passWord.length > 0) {
        CFStringRef passwordStr = CFStringCreateWithCString(NULL, passWord.UTF8String, kCFStringEncodingUTF8);
        CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextOwnerPassword, passwordStr);
        CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextUserPassword, passwordStr);
        CFRelease(passwordStr);
    } else {
        CFDictionaryRemoveValue(self.pdfInfoRef, kCGPDFContextOwnerPassword);
        CFDictionaryRemoveValue(self.pdfInfoRef, kCGPDFContextUserPassword);
    }
}

- (void)setCanCopy:(BOOL)canCopy {
    _canCopy = canCopy;
    if (canCopy) {
        CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextAllowsCopying, kCFBooleanTrue);
    } else {
        CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextAllowsCopying, kCFBooleanFalse);
    }
}

- (void)setCanPrint:(BOOL)canPrint {
    _canPrint = canPrint;
    if (canPrint) {
        CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextAllowsPrinting, kCFBooleanTrue);
    } else {
        CFDictionarySetValue(self.pdfInfoRef, kCGPDFContextAllowsPrinting, kCFBooleanFalse);
    }
}

+ (void)generatePDF:(CGRect)rect path:(NSString *)path pdfBlock:(PageBlock)pdfBlock {
    PDFHandler *pdfHandler = [[PDFHandler alloc] initWithPageRect:rect path:path];
    if (pdfHandler.pdfContext != NULL) {
        if (pdfBlock) {
            pdfBlock(pdfHandler.drawer);
        }
    }
}

CGContextRef CreatePDFContext (const CGRect *inMediaBox, CFStringRef path, CFDictionaryRef auxiliaryInfo) {
    CGContextRef pdfContext = NULL;
    CFURLRef url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, false);
    if (url != NULL) {
        pdfContext = CGPDFContextCreateWithURL(url, inMediaBox, auxiliaryInfo);
        CFRelease(url);
    }
    return pdfContext;
}


NSString * const kPDFPageMediaBox = @"PDFPageMediaBox";
NSString * const kPDFPageCropBox = @"PDFPageCropBox";
NSString * const kPDFPageBleedBox = @"PDFPageBleedBox";
NSString * const kPDFPageTrimBox = @"PDFPageTrimBox";
NSString * const kPDFPageArtBox = @"PDFPageArtBox";
NSString * const kPDFPageTitle = @"PDFPageTitle";
NSString * const kPDFPageCreator = @"PDFPageCreator";

@end
