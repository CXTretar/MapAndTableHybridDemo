//
//  ViewController.m
//  MapAndTableHybridDemo
//
//  Created by Felix on 2018/8/5.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "ViewController.h"
#import "MapTableSeparateController.h"
#import "MapTableMergeController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 地图和列表分离操作样式

- (IBAction)separateVC:(id)sender {
    
    MapTableSeparateController *vc = [MapTableSeparateController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 地图和列表合并操作样式

- (IBAction)mergeVC:(id)sender {
    
    MapTableMergeController *vc = [MapTableMergeController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
