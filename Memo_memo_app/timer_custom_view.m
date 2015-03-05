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
    } else {
        NSLog(@"no");
        [timer_cell invalidate];
    }
}
-(void)second_up{
    self.second++;
    self.time_label.text=[NSString stringWithFormat:@"%d",self.second];
}
@end