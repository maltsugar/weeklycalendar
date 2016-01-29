//
//  GYWeeklyContainerView.m
//  WeekCalendar
//
//  Created by zgy on 16/1/28.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import "GYWeeklyContainerView.h"
#import "NSDate+Utilities.h"
@interface GYWeeklyContainerView()<GYDayViewDelegate>

@property(nonatomic, strong) NSMutableArray *dayViewArray;


@property(nonatomic, strong) GYDayView *currentSelectedView;
@end

@implementation GYWeeklyContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dayViewArray = @[].mutableCopy;
        for (int i = 0; i < 7; i ++) {
            GYDayView *view = [[GYDayView alloc]init];
            view.delegate = self;
            [_dayViewArray addObject:view];
            [self addSubview:view];
            
        }
    }
    return self;
}


#pragma mark- GYDayViewDelegate
- (void)dayViewSelected:(GYDayView *)dayView
{
    if ([self.delegate respondsToSelector:@selector(selectedDay:)]) {
        [self.delegate selectedDay:dayView];
    }
}

#pragma mark-
- (void)layoutSubviews
{
    [super layoutSubviews];
    float width = (self.frame.size.width-leftAndRightMargin*2) / 7;
    for (int i = 0; i < _dayViewArray.count; i ++) {
        GYDayView *view = _dayViewArray[i];
        view.frame = CGRectMake((5+width * i), 0, width, self.frame.size.height);
        view.date = _dates[i];
    }
}

- (void)setDates:(NSArray *)dates
{
    _dates = dates;
    
    for (int i = 0; i < _dayViewArray.count; i ++) {
        GYDayView *view = _dayViewArray[i];
        view.date = _dates[i];
        
        if (self.selectedWeekday != 0) {
            
            if ([view.date weekday] == self.selectedWeekday) {
                [self dayViewSelected:view];
            }
        }
    }
}

@end
