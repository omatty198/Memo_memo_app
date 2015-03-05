//
//  ViewController.m
//  Memo_memo_app
//
//  Created by Takanobu  on 2015/01/21.
//  Copyright (c) 2015年 kolonzu. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCustomView.h"
#import "timer_custom_view.h"

@interface ViewController ()
{
    
    int count;//test
    int x_origin;//cellの位置xを決定するための3メモ間共通の変数
    int y_origin;//
    int x_2nd;//cellの位置y(決定用
    int y_2nd;
    int size_x;
    int size_y;
    int general_size_y;//cellの配置されるスペースの広さ
    int viewCount;
    NSMutableArray *cell_array;//セルの個数
    PhotoCustomView *photoSubView;
    NSTimer *timer_cell;
}
@end

@implementation ViewController

#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"data.dat"];
    NSArray *array2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (array2) {
        cell_array = [array2 mutableCopy];
    } else {
        cell_array = [NSMutableArray array];
    }
    if (array2) {
        NSLog(@"配列の個数:%ld",array2.count);
        for (NSObject *object in array2) {
            if ([object isKindOfClass:[timer_custom_view class]]) {
                NSLog(@"timerCutstomView objectです");
                timer_custom_view *timerCopy = (timer_custom_view *)object;
                NSLog(@"%@, %@", timerCopy, NSStringFromCGSize(timerCopy.frame.size));
                //TODO: buttonが機能をなしていない
                //imgCopy = [timer_custom_view view];
                //[imgCopy.timer_button addTarget:self action:@selector(hoge:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:timerCopy];
                NSString *str = [NSString stringWithFormat:@"Size:%@",NSStringFromCGSize(timerCopy.frame.size)];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"AlertView"
                                                                    message:str
                                                                   delegate:self
                                                          cancelButtonTitle:@"いいえ"
                                                          otherButtonTitles:nil, nil];
                [alertView show];
            } else if ([object isKindOfClass:[PhotoCustomView class]]) {
                NSLog(@"PhotoCustomView objectです");
                PhotoCustomView *imgCopy = (PhotoCustomView *)object;
                NSLog(@"%@, %@", imgCopy, NSStringFromCGSize(imgCopy.frame.size));
                //TODO: 中身を復旧させる
                [self.view addSubview:imgCopy];
            } else if ([object isKindOfClass:[NSString class]]) {//NSStringではなく、memo_custom_view
                
            } else {
                NSLog(@"不明なobjectです");
            }
        }
    } else {
        NSLog(@"%@", @"データが存在しません。");
    }

}
//http://d.hatena.ne.jp/glass-_-onion/20110904/1315145330
- (void)archiveSubview {
    NSLog(@"保存する個数:%ld",cell_array.count);
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"data.dat"];
    BOOL successful = [NSKeyedArchiver archiveRootObject:cell_array toFile:filePath];
    if (successful) {
        NSLog(@"データの保存に成功しました");
    } else {
        NSLog(@"データの保存に失敗しました");
    }
}


# pragma - mark それぞれのButton
- (IBAction)timer_custom_viewview{//タイマーcell
    //    count=arc4random_uniform(9);
    int arrayNum = (int)cell_array.count;
    int colomn = arrayNum % 3;
    int row = arrayNum / 3;
    timer_custom_view *subview = [[NSBundle mainBundle] loadNibNamed:@"timer_custom_view" owner:self options:nil][0];
    subview.second = 5;
    subview.frame = CGRectMake(120 * colomn + 17, 120 * row + 10, 100, 100);
    //-------------------------
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;//ダブルタップ
    [subview addGestureRecognizer:tap];
    //-------------------------
    [cell_array addObject:subview];
    [self archiveSubview];
    //    [self seiretu];
    [self setRandomColor:subview];
    [self find_add_size];
    [self.view addSubview:subview];
}
- (IBAction)add_memo_custom_view{//メモcell
    int arrayNum = (int)cell_array.count;
    int colomn = arrayNum % 3;
    int row = arrayNum / 3;
    
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"memo_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(120 * colomn + 17, 120 * row + 10, 100, 100);
    //-------------------------
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;
    [subview addGestureRecognizer:tap];
    //-------------------------
    [cell_array addObject:subview];
    [self archiveSubview];
    //    [self seiretu];
    [self setRandomColor:subview];
    [self find_add_size];
    [self.view addSubview:subview];
    
    
}
- (IBAction)photo_custom_view{//フォトcell
    int arrayNum = (int)cell_array.count;
    int colomn = arrayNum % 3;
    int row = arrayNum / 3;
    
    photoSubView = [[NSBundle mainBundle] loadNibNamed:@"photo_custom_view" owner:self options:nil][0];
    photoSubView.frame = CGRectMake(120 * colomn + 17, 120 * row + 10, 100, 100);
    //-------------------------
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;
    [photoSubView addGestureRecognizer:tap];
    [self getting_photo];
    [cell_array addObject:photoSubView];
    [self archiveSubview];
    [self setRandomColor:photoSubView];
    [self find_add_size];
    [self.view addSubview:photoSubView];
}
# pragma - mark UIImagePickerDelegate
//写真を選択し終わった時に呼び出されるdelegateメソッド
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //生成するphoto_custom_viewのUIImageViewに選んだ写真をセットしているよ！
    [photoSubView.photoImageView setImage:info[UIImagePickerControllerOriginalImage]];
}
# pragma - mark それぞれのButtonで扱う処理
- (void)reuseView:(int)arrayCount subView:(UIView *)subView {
    //iを3で割った,余りが行列となる
    int colomn =  arrayCount % 3;//横
    int row = arrayCount / 3;//縦
    [UIView animateWithDuration:0.1f animations:^{
        subView.frame = CGRectMake(120*colomn+17, 120*row+10, 100, 100);
    }];
}
- (void)tapAction:(id)sender {
    NSLog(@"age:%@",cell_array);
    NSLog(@"LOG:%ld",cell_array.count);
    UITapGestureRecognizer *tap = sender;
    [tap.view removeFromSuperview];
    // tap.viewとarrayの中身のインスタンスが一緒だったら削除する
    //TODO: 配列のインデックスを探して、つめる
    NSUInteger index = [cell_array indexOfObject:tap.view];
    if (index != NSNotFound) { // yes
        NSLog(@"%lu番目にありました．", index);
        //全部消して
        [cell_array removeObject:tap.view];
        //再度add
        for (int i = 0; i < cell_array.count; i++) {
            UIView *subView = cell_array[i];
            [self reuseView:i subView:subView];
            [self.view addSubview:subView];
        }
    }
}
-(void)getting_photo{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    // UIImagePickerControllerSourceTypeSavedPhotosAlbum だと直接写真選択画面
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 選択したメディアの編集を可能にするかどうか
    imagePickerVC.allowsEditing = YES;
    
    // 選択可能なメディアの制限 デフォルトは photo のみ。
    // movie を選択可能にするには
    // imagePickerVC.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePickerVC.sourceType];
    imagePickerVC.delegate = self;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

- (void)setRandomColor:(UIView *)subview {//色
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    CGFloat alpha = ( arc4random() % 200 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    subview.backgroundColor = color;
    subview.alpha=1;
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
- (void)hogehoge:(timer_custom_view *)timerView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 19, 96, 35)];
    label.text = @"5";
    timerView.time_label = label;
    [timerView addSubview:label];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(34, 62, 33, 30)];
    [button setTitle:@"START" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hoge:) forControlEvents:UIControlEventTouchUpInside];
    timerView.timer_button = button;
    [timerView addSubview:button];
}
//-(void)second_up{
//    timer_custom_view sec
//}
//- (IBAction)timerButton:(id)senderButton {
//    
//}
@end
