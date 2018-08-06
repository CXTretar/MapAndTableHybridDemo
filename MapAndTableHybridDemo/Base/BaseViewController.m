//
//  BaseViewController.m
//  MapAndTableHybridDemo
//
//  Created by Felix on 2018/8/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableView.h"
#import "UIImage+Color.h"
#import "UIColor+HexColor.h"

/*
 * 适配 iPhone X
 * 替换 64px →kTopHeight
 * 替换 49px →kTabBarHeight
 */
#define kBottomHeight (iphoneX ? 34 : 0)
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

@interface BaseViewController ()<MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIButton *backBtn;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgation];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupNavgation {
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    backBtn.alpha = 0.8;
    [backBtn setImage:[UIImage imageNamed:@"btn_map_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = backBtn;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.navigationBar.translucent = YES;
    // 设置导航栏的背景
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 取消掉底部的那根线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    //设置标题
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:16];
    [title sizeToFit];
    // 开始的时候看不见，所以alpha值为0
    title.textColor = [UIColor colorWithWhite:0 alpha:0];
    self.navigationItem.titleView = title;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // 地图部分界面
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    mapView.delegate = self;
    mapView.mapType = MKMapTypeStandard;
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    
    
    // 表格部分
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    BaseTableView *tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.8].CGColor;
    tableView.layer.shadowOffset = CGSizeMake(0, 3);
    tableView.layer.shadowRadius = 4.0f;
    tableView.layer.shadowOpacity = 0.4f;
    tableView.contentInset = UIEdgeInsetsMake(450, 0, 0, 0);
    
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.tableView]) {
        
        //        [self.view endEditing:YES];
        //        CGFloat offset =  scrollView.contentOffset.y - _tableViewHeaderH + kTopHeight * 2;
        //根据透明度来生成图片
        //找最大值/
        CGFloat alpha = scrollView.contentOffset.y / (450);   // (200 - 64) / 136.0f
        if (alpha >= 1) {
            alpha = 0.99;
        }
        self.backBtn.alpha = 0.8 - alpha * 1.2;
        if (self.backBtn.alpha < 0.1) {
            self.backBtn.alpha = 1;
            [self.backBtn setImage:[UIImage imageNamed:@"btn_back_nor"] forState:UIControlStateNormal];
        }else {
            
            [self.backBtn setImage:[UIImage imageNamed:@"btn_map_back"] forState:UIControlStateNormal];
        }
        //拿到标题 标题文字的随着移动高度的变化而变化
        UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#ffffff" alpha:alpha];
        
        //把颜色生成图片
        UIColor *alphaColor = [UIColor colorWithHexColorStr:@"#ffd42c" alpha:alpha];
        //    self.navigationController.navigationBar.barTintColor = alphaColor;
        //把颜色生成图片
        UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
        //    修改导航条背景图片
        [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
    }
}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
