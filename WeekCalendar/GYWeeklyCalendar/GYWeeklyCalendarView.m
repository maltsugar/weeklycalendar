//
//  GYWeeklyCalendarView.m
//  WeekCalendar
//
//  Created by zgy on 16/1/28.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import "GYWeeklyCalendarView.h"
#import "GYWeeklyContainerView.h"
#import "NSDate+Utilities.h"

@interface GYWeeklyCalendarView()<UIScrollViewDelegate, GYWeeklyContainerViewDelegate>


@property(nonatomic, strong) NSArray *currentWeekDates;
@property(nonatomic, strong) NSArray *threeWeekDates;

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSArray *weeklyViews; ///< include 3 weeklyView(GYWeeklyContainerView) for scrollView


@property(nonatomic, strong) CAShapeLayer *indicator;

// recorde selected weekday
@property(nonatomic, assign) NSInteger  selectedWeekday;
@end

@implementation GYWeeklyCalendarView

- (CAShapeLayer *)indicator
{
    if (nil == _indicator) {
        
        float width = (self.frame.size.width - leftAndRightMargin*2)/7;
        _indicator = [[CAShapeLayer alloc]init];
        [self.layer addSublayer:_indicator];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, 0, 0);
        CGPathAddLineToPoint(path, nil, 0, calendarHeight);
        CGPathAddLineToPoint(path, nil, width*0.5, calendarHeight + 15);
        CGPathAddLineToPoint(path, nil, width, calendarHeight);
        CGPathAddLineToPoint(path, nil, width, 0);
    
        _indicator.path = path;
        CGPathRelease(path);
        _indicator.lineWidth = 1;
        _indicator.strokeColor = [UIColor blackColor].CGColor;
        _indicator.fillColor = [UIColor clearColor].CGColor;
        
        CAShapeLayer *triangleLayer = [[CAShapeLayer alloc]init];
        [_indicator addSublayer:triangleLayer];
        CGMutablePathRef path1 = CGPathCreateMutable();
        CGPathMoveToPoint(path1, nil, 0, 0);
        CGPathAddLineToPoint(path1, nil, width*0.5,15);
        CGPathAddLineToPoint(path1, nil, width, 0);
        triangleLayer.path = path1;
        CGPathRelease(path1);
        triangleLayer.lineWidth = 1;
        triangleLayer.strokeColor = [UIColor blackColor].CGColor;
        triangleLayer.fillColor = [UIColor whiteColor].CGColor;
        triangleLayer.frame = CGRectMake(0, calendarHeight, width, 15);
    
    }
    return _indicator;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        
        
        [self setupCurrentWeekDates];
        
        
        NSMutableArray *temp = @[].mutableCopy;
        for (int i = 0; i < 3; i++) {
            GYWeeklyContainerView *weekView = [[GYWeeklyContainerView alloc]init];
            weekView.delegate = self;
            weekView.backgroundColor = [UIColor whiteColor];
            [temp addObject:weekView];
            [_scrollView addSubview:weekView];
            
        }
        _weeklyViews = temp.copy;
        
        
    }
    return self;
}

#pragma mark- GYWeeklyContainerViewDelegate
- (void)selectedDay:(GYDayView *)day
{
    self.selectedWeekday = [day.date weekday];
    self.indicator.frame = CGRectMake(day.frame.origin.x, day.frame.origin.y, day.frame.size.width, day.frame.size.height + 15);
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectDay:)]) {
        [self.delegate calendarView:self didSelectDay:day];
    }
 
}


#pragma mark- private method
// 设定当前周的 一周日期
// set this week dates
- (void)setupCurrentWeekDates
{
    NSMutableArray *arr = @[].mutableCopy;
    NSDate *date = [NSDate new];
    // 今天周几
    NSInteger weekday = [date weekday];  // 1--7 表示周日                周一（2）放在第一位
    NSInteger todayIndex =  (weekday - 2) >= 0 ? (weekday-2) : (weekday-2)+7;
    
    
    // 周一（weekday = 2）至今天的天数， i = 0 ，即是今天
    //  days from  Monday to today
    for (NSInteger i = todayIndex; i >=0; i -- ) {
        NSDate *preDate = [date dateBySubtractingDays:i];
        [arr addObject:preDate];
    }
    
    // 明天至周日的天数
    // days from tomorrow to Sunday
    for (int i = 1; i <= 6 - todayIndex; i ++) {
        NSDate *new = [date dateByAddingDays:i];
        [arr addObject:new];
    }
    _currentWeekDates = arr;
}

// next week
- (NSArray *)getNextWeekDates
{
    NSMutableArray *arr = @[].mutableCopy;
    for (int i = 0; i < _currentWeekDates.count; i++) {
        NSDate *new = [_currentWeekDates[i] dateByAddingDays:7];
        [arr addObject:new];
    }
    
    return arr;
}

// last week
- (NSArray *)getPreWeekDates
{
    NSMutableArray *arr = @[].mutableCopy;
    for (int i = 0; i < _currentWeekDates.count; i++) {
        NSDate *new = [_currentWeekDates[i] dateBySubtractingDays:7];
        [arr addObject:new];
    }
    
    return arr;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSArray *dates = @[[self getPreWeekDates], _currentWeekDates, [self getNextWeekDates]];
    self.threeWeekDates = dates;
    

    
    _scrollView.frame = CGRectMake(0, 0.5, self.frame.size.width, calendarHeight);
    for (int i = 0; i < 3; i++) {
        GYWeeklyContainerView *view = _weeklyViews[i];
        view.frame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, calendarHeight);
    }
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, calendarHeight);
    
    CGPoint point1 = CGPointMake(self.frame.size.width, 0);
    _scrollView.contentOffset = point1;
    
}

- (void)setThreeWeekDates:(NSArray *)threeWeekDates
{
    _threeWeekDates = threeWeekDates;
    
    for (int i = 0; i < _weeklyViews.count; i++) {
        GYWeeklyContainerView *weekView = _weeklyViews[i];
        
        // set selected weekday
        if (i == 1) {
            weekView.selectedWeekday = self.selectedWeekday;
        }else
        {
            weekView.selectedWeekday = 0;
        }
        
        
        weekView.dates = threeWeekDates[i];
        
        
    }

}


#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat width = self.frame.size.width;
    if (scrollView.contentOffset.x > width*(1.5)) {
        _currentWeekDates = [self.threeWeekDates lastObject];
        self.threeWeekDates = @[[self getPreWeekDates], _currentWeekDates, [self getNextWeekDates]];
        
    }
    
    if (scrollView.contentOffset.x < width* 0.5) {
        _currentWeekDates = [self.threeWeekDates firstObject];
        self.threeWeekDates = @[[self getPreWeekDates], _currentWeekDates, [self getNextWeekDates]];
    }

    
    
    
    CGPoint point1 = CGPointMake(self.frame.size.width, 0);
    CGPoint point2 = scrollView.contentOffset;
    if (!CGPointEqualToPoint(point1, point2)) {
        scrollView.contentOffset = point1;
    }
}
@end
