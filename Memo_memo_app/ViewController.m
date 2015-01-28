//
//  ViewController.m
//  Memo_memo_app
//
//  Created by Takanobu  on 2015/01/21.
//  Copyright (c) 2015年 kolonzu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int count;//test
    int x_origin;//cellの位置xを決定するための3メモ間共通の変数
    int y_origin;//
    int x_2nd;//cellの位置y(決定用
    int y_2nd;//
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timer_custom_viewview{//タイマーcell
//    count=arc4random_uniform(9);
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"timer_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(x_2nd, y_2nd , 100, 100);
    [self seiretu];
    [self setRandomColor:subview];
    [self.view addSubview:subview];
}
- (IBAction)add_memo_custom_view{//メモcell
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"memo_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(x_2nd, y_2nd, 100, 100);
    [self seiretu];
    [self setRandomColor:subview];
    [self.view addSubview:subview];
}
- (IBAction)photo_custom_view{//フォトcell
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"photo_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(x_2nd, y_2nd, 100, 100);
    [self seiretu];
    [self setRandomColor:subview];
    [self.view addSubview:subview];
}
- (void)setRandomColor:(UIView *)subview {//色
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    subview.backgroundColor = color;
}

-(void)seiretu{//cellを並ばせます。ある意味一番大切？な所です
    x_origin++;
    if(x_origin%3==0){//横列に全部入った場合
        y_origin++;//y座標を下げる
        if(x_origin==3 && y_origin==5)//ジェスチャゾーンに入りそうな場合（将来的には画面スクロールできるようにするから消す
        {
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"増やしすぎ!!"
                                      delegate:self cancelButtonTitle:@"わかった。" otherButtonTitles:nil];
            [alert show];
        }
        x_origin=0;//メモが入りきれないのでx座標を戻す
        x_2nd=137.5*x_origin;
        y_2nd= 120*y_origin;
    }
    else{//通常時
        x_2nd=137.5*x_origin;
        
    }
    
}
@end
