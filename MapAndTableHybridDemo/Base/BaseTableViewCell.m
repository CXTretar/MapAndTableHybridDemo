//
//  BaseTableViewCell.m
//  MapAndTableHybridDemo
//
//  Created by Felix on 2018/8/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (id)createCellWithTableView:(UITableView *)tableView {
    NSString *cellID = NSStringFromClass([self class]);
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - 设置控件约束

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, CellHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CellHeight, CellHeight)];
    [bgView addSubview:bgImage];
    bgImage.center = bgView.center;
    self.bgImage = bgImage;
    
}

@end
