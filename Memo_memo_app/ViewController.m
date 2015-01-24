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
    int count;
    int x;
    int y;
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

- (IBAction)timer_custom_viewview{
    count=arc4random_uniform(9);
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"timer_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(100, count * 100, 100, 100);

    [self setRandomColor:subview];
    [self.view addSubview:subview];
}
- (IBAction)add_memo_custom_view{
    count=arc4random_uniform(9);
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"memo_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(count *100, 100, 100, 100);

    [self setRandomColor:subview];
    [self.view addSubview:subview];
}
- (IBAction)photo_custom_view{
    count=arc4random_uniform(9);
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"photo_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(100, count *100, 100, 100);
    
    [self setRandomColor:subview];
    [self.view addSubview:subview];
}
- (void)setRandomColor:(UIView *)subview {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    subview.backgroundColor = color;
}

-(void)seiretu{
    x++;
    if(x==3){
        x=1;
    }
    

}
@end
