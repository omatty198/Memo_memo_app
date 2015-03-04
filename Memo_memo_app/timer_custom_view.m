//
//  timer_custom_view.m
//  Memo_memo_app
//
//  Created by Takanobu  on 2015/03/04.
//  Copyright (c) 2015年 kolonzu. All rights reserved.
//

#import "timer_custom_view.h"

@implementation timer_custom_view {
    NSTimer *timer_cell;
    int second;
    IBOutlet UILabel *time_label;

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
    second++;
    time_label.text=[NSString stringWithFormat:@"%d",second];
}
@end