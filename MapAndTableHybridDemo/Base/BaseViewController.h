//
//  BaseViewController.h
//  MapAndTableHybridDemo
//
//  Created by Felix on 2018/8/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BaseTableView.h"

@interface BaseViewController : UIViewController

@property (nonatomic, weak) MKMapView *mapView;
@property (nonatomic, weak) BaseTableView *tableView;
@property (nonatomic, weak) UILabel *titleLabel;

@end
