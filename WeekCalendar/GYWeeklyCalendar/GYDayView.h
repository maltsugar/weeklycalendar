//
//  GYDayView.h
//  WeekCalendar
//
//  Created by zgy on 16/1/28.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYDayView;
@protocol GYDayViewDelegate <NSObject>

- (void)dayViewSelected:(GYDayView *)dayView;

@end


@interface GYDayView : UIView


@property(nonatomic,   copy) NSString *weekString;
@property(nonatomic, strong) NSDate *date;


@property(nonatomic, strong) UILabel *weekLabel;
@property(nonatomic, strong) UILabel *dayLabel;
@property(nonatomic, strong) UILabel *monthLabel;

@property(nonatomic,   weak) id<GYDayViewDelegate> delegate;
@end
