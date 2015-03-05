//
//  timer_custom_view.h
//  Memo_memo_app
//
//  Created by Takanobu  on 2015/03/04.
//  Copyright (c) 2015年 kolonzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol timer_custom_viewProtocol<NSObject>
- (void)timerButton:(id)senderButton;
@end

@interface timer_custom_view : UIView
{
    NSTimer *timer_cell;
}
@property (nonatomic, weak) id<timer_custom_viewProtocol> delegate;

@property (nonatomic) int second;
@property (nonatomic,weak) IBOutlet UILabel *time_label;
@property (nonatomic,weak) IBOutlet UIButton *timer_button;
+ (instancetype)view;

@end
