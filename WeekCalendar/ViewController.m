//
//  ViewController.m
//  WeekCalendar
//
//  Created by zgy on 16/1/28.
//  Copyright © 2016年 zgy. All rights reserved.
//

#import "ViewController.h"
#import "GYWeeklyCalendarView.h"

@interface ViewController ()<GYWeeklyCalendarViewDelegate>

@property(nonatomic, strong) UILabel *dateLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    GYWeeklyCalendarView *calendar = [[GYWeeklyCalendarView alloc]initWithFrame:CGRectMake(0, 80, width, 130)];
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:calendar];
    
    
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, calendarHeight + 15 , width, 40)];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.textColor = [UIColor darkTextColor];
    dateLabel.font = [UIFont boldSystemFontOfSize:18.f];
    self.dateLabel = dateLabel;
    [calendar addSubview:dateLabel];
}
- (void)calendarView:(GYWeeklyCalendarView *)calendar didSelectDay:(GYDayView *)dayview
{
    self.dateLabel.text = [NSString stringWithFormat:@"选中日期:  %@", dayview.date];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
