//
//  ViewController.m
//  simplyWakeUpSimply
//
//  Created by myComputer on 10/29/15.
//  Copyright © 2015 presentPhase. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *AlarmLabel;
@property (weak, nonatomic) IBOutlet UISwitch *AlarmActiveSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *TimePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *TimeFormatToggle;
@property (weak, nonatomic) IBOutlet UIButton *ActivateAlarmButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)AlarmOnOffAction:(UISwitch *)sender {
    self.AlarmLabel.text = sender.on ? @"Alarm: ON" : @"Alarm: OFF";
    self.ActivateAlarmButton.enabled = sender.on;
}

- (IBAction)TimeSelectedAction:(UIDatePicker *)sender {
    [self scheduleNotificationForDate:sender.date];
}

- (IBAction)ToggleFormatAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"US"];
        [self.TimePicker setLocale:locale];
    } else {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
        [self.TimePicker setLocale:locale];
    }
}
- (IBAction)ActivateAlarmAction:(UIButton *)sender {
    
}


- (void)scheduleNotificationForDate:(NSDate *)date
{
    // Here we cancel all previously scheduled notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = date;
    NSLog(@"Notification will be shown on: %@",localNotification.fireDate);
    
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = [NSString stringWithFormat:@"Your notification message"];
    localNotification.alertAction = NSLocalizedString(@"View details", nil);
    
    /* Here we set notification sound and badge on the app's icon "-1"
     means that number indicator on the badge will be decreased by one
     - so there will be no badge on the icon */
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = -1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
