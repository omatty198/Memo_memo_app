//
//  ViewController.m
//  Memo_memo_app
//
//  Created by Takanobu  on 2015/01/21.
//  Copyright (c) 2015年 kolonzu. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCustomView.h"

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
    NSMutableArray *array;//セルの個数
    PhotoCustomView *photoSubView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    second=0;
    minute=0;
    hour=0;
    [super viewDidLoad];
    // 可変配列の追加
    array = [NSMutableArray array];
    //    [self haikei];
}
- (void)reuseView:(int)arrayCount subView:(UIView *)subView {
    //iを3で割った,余りが行列となる
    int colomn =  arrayCount % 3;//横
    int row = arrayCount / 3;//縦
    [UIView animateWithDuration:0.1f animations:^{
        subView.frame = CGRectMake(120*colomn+17, 120*row+10, 100, 100);
    }];
}
//-(void)haikei{
//
//    int k =1;
//    NSString *img_name=[NSString stringWithFormat:@"cool%d",k];
//    [haikei_view setImage:[UIImage imageNamed:img_name]];// imageNamed*ファイルの名前
//
//}
- (void)tapAction:(id)sender {
    NSLog(@"age:%@",array);
    NSLog(@"LOG:%ld",array.count);
    UITapGestureRecognizer *tap = sender;
    [tap.view removeFromSuperview];
    // tap.viewとarrayの中身のインスタンスが一緒だったら削除する
    //TODO: 配列のインデックスを探して、つめる
    NSUInteger index = [array indexOfObject:tap.view];
    if (index != NSNotFound) { // yes
        NSLog(@"%lu番目にありました．", index);
        //全部消して
        [array removeObject:tap.view];
        //再度add
        for (int i = 0; i < array.count; i++) {
            UIView *subView = array[i];
            [self reuseView:i subView:subView];
            [self.view addSubview:subView];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)timer_custom_viewview{//タイマーcell
    //    count=arc4random_uniform(9);
    int arrayNum = (int)array.count;
    int colomn = arrayNum % 3;
    int row = arrayNum / 3;
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"timer_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(120 * colomn + 17, 120 * row + 10, 100, 100);
    //-------------------------
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;//ダブルタップ
    [subview addGestureRecognizer:tap];
    //-------------------------
    [array addObject:subview];
    //    [self seiretu];
    [self setRandomColor:subview];
    [self find_add_size];
    [self.view addSubview:subview];
}
- (IBAction)add_memo_custom_view{//メモcell
    int arrayNum = (int)array.count;
    int colomn = arrayNum % 3;
    int row = arrayNum / 3;
    
    UIView *subview = [[NSBundle mainBundle] loadNibNamed:@"memo_custom_view" owner:self options:nil][0];
    subview.frame = CGRectMake(120 * colomn + 17, 120 * row + 10, 100, 100);
    //-------------------------
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;
    [subview addGestureRecognizer:tap];
    //-------------------------
    [array addObject:subview];
    //    [self seiretu];
    [self setRandomColor:subview];
    [self find_add_size];
    [self.view addSubview:subview];
    
    
}
//写真を選択し終わった時に呼び出されるdelegateメソッド
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //生成するphoto_custom_viewのUIImageViewに選んだ写真をセットしているよ！
    [photoSubView.photoImageView setImage:info[UIImagePickerControllerOriginalImage]];
}
- (IBAction)photo_custom_view{//フォトcell
    int arrayNum = (int)array.count;
    int colomn = arrayNum % 3;
    int row = arrayNum / 3;
    
    photoSubView = [[NSBundle mainBundle] loadNibNamed:@"photo_custom_view" owner:self options:nil][0];
    photoSubView.frame = CGRectMake(120 * colomn + 17, 120 * row + 10, 100, 100);
    //-------------------------
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;
    [photoSubView addGestureRecognizer:tap];
    //-------------------------
    [self getting_photo];
    [array addObject:photoSubView];
    [self setRandomColor:photoSubView];
    [self find_add_size];
    //TODO: https://github.com/mixi-inc/iOSTraining/wiki/5.1-UIImagePickerController
    //上記URLを見ながら、UIImagePickerControllerを使ってみよう！
    //
    //
    //-------------------------
    [self.view addSubview:photoSubView];
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
//-(void)seiretu{//cellを並ばせます。ある意味一番大切？な所です
//    [self find_add_size];
//    x_origin++;
//    if(x_origin%3==0){//横列に全部入った場合
//        x_origin=0;
//
//        y_origin++;//y座標を下げる
//        y_2nd=y_origin*120;
//        if(y_origin==5)//ジェスチャゾーンに入りそうな場合（将来的には画面スクロールできるようにするから消す
//        {
//            UIAlertView *alert =
//            [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"増やしすぎ!!"
//                                      delegate:self cancelButtonTitle:@"わかった。" otherButtonTitles:nil];
//            [alert show];
//        }
//        x_origin=0;//メモが入りきれないのでx座標を戻す
//        x_2nd=137.5*x_origin;
//        y_2nd= 120*y_origin;
//    }
//    else{//通常時
//
//    }
//zahyo=[NSString stringWithFormat:@"X%dY%d",x_origin,y_origin];
//NSLog(@"%@",zahyo);
//    x_2nd=(size_x/3)*x_origin;
//    [self tests];
//}
//
//-(void)tests{
//    NSLog(@"X%dY%d",x_2nd,y_2nd);
//
//}


@end
