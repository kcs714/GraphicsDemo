//
//  DrawInfo.h
//  AnimalTableDemo
//
//  Created by  kcs on 2018/2/8.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawInfo : NSObject

@property(nonatomic, copy)NSString *text; //文字
@property(nonatomic, strong)UIImage *image; //图片

@property(nonatomic, assign)CGRect drawRect; //绘制区域
@property(nonatomic, assign)CGRect eventRect; //事件区域（默认：drawRect + eventInset）
@property(nonatomic, assign)UIEdgeInsets eventInset; //事件区域的扩展边距

@end
