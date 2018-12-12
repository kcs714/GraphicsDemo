//
//  PDFReaderView.m
//  Advertisement
//
//  Created by  kcs on 2017/12/22.
//  Copyright © 2017年 KCS. All rights reserved.
//

#import "PDFReaderView.h"

@interface PDFReaderView() {
    CGPDFDocumentRef _documentRef;
    size_t _pageNum;
}

@property(nonatomic, copy)NSString *pdfPath;

@end

@implementation PDFReaderView

- (instancetype)initWithFrame:(CGRect)frame documentRef:(CGPDFDocumentRef)documentRef pageNum:(size_t)pageNum {
    _documentRef = documentRef;
    _pageNum = pageNum;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor= [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawPDF];
}

- (void)drawPDF {
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(_documentRef, _pageNum);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, self.frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGContextSaveGState(context); //记录当前绘制环境，防止多次绘画
    CGAffineTransform pdfTransForm = CGPDFPageGetDrawingTransform(pageRef, kCGPDFCropBox, self.bounds, 0, true);
    CGContextConcatCTM(context, pdfTransForm);//把创建的仿射变换参数和上下文环境联系起来
    CGContextDrawPDFPage(context, pageRef);//把得到的指定页的PDF数据绘制到视图上
    CGContextRestoreGState(context);//恢复图形状态
}

@end
