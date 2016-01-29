//
//  GYDayView.m
//  WeekCalendar
//
//  Created by zgy on 16/1/28.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import "GYDayView.h"
#import "NSDate+Utilities.h"
@interface GYDayView()



@end

@implementation GYDayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _weekLabel = [[UILabel alloc]init];
        _weekLabel.font = [UIFont systemFontOfSize:12.f];
        _weekLabel.textAlignment = NSTextAlignmentCenter;

        _dayLabel = [[UILabel alloc]init];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        
        _monthLabel = [[UILabel alloc]init];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.font = [UIFont systemFontOfSize:10.f];
        
        
        [self addSubview:_weekLabel];
        [self addSubview:_dayLabel];
        [self addSubview:_monthLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDayView)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)tapDayView
{
    if ([self.delegate respondsToSelector:@selector(dayViewSelected:)]) {
        [self.delegate dayViewSelected:self];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _weekLabel.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    _dayLabel.frame = CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 30 - 15);
    _monthLabel.frame = CGRectMake(0, CGRectGetMaxY(_dayLabel.frame), self.frame.size.width, 15);
    
    _weekLabel.text = [self.date getWeekDayString];
    _dayLabel.text = [NSString stringWithFormat:@"%ld", [self.date day]];
    _monthLabel.text = [self.date getMonthString];
    
    self.weekString = [self.date getWeekDayString];
    
    
    if ([self.date isEqualToDateIgnoringTime:[NSDate new]]) {
        [self tapDayView];
    }
}

- (void)setDate:(NSDate *)date
{   _date = date;
    _weekLabel.text = [NSString stringWithFormat:@"%@", [self.date getWeekDayString]];
    _dayLabel.text = [NSString stringWithFormat:@"%ld", [self.date day]];
    _monthLabel.text = [self.date getMonthString];
    self.weekString = [self.date getWeekDayString];
}
@end
