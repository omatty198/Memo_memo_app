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
    IBOutlet UIScrollView *scroll_view;
    int hour;
    int minute;
    int second;
}
@end

