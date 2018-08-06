//
//  UIColor+HexColor.h
//  MapAndTableHybridDemo
//
//  Created by Felix on 2018/8/6.
//  Copyright © 2018年 CXTretar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)


/**
 *  将美工给的十六进制颜色字符串转换成颜色
 *  可以解析的颜色字符串：#666666 0x666666 666666
 *
 *  @param colorStr 十六进制颜色字符串
 *
 *  @return UIColor 默认透明度为1.0
 */
+ (UIColor *)colorWithHexColorStr:(NSString *)colorStr;

+ (UIColor *)colorWithHexColorStr:(NSString *)colorStr alpha:(CGFloat)alpha;

// 18种路径颜色
+ (NSString *)colorWithIndex:(NSInteger)index;


@end
