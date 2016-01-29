//
//  GYWeeklyCalendarView.h
//  WeekCalendar
//
//  Created by zgy on 16/1/28.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYDayView.h"

#define calendarHeight 65  // frame height must larger than calendarHeight + 15

@class GYWeeklyCalendarView;
@protocol GYWeeklyCalendarViewDelegate <NSObject>

@optional
- (void)calendarView:(GYWeeklyCalendarView *)calendar didSelectDay:(GYDayView *)dayview;

@end

@interface GYWeeklyCalendarView : UIView


@property(nonatomic, weak)id<GYWeeklyCalendarViewDelegate> delegate;

@end
