//
//  MemoCustomView.m
//  Memo_memo_app
//
//  Created by ikuya omatsu on 2015/03/06.
//  Copyright (c) 2015年 kolonzu. All rights reserved.
//

#import "MemoCustomView.h"

@implementation MemoCustomView {
    NSMutableString *myText;
}

- (void)setTextViewContents {
    NSLog(@"つくるよ");
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:myText forKey:@"textView"];
    [ud synchronize];
}
- (void)getTextViewContents {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *textStr = [ud stringForKey:@"textView"];
    self.textView.text = textStr;
}
#pragma - mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    int maxInputLength = 3;
    myText = [self.textView.text mutableCopy];
    [myText replaceCharactersInRange:range withString:text];
    
    if ([myText length] > maxInputLength) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"文字数制限"
                              message:@"3文字以下で入力して下さい"
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil
                              ];
        [alert show];
        
        return NO;
    }
    [self setTextViewContents];

    
    return YES;
}

@end
