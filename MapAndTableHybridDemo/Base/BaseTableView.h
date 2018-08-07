//
//  BaseTableView.h
//  MapAndTableHybridDemo
//
//  Created by Felix on 2018/8/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickHeadBlock)(void);

@interface BaseTableView : UITableView

@property (nonatomic, copy) ClickHeadBlock clickHeadBlock;

@property (nonatomic, assign) BOOL isSeparate;

- (void)scrollToTopAnimated:(BOOL)animated;

@end
