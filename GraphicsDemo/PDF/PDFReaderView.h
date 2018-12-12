//
//  PDFReaderView.h
//  Advertisement
//
//  Created by  kcs on 2017/12/22.
//  Copyright © 2017年 KCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFReaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame documentRef:(CGPDFDocumentRef)documentRef pageNum:(size_t)pageNum;

@end
