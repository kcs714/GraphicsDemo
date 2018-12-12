//
//  DrawManager.m
//  AnimalTableDemo
//
//  Created by  kcs on 2018/2/8.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "DrawManager.h"

@interface DrawManager()

@end

@implementation DrawManager

- (instancetype)init {
    if (self = [super init]) {
        self.lineWidth = 0.5f;
        self.dashMargin = 0.0f;
        self.drawColor = [UIColor grayColor];
        self.drawMode = kCGPathStroke;
        
        self.fontSize = 13.0f;
        self.fontColor = [UIColor blackColor];
        self.textAlignment = NSTextAlignmentLeft;
        self.lineBreakMode = NSLineBreakByTruncatingTail;
        self.lineSpacing = 0.0f;
        self.edgeInset = UIEdgeInsetsZero;
    }
    return self;
}

#pragma MARK - 绘制图片

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect context:(CGContextRef)context {
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0.0, rect.size.height + rect.origin.y * 2);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, rect, image.CGImage);
    CGContextRestoreGState(context);
}

- (void)drawImage:(UIImage *)image inRect:(CGRect)rect radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor context:(CGContextRef)context {
    CGContextSaveGState(context);
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
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    
    CGContextTranslateCTM(context, 0.0, rect.size.height + rect.origin.y * 2);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, rect, image.CGImage);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    if (borderWidth && borderColor != nil) {
        CGContextSetLineWidth(context, borderWidth);
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextSetLineCap(context, path.lineCapStyle);
        CGContextSetAllowsAntialiasing(context, true); //保真，消除叠加
        CGContextBeginPath(context);
        CGContextAddPath(context, path.CGPath);
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
}


#pragma MARK - 绘制文字

- (void)drawText:(NSString *)string inRect:(CGRect)rect {
    [self drawText:string fontSize:self.fontSize fontColor:self.fontColor textAlignment:self.textAlignment lineSpacing:self.lineSpacing inRect:rect edgeInset:self.edgeInset];
}

- (void)drawText:(NSString *)string fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor textAlignment:(NSTextAlignment)textAlignment lineSpacing:(CGFloat)lineSpacing inRect:(CGRect)rect edgeInset:(UIEdgeInsets)edgeInset {
    if (string.length <= 0) {
        return;
    }
    CGRect tempRect = CGRectMake(rect.origin.x + edgeInset.left, rect.origin.y + edgeInset.top, rect.size.width - edgeInset.left - edgeInset.right, rect.size.height - edgeInset.top - edgeInset.bottom);
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment:textAlignment];
    [paragraphStyle setLineSpacing:lineSpacing];
    fontColor = fontColor != nil ? fontColor : [UIColor clearColor];
    NSDictionary *attributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: fontColor, NSParagraphStyleAttributeName: paragraphStyle};
    [string drawInRect:tempRect withAttributes:attributes];
}


#pragma MARK - 绘制图形

- (void)drawLine:(CGPoint)point1 toPoint:(CGPoint)point2 context:(CGContextRef)context {
    [self drawLine:@[kPointValue(point1), kPointValue(point2)] dashMargin:self.dashMargin lineWidth:self.lineWidth lineColor:self.drawColor context:context ];
}

- (void)drawLine:(NSArray<NSValue *> *)pointValues dashMargin:(CGFloat)dashMargin lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor context:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    lineColor = lineColor != nil ? lineColor : [UIColor clearColor];
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    if (dashMargin != 0) {
        NSValue *firstValue = pointValues.firstObject;
        NSValue *lastValue = pointValues.lastObject;
        CGPoint firstPoint = firstValue.CGPointValue;
        CGPoint lastPoint = lastValue.CGPointValue;
        CGFloat totalLenth = sqrtf((lastPoint.x - firstPoint.x)*(lastPoint.x - firstPoint.x) + (lastPoint.y - firstPoint.y)* (lastPoint.y - firstPoint.y));
        NSUInteger num = totalLenth / dashMargin;
        num = num % 2 == 0 ? num + 1 : num;
        CGFloat moreNum = totalLenth - dashMargin * num;
        dashMargin += (moreNum / num);
        CGFloat lengths[] = {dashMargin, dashMargin};
        CGContextSetLineDash(context, 0, lengths, 2);
    }
    CGContextBeginPath(context);
    NSValue *value = pointValues.firstObject;
    if (value) {
        CGPoint point = value.CGPointValue;
        CGContextMoveToPoint(context, point.x, point.y);
        for (int i = 1; i < pointValues.count; ++i) {
            NSValue *value = pointValues[i];
            CGPoint point = value.CGPointValue;
            CGContextAddLineToPoint(context, point.x, point.y);
        }
    }
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawArc:(CGPoint)center radius:(CGFloat)radius context:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.drawColor.CGColor);
    CGContextSetFillColorWithColor(context, self.drawColor.CGColor);
    if (self.dashMargin != 0) {
        CGFloat lengths[] = {self.dashMargin, self.dashMargin};
        CGContextSetLineDash(context, 0, lengths, 2);
    }
    CGContextBeginPath(context);
    CGContextAddArc(context, center.x, center.y, radius, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, self.drawMode);
    CGContextRestoreGState(context);
}

- (void)drawEllipseInRect:(CGRect)rect context:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.drawColor.CGColor);
    CGContextSetFillColorWithColor(context, self.drawColor.CGColor);
    if (self.dashMargin != 0) {
        CGFloat lengths[] = {self.dashMargin, self.dashMargin};
        CGContextSetLineDash(context, 0, lengths, 2);
    }
    CGContextBeginPath(context);
    if (self.drawMode == kCGPathStroke) {
        CGContextStrokeEllipseInRect(context, rect);
    } else if (self.drawMode == kCGPathFill) {
        CGContextFillEllipseInRect(context, rect);
    }
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect radius:(CGFloat)radius context:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.drawColor.CGColor);
    CGContextSetFillColorWithColor(context, self.drawColor.CGColor);
    if (self.dashMargin != 0) {
        CGFloat lengths[] = {self.dashMargin, self.dashMargin};
        CGContextSetLineDash(context, 0, lengths, 2);
    }
    CGContextBeginPath(context);
    if (radius == 0) {
        CGContextAddRect(context, rect);
    } else {
        CGFloat xMin = CGRectGetMinX(rect);
        CGFloat xMax = CGRectGetMaxX(rect);
        CGFloat yMin = CGRectGetMinY(rect);
        CGFloat yMax = CGRectGetMaxY(rect);
        CGFloat y1 = yMin + radius;
        
        CGContextMoveToPoint(context, xMin, y1);
        CGContextAddArcToPoint(context, xMin, yMax, xMax, yMax, radius);
        CGContextAddArcToPoint(context, xMax, yMax, xMax, yMin, radius);
        CGContextAddArcToPoint(context, xMax, yMin, xMin, yMin, radius);
        CGContextAddArcToPoint(context, xMin, yMin, xMin, y1, radius);
        CGContextClosePath(context);
    }
    CGContextDrawPath(context, self.drawMode);
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect radiusX:(CGFloat)radiusX radiusY:(CGFloat)radiusY context:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.drawColor.CGColor);
    CGContextSetFillColorWithColor(context, self.drawColor.CGColor);
    if (self.dashMargin != 0) {
        CGFloat lengths[] = {self.dashMargin, self.dashMargin};
        CGContextSetLineDash(context, 0, lengths, 2);
    }
    
    CGContextBeginPath(context);
    
    CGFloat xMin = CGRectGetMinX(rect);
    CGFloat xMax = CGRectGetMaxX(rect);
    CGFloat x1 = xMin + radiusX;
    CGFloat x2 = xMax - radiusX;
    CGFloat yMin = CGRectGetMinY(rect);
    CGFloat yMax = CGRectGetMaxY(rect);
    CGFloat y1 = yMin + radiusY;
    CGFloat y2 = yMax - radiusY;
    
    CGContextMoveToPoint(context, xMin, y1);
    CGContextAddLineToPoint(context, xMin, y2);
    CGContextAddQuadCurveToPoint(context, xMin, yMax, x1, yMax);
    CGContextAddLineToPoint(context, x2, yMax);
    CGContextAddQuadCurveToPoint(context, xMax, yMax, xMax, y2);
    CGContextAddLineToPoint(context, xMax, y1);
    CGContextAddQuadCurveToPoint(context, xMax, yMin, x2, yMin);
    CGContextAddLineToPoint(context, x1, yMin);
    CGContextAddQuadCurveToPoint(context, xMin, yMin, xMin, y1);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, self.drawMode);
    CGContextRestoreGState(context);
}

- (void)drawArcRing:(CGPoint)center radiusMax:(CGFloat)radiusMax radiusMin:(CGFloat)radiusMin color:(UIColor *)color context:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    color = color != nil ? color : [UIColor clearColor];
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextBeginPath(context);
    CGContextAddArc(context, center.x, center.y, radiusMax, 0, 2 * M_PI, 0);
    CGContextAddArc(context, center.x, center.y, radiusMin, 0, 2 * M_PI, 0);
    CGContextEOFillPath(context);
    CGContextRestoreGState(context);
}

- (void)drawEllipseRingInRect:(CGRect)rect edgeInsets:(UIEdgeInsets)insets color:(UIColor *)color context:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    color = color != nil ? color : [UIColor clearColor];
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGRect minRect = rect;
    minRect.origin.x += insets.left;
    minRect.origin.y += insets.top;
    minRect.size.width -= (insets.left + insets.right);
    minRect.size.height -= (insets.top + insets.bottom);
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, rect);
    CGContextAddEllipseInRect(context, minRect);
    CGContextEOFillPath(context);
    CGContextRestoreGState(context);
}

- (void)drawRectRing:(CGRect)rect edgeInsets:(UIEdgeInsets)insets radiusX:(CGFloat)radiusX radiusY:(CGFloat)radiusY color:(UIColor *)color context:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    color = color != nil ? color : [UIColor clearColor];
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextBeginPath(context);
    
    CGFloat xMin = CGRectGetMinX(rect);
    CGFloat xMax = CGRectGetMaxX(rect);
    CGFloat x1 = xMin + radiusX;
    CGFloat x2 = xMax - radiusX;
    CGFloat yMin = CGRectGetMinY(rect);
    CGFloat yMax = CGRectGetMaxY(rect);
    CGFloat y1 = yMin + radiusY;
    CGFloat y2 = yMax - radiusY;
    
    CGContextMoveToPoint(context, xMin, y1);
    CGContextAddLineToPoint(context, xMin, y2);
    CGContextAddQuadCurveToPoint(context, xMin, yMax, x1, yMax);
    CGContextAddLineToPoint(context, x2, yMax);
    CGContextAddQuadCurveToPoint(context, xMax, yMax, xMax, y2);
    CGContextAddLineToPoint(context, xMax, y1);
    CGContextAddQuadCurveToPoint(context, xMax, yMin, x2, yMin);
    CGContextAddLineToPoint(context, x1, yMin);
    CGContextAddQuadCurveToPoint(context, xMin, yMin, xMin, y1);
    CGContextClosePath(context);
    
    xMin += insets.left;
    xMax -= insets.right;
    x1 = xMin + radiusX;
    x2 = xMax - radiusX;
    yMin += insets.top;
    yMax -= insets.bottom;
    y1 = yMin + radiusY;
    y2 = yMax - radiusY;
    
    CGContextMoveToPoint(context, xMin, y1);
    CGContextAddLineToPoint(context, xMin, y2);
    CGContextAddQuadCurveToPoint(context, xMin, yMax, x1, yMax);
    CGContextAddLineToPoint(context, x2, yMax);
    CGContextAddQuadCurveToPoint(context, xMax, yMax, xMax, y2);
    CGContextAddLineToPoint(context, xMax, y1);
    CGContextAddQuadCurveToPoint(context, xMax, yMin, x2, yMin);
    CGContextAddLineToPoint(context, x1, yMin);
    CGContextAddQuadCurveToPoint(context, xMin, yMin, xMin, y1);
    CGContextClosePath(context);
    
    CGContextEOFillPath(context);
    CGContextRestoreGState(context);
}

- (void)drawLinearGradien:(CGPoint)startPoint endPoint:(CGPoint)endPoint inRect:(CGRect)rect startColor:(UIColor *)startColor endColor:(UIColor *)endColor tcontext:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    startColor = startColor != nil ? startColor : [UIColor clearColor];
    endColor = endColor != nil ? endColor : [UIColor clearColor];
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [startColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGFloat red1 = 0.0, green1 = 0.0, blue1 = 0.0, alpha1 = 0.0;
    [endColor getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    CGFloat colors[] = {
        red, green, blue, alpha,
        red1, green1, blue1, alpha1,
    };
    CGContextSaveGState(context);
    CGColorSpaceRef rgbSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgbSpace, colors, NULL, sizeof(colors) /  (sizeof(colors[0]) * 4));
    CGColorSpaceRelease(rgbSpace);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation|kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
}

- (void)drawRadialGradien:(CGPoint)startCenter startRadius:(CGFloat)startRadius endCenter:(CGPoint)endCenter endRadius:(CGFloat)endRadius inRect:(CGRect)rect startColor:(UIColor *)startColor endColor:(UIColor *)endColor tcontext:(CGContextRef)context {
    if (context == NULL) {
        return;
    }
    startColor = startColor != nil ? startColor : [UIColor clearColor];
    endColor = endColor != nil ? endColor : [UIColor clearColor];
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [startColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGFloat red1 = 0.0, green1 = 0.0, blue1 = 0.0, alpha1 = 0.0;
    [endColor getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    CGFloat colors[] = {
        red, green, blue, alpha,
        red1, green1, blue1, alpha1,
    };
    CGContextSaveGState(context);
    CGColorSpaceRef rgbSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgbSpace, colors, NULL, sizeof(colors) /  (sizeof(colors[0]) * 4));
    CGColorSpaceRelease(rgbSpace);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawRadialGradient(context, gradient, startCenter, startRadius, endCenter, endRadius, kCGGradientDrawsAfterEndLocation|kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
}

@end
