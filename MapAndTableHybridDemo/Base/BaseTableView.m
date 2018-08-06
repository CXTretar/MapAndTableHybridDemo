//
//  BaseTableView.m
//  MapAndTableHybridDemo
//
//  Created by Felix on 2018/8/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    NSLog(@"point=%@",NSStringFromCGPoint(point));
    
    NSLog(@"y=%f",self.contentOffset.y);
//
    if (point.y < 0) {
        return nil;
    }
//
    return  [super hitTest:point withEvent:event];
}

@end
