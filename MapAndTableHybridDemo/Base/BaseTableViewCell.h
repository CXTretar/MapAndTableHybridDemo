//
//  BaseTableViewCell.h
//  MapAndTableHybridDemo
//
//  Created by Felix on 2018/8/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CellHeight 200

@interface BaseTableViewCell : UITableViewCell

+ (id)createCellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) UIImageView *bgImage;

@end
