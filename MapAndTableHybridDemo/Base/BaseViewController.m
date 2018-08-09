//
//  BaseViewController.m
//  MapAndTableHybridDemo
//
//  Created by Felix on 2018/8/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Color.h"
#import "UIColor+HexColor.h"
#import "BaseTableViewCell.h"


#define TableTopInset (kScreenHeight - CellHeight)

typedef NS_ENUM(NSUInteger, BtnType) {
    BackBtnType  = 1000, // 返回按钮
    CloseBtnType,        // 关闭按钮
};

@interface BaseViewController ()<MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIButton *backBtn;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstPositionFound;

@end

@implementation BaseViewController


- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        //设置定位属性
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置定位更行距离  米
        _locationManager.distanceFilter = 10.0;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = @[@"zj01",@"zj02",@"zj03"].copy;
    
    [self setupNavgation];
    [self setupUI];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusNotDetermined == status) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
}

- (void)setupNavgation {
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    backBtn.tag = BackBtnType;
    backBtn.alpha = 0.8;
    [backBtn setImage:[UIImage imageNamed:@"btn_map_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = backBtn;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.navigationBar.translucent = YES;
    // 设置导航栏的背景
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 取消掉底部的那根线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    //设置标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"MapTableSeparateController";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel sizeToFit];
    // 开始的时候看不见，所以alpha值为0
    titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0];
    self.titleLabel = titleLabel;
    self.navigationItem.titleView = titleLabel;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // 地图部分界面
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, - CellHeight, kScreenWidth, kScreenHeight + CellHeight)];
    mapView.delegate = self;
    mapView.mapType = MKMapTypeStandard;
    mapView.showsUserLocation = YES;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    
    // 表格部分
    BaseTableView *tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.8].CGColor;
    tableView.layer.shadowOffset = CGSizeMake(0, 3);
    tableView.layer.shadowRadius = 4.0f;
    tableView.layer.shadowOpacity = 0.4f;
    tableView.contentInset = UIEdgeInsetsMake(TableTopInset, 0, 0, 0);
    tableView.rowHeight = CellHeight + 10;
    
    __weak typeof(self) weakSelf = self;
    tableView.clickHeadBlock = ^{
        [UIView animateWithDuration:0.5 animations:^{
            
            weakSelf.tableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
            
        } completion:^(BOOL finished) {

            [weakSelf.backBtn setImage:[UIImage imageNamed:@"btn_map_close"] forState:UIControlStateNormal];
            weakSelf.backBtn.tag = CloseBtnType;
            [weakSelf.tableView scrollToTopAnimated:NO];
            
        }];
    };
    
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    // 适配iOS 11
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (userLocation && !_isFirstPositionFound) {
        _isFirstPositionFound = YES;
        MKCoordinateSpan theSpan;
        //地图的范围 越小越精确
        theSpan.latitudeDelta = 0.05;
        theSpan.longitudeDelta = 0.05;
        MKCoordinateRegion theRegion;
        theRegion.center = userLocation.coordinate;
        theRegion.span = theSpan;
        [mapView setRegion:theRegion];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.imageArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseTableViewCell *cell = [BaseTableViewCell createCellWithTableView:tableView];
//    cell.bgImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    return cell;
    
}

#pragma mark - Scrollview Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.tableView]) {
        //根据透明度来生成图片
        //找最大值/
        NSLog(@"alpha %f", (TableTopInset + scrollView.contentOffset.y));
        CGFloat alpha = (TableTopInset + scrollView.contentOffset.y) / (TableTopInset);   // (200 - 64) / 136.0f
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

#pragma mark - Private methods

- (void)back:(UIButton *)sender {
    if (sender.tag == BackBtnType) {

        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag == CloseBtnType) {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            
        } completion:^(BOOL finished) {
           
            [self.backBtn setImage:[UIImage imageNamed:@"btn_map_back"] forState:UIControlStateNormal];
            self.backBtn.tag = BackBtnType;
        }];
    }
   
}

#pragma mark - 去除地图缓存

//  切换地图类型, 减少内存占用
- (void)applyMapViewMemoryHotFix {
    switch (self.mapView.mapType) {
        case MKMapTypeHybrid:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case MKMapTypeStandard:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
    self.mapView.mapType = MKMapTypeStandard;
}

- (void)dealloc {
    [self applyMapViewMemoryHotFix];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = NO;
    [_mapView.layer removeAllAnimations];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeFromSuperview];
    _mapView.delegate = nil;
    _mapView = nil;
    
}


@end
