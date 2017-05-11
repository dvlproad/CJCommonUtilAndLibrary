//
//  DateViewController.m
//  CJFoundationDemo
//
//  Created by dvlproad on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DateViewController.h"

#import <CJBaseUIKit/CJAddSubtractTextField.h>
#import <CJPicker/CJDefaultDatePicker.h>
#import <CJPopupAction/UIView+CJShowExtendView.h>

#import "NSDate+CJDateDistance.h"

@interface DateViewController () {
    
}
@property (nonatomic, strong) CJAddSubtractTextField *dateTextField;
@property (nonatomic) NSDate *currentDate;

@property (nonatomic, weak) IBOutlet UILabel *originCurrentTime1;
@property (nonatomic, weak) IBOutlet UISwitch *correctConvertSwitch1;
@property (nonatomic, weak) IBOutlet UILabel *resultCurrentTime1;

@property (nonatomic, weak) IBOutlet UILabel *originCurrentTime2;
@property (nonatomic, weak) IBOutlet UISwitch *correctConvertSwitch2;
@property (nonatomic, weak) IBOutlet UILabel *resultCurrentTime2;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupChooseDatePicker];
    
    self.currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    self.dateTextField.text = [dateFormatter stringFromDate:self.currentDate];
    
}

//参考：http://blog.sina.com.cn/s/blog_708663ad0102wf1z.html
- (IBAction)getStringFromDate1:(id)sender {
    NSLog(@"-------------------------------------------");
    NSString *currentTime = self.originCurrentTime1.text; //2017-04-17 20:20:08
    NSLog(@"originDateString       = %@", currentTime);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if (self.correctConvertSwitch1.isOn) {
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; //解决NSString转NSDate差8小时的问题
    }
    
    //①string转换为date少了8个小时，加上UTC后，正常
    NSDate *date = [dateFormatter dateFromString:currentTime];
    NSLog(@"after convert to date  = %@", date);//错误时候为2017-04-17 12:20:08 +0000，即少了8个小时
    
    self.resultCurrentTime1.text = [dateFormatter stringFromDate:date];
    
    //②date转换为string又多了8个小时
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateString = [dateFormatter stringFromDate:self.currentDate];
//    self.resultCurrentTime1.text = [dateFormatter stringFromDate:date];
    NSLog(@"date convert to string = %@", dateString);
}

- (IBAction)getStringFromDate2:(id)sender {
    
}

- (void)setupChooseDatePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    self.dateTextField = [[CJAddSubtractTextField alloc] initWithFrame:CGRectZero];
    self.dateTextField.hideCursor = YES;
    self.dateTextField.hideMenuController = YES;
    
    __weak typeof(self)weakSelf = self;
    [self.dateTextField addLeftButtonImage:[UIImage imageNamed:@"plus"] withLeftHandel:^(UITextField *textField) {
        [weakSelf hideDateChoosePicker];
        
        NSDate *date = [weakSelf.currentDate cj_yesterday];
        textField.text = [dateFormatter stringFromDate:date];
        
        weakSelf.currentDate = date;
    }];
    [self.dateTextField addRightButtonImage:[UIImage imageNamed:@"plus"] withRightHandel:^(UITextField *textField) {
        [weakSelf hideDateChoosePicker];
        
        NSDate *date = [weakSelf.currentDate cj_tomorrow];
        textField.text = [dateFormatter stringFromDate:date];
        
        weakSelf.currentDate = date;
    }];
    
    
    CJDefaultDatePicker *datePicker = [[CJDefaultDatePicker alloc] init];
    datePicker.datePicker.datePickerMode = UIDatePickerModeDate;
    __weak typeof(datePicker)weakdatePicker = datePicker;
    [datePicker.toolbar setConfirmHandle:^{
        [weakSelf hideDateChoosePicker];
        
        NSDate *date = weakdatePicker.datePicker.date ;
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        self.dateTextField.text = dateString;
    }];
    /*
    [datePicker setValueChangedHandel:^(UIDatePicker *datePicker) {
        [weakSelf hideDateChoosePicker];
        NSDate *date = datePicker.date ;
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        self.dateTextField.text = dateString;
    }];
    */
    self.dateTextField.inputView = datePicker;
    
    [self.dateTextField setFrame:CGRectMake(20, 100, 280, 30)];
    [self.view addSubview:self.dateTextField];
}

- (void)hideDateChoosePicker {
    [self.dateTextField endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self hideDateChoosePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
