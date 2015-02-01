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
    int size_x;
    int size_y;
    int general_size_y;//cellの配置されるスペースの広さ
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
    [self    find_add_size];
    [self.view addSubview:subview];
}
- (IBAction)add_memo_custom_view{//メモcell
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"memo_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(x_2nd+10, y_2nd, 100, 100);//とりあえず+10して左詰めっぽくなるのは回避したけどせっかく画面サイズの取得までしたんで中央揃えするみたいな感じにしたいです。※size_x使えばうまくいけそうな感じがしました。
    [self seiretu];
    [self setRandomColor:subview];
    [self    find_add_size];
    [self.view addSubview:subview];
}
- (IBAction)photo_custom_view{//フォトcell
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"photo_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(x_2nd, y_2nd, 100, 100);
    [self seiretu];
    [self setRandomColor:subview];
    [self    find_add_size];
    [self.view addSubview:subview];
}
- (void)setRandomColor:(UIView *)subview {//色
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    subview.backgroundColor = color;
}
-(void)find_add_size{//画面サイズの取得
    size_x=[UIScreen mainScreen].bounds.size.width;
    size_y=[UIScreen mainScreen].bounds.size.height;
    if([UIScreen mainScreen].bounds.size.height == 568.0)
    {
        self->scroll_view.contentSize = CGSizeMake(320, 568 /* +subview.frame.size.height*/);//コメントアウトしたところの意味を教えてください。あと、self.scroll_viewでアラートが出たんでself->scroll_viewに変えました。それからsubviewがないよーって言われたんでscroll_viewをいれました。
    }else if ([UIScreen mainScreen].bounds.size.height == 667.0) {//iphone6のとき
        self->scroll_view.contentSize = CGSizeMake(375, 667 /* +subview.frame.size.height*/);
    }else if ([UIScreen mainScreen].bounds.size.height == 736.0) {//iphone6+のとき
        self->scroll_view.contentSize = CGSizeMake(414,736 /* +subview.frame.size.height*/);
        NSLog(@"%d",size_x);
    }
    
}
-(void)seiretu{//cellを並ばせます。ある意味一番大切？な所です
    [self find_add_size];
    x_origin++;
    if(x_origin%3==0){//横列に全部入った場合
        x_origin=0;
        
        y_origin++;//y座標を下げる
        y_2nd=y_origin*120;
        if(y_origin==5)//ジェスチャゾーンに入りそうな場合（将来的には画面スクロールできるようにするから消す
        {
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"増やしすぎ!!"
                                      delegate:self cancelButtonTitle:@"わかった。" otherButtonTitles:nil];
            [alert show];
        }
        //        x_origin=0;//メモが入りきれないのでx座標を戻す
        //        x_2nd=137.5*x_origin;
        //        y_2nd= 120*y_origin;
    }
    else{//通常時
        
    }
    x_2nd=(size_x/3)*x_origin;
    NSLog(@"%dx",x_2nd);
    NSLog(@"%dy",y_2nd);
}





@end
