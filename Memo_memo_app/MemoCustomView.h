//
//  MemoCustomView.h
//  Memo_memo_app
//
//  Created by ikuya omatsu on 2015/03/06.
//  Copyright (c) 2015年 kolonzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoCustomView : UIView<UITextViewDelegate>
@property (nonatomic,weak) IBOutlet UITextView *textView;
-(void)setTextViewContents;
-(void)getTextViewContents;
@end
