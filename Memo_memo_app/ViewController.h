//
//  ViewController.h
//  Memo_memo_app
//
//  Created by Takanobu  on 2015/01/21.
//  Copyright (c) 2015年 kolonzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *cells;
    UIScrollView *scroll_view;
    int hour;
    int minute;
    int second;
    
    IBOutlet UILabel *time_label;
    
//    IBOutlet UIImageView *haikei_view;
}
-(IBAction)timer_start;
-(IBAction)timer_stop;
-(IBAction)second_up;
@end

