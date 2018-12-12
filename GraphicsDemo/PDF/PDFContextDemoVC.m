//
//  PDFContextDemoVC.m
//  GraphicsDemo
//
//  Created by  kcs on 2018/2/14.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "PDFContextDemoVC.h"
#import "PDFHandler.h"
#import "PDFReaderView.h"

#define kScreenS [UIScreen mainScreen].bounds.size

@interface PDFContextDemoVC ()

@end

@implementation PDFContextDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubviews];
}

- (void)setupSubviews {
    UIButton *btn1 = [self getButton:CGRectMake(0, kScreenS.height - 50, kScreenS.width, 30) tag:1 title:@"生成PDF"];
    [self.view addSubview:btn1];
    UIButton *btn2 = [self getButton:CGRectMake(0, CGRectGetMinY(btn1.frame) - 35, kScreenS.width, 30) tag:2 title:@"显示PDF"];
    [self.view addSubview:btn2];
}

- (UIButton *)getButton:(CGRect)frame tag:(NSUInteger)tag title:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnEvent:(UIButton *)sender {
    if (sender.tag == 1) {
        [self generatePDF];
    } else if (sender.tag == 2) {
        NSString *pdfPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/abc.pdf"];
        CGPDFDocumentRef docRef = NULL;
        [self pdfDocumentRefWithPath:pdfPath document:&docRef];
        PDFReaderView *pdfView = [[PDFReaderView alloc] initWithFrame:CGRectMake(0, 70, kScreenS.width, kScreenS.height - 160) documentRef:docRef pageNum:1];
        [self.view addSubview:pdfView];
    }
}

- (void)generatePDF {
    CGRect rect = self.view.bounds;
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/abc.pdf"];
    PDFHandler *pdfHandler = [[PDFHandler alloc] initWithPageRect:rect path:path];
    [[[pdfHandler addPage:nil pageBlock:^(PDFDrawer *drawer) {
        drawer.drawColor = [UIColor redColor];
        [drawer drawRect:CGRectMake(10, 10, 100, 100) radiusX:20 radiusY:20];
        [drawer drawEllipseInRect:CGRectMake(120, 120, 100, 100)];
        [drawer drawLine:CGPointMake(120, 10) toPoint:CGPointMake(200, 120)];
        
        [drawer addURL:@"https://www.baidu.com" infoText:@"跳转百度跳转百度" inRect:CGRectMake (0, 0, 100, 50)];
        
        [drawer setDestination:@"hello" destPoint:CGPointMake(0.0, 10.0)];
        
    }] addPage:nil pageBlock:^(PDFDrawer *drawer) {
        UIImage *img = [UIImage imageNamed:@"auto.jpg"];
        [drawer drawImage:img inRect:CGRectMake(10, 0, 100, 100) radius:20 borderWidth:0.5 borderColor:[UIColor redColor]];
        
    }] addPage:nil pageBlock:^(PDFDrawer *drawer) {
        drawer.fontSize = 10;
        drawer.fontColor = [UIColor redColor];
        NSString *text = @"控件的福克斯的福克斯可接受的父控件的上课看来是交电费卡了但是看电视剧焚枯食淡可接受的开发控件的时空裂缝静安寺卡兰蒂斯放哪里";
        [drawer drawText:text inRect:CGRectMake(0, 100, 375, 300)];
        
        [drawer jumpToDestination:@"hello" infoText:@"跳转到第一页" destRect:CGRectMake(10.0, 10.0, 100.0, 30.0)];
    }];
    
    NSLog(@">>>\n%@", path);
}

- (void)pdfDocumentRefWithPath:(NSString *)pdfPath document:(CGPDFDocumentRef *)document {
    CFStringRef path = CFStringCreateWithCString(NULL, [pdfPath UTF8String], kCFStringEncodingUTF8);
    CFURLRef url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
    CFRelease(path);
    *document = CGPDFDocumentCreateWithURL(url);
    CFRelease(url);
}

@end
