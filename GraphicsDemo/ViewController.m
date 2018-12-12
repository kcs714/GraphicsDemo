//
//  ViewController.m
//  GraphicsDemo
//
//  Created by  kcs on 2018/2/14.
//  Copyright © 2018年 KCS. All rights reserved.
//

#import "ViewController.h"
#import "PDFContextDemoVC.h"
#import "LayerContextDemoVC.h"
#import "BitmapContextDemoVC.h"
#import "CustomizedDemoVC.h"

@interface ViewController ()

@property(nonatomic, strong)NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"PDFContext", @"LayerContext", @"BitmapContext", @"Custom"];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:0];
    tableView.delegate = (id<UITableViewDelegate>)self;
    tableView.dataSource = (id<UITableViewDataSource>)self;
    tableView.rowHeight = 60.0;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"UITableViewCell_1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller = nil;
    if (indexPath.row == 0) {
        controller = [PDFContextDemoVC new];
    } else if (indexPath.row == 1) {
        controller = [LayerContextDemoVC new];
    } else if (indexPath.row == 2) {
        controller = [BitmapContextDemoVC new];
    } else if (indexPath.row == 3) {
        controller = [CustomizedDemoVC new];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
