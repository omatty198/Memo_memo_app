//
//  timer_custom_view.m
//  Memo_memo_app
//
//  Created by Takanobu  on 2015/03/04.
//  Copyright (c) 2015年 kolonzu. All rights reserved.
//

#import "timer_custom_view.h"

@implementation timer_custom_view
//アーカイブされたファイルからオブジェクトの状態を復元するときに呼ばれるメソッド
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    self = [super init];
//    if (self) {
//        _second = [decoder decodeIntForKey:@"second"];
//        _time_label = [decoder decodeObjectForKey:@"time_label"];
//        if (_second == 0 && _time_label == nil) {
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 19, 96, 35)];
//            label.text = [NSString stringWithFormat:@"%d",_second];
//            _time_label = label;
//            [self addSubview:_time_label];
//            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(34, 62, 33, 30)];
//            [button setTitle:@"START" forState:UIControlStateNormal];
//            _timer_button = button;
//            [self addSubview:_timer_button];
//        }
//    }
//    return self;
//}
+ (instancetype)view
{
    NSString *className = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:0] firstObject];
}
- (IBAction)timerButton:(UIButton *)sender {
    //TODO: if で timerの初期化と、
    sender.selected = !sender.selected;
    if (sender.selected) {
        timer_cell=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(second_up) userInfo:nil repeats:YES];
        NSLog(@"yes");
        //self.second = 2;

    } else {
        NSLog(@"no");
        [timer_cell invalidate];
    }
}
-(void)second_up{
    self.second--;
    self.time_label.text=[NSString stringWithFormat:@"%d",self.second];
    //TODO: アプリを終了した時はsecondが消えてしまうので、
    //NSTimerを使うのではなく、NSDate isTimerInterval等で設定した方が良い
    if (self.second == 0) {
        // 設定する前に、設定済みの通知をキャンセルする
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        // 設定し直す
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        //1秒後に通知
        NSDate *after3 = [NSDate dateWithTimeIntervalSinceNow:1.0];
        localNotification.fireDate = after3;
        localNotification.alertBody = @"Fire!";
        localNotification.timeZone = [NSTimeZone localTimeZone];
        //FIX: soundNameは自分で用意した音でも30秒以内なら可能
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertAction = @"OPEN";
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        //timer止める
        [timer_cell invalidate];
    }
}
@end