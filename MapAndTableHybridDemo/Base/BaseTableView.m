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
    if (point.y < 0) {
        if (_isSeparate) {
            if (self.clickHeadBlock) {
                self.clickHeadBlock();
            }
        }else {
            return nil;
        }
    }
    return  [super hitTest:point withEvent:event];
}

- (void)scrollToTopAnimated:(BOOL)animated {
    
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top - kTopHeight;
    
    [self setContentOffset:off animated:animated];
}


@end
