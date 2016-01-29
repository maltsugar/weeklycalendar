//
//  GYWeeklyContainerView.h
//  WeekCalendar
//
//  Created by zgy on 16/1/28.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYDayView.h"

#define leftAndRightMargin 5

@protocol GYWeeklyContainerViewDelegate <NSObject>

- (void)selectedDay:(GYDayView *)day;

@end

@interface GYWeeklyContainerView : UIView

@property(nonatomic, strong) NSArray *dates;
@property(nonatomic,   weak) id<GYWeeklyContainerViewDelegate> delegate;
@property(nonatomic, assign) NSInteger  selectedWeekday;

@end
