//
//  NoteViewController.m
//  CamBinder
//
//  Created by 松本拓真 on 2014/08/25.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import "NoteViewController.h"
#import "MemoNoteViewCell.h"
#import "ImageNoteViewCell.h"
#import "NoteViewConst.h"

static NSInteger const NoteViewControllerTableSection = 1;
//#define WINDOW_SIZE [[UIScreen mainScreen] applicationFrame].size

@interface NoteViewController () {
    CGRect *_rect;
}

@end

@implementation NoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.noteView.delegate = self;
    self.noteView.dataSource = self;
    self.addTextMemo.delegate = self;
    
    // カスタムセルをセット
    // MemoCell
    UINib *nibMemo = [UINib nibWithNibName:NoteViewMemoCellIdentifier bundle:nil];
    [self.noteView registerNib:nibMemo forCellReuseIdentifier:@"MemoCell"];
    // ImageCell
    UINib *nibImage = [UINib nibWithNibName:NoteViewImageCellIdentifier bundle:nil];
    [self.noteView registerNib:nibImage forCellReuseIdentifier:@"ImageCell"];
    
    // テキストフィールドのデザイン
    // [self textFieldDesign:_addTextMemo];
    
    if (_addTextMemo.text.length == 0) {
        _addMemo.enabled = NO;
    }
    
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    
    self.editButtonItem.title = @"編集";
    
    self.editButtonItem.enabled = NO;
    
    /* スクロールビューを利用したTableViewの上昇
    // TableViewの位置をキーボードの上部に移動するための準備
    [self.scrollView setDelegate:self];
    [self.scrollView setScrollEnabled:NO];
    [self.scrollView setDelaysContentTouches:NO];
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    // キーボードの通知
    [self registorForKeyboardNotification];
}

- (void)registorForKeyboardNotification
{
    // キーボード表示の通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardOn:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    // キーボード非表示の通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardOff:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    // キーボード通知の削除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // スクロール範囲を設定
    [self.scrollView setContentSize:CGSizeMake(WINDOW_SIZE.width, WINDOW_SIZE.height)];
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)setNavigationTitle:(NSDictionary *)dict
{
    self.navigationItem.title = dict[@"name"];
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView AddNoteObject Method

/* 
 * Memoの挿入
 */

- (IBAction)addMemo:(id)sender
{
    [_addTextMemo resignFirstResponder];
    [self addObjectMemo:_addTextMemo.text];
}

- (void)addObjectMemo:(NSString *)text
{
    // 配列が作られていない場合、配列を初期化
    if (!_object) {
        _object = [[NSMutableArray alloc] init];
    }
    // テキストの配列を追加
    NSLog(@"%ld:「%@」", _object.count + 1, text);
    NSDate *dateMemo = [NSDate date];
    NSDictionary *memoDictionary = @{@"text": text, @"date": dateMemo};
    // *textFieldを空にする
    
    // テキストと日時をMemoセルの配列に追加
    NSInteger rowObj = [_object count];
    [_object insertObject:memoDictionary atIndex:rowObj];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowObj inSection:0];
    // noteViewにMemoセルを挿入するメソッドを実行
    [self addNoteViewCellForRowAtIndexPath:indexPath];
    
    self.editButtonItem.enabled = YES;
}

/*
 * 画像の挿入
 */

- (IBAction)tapAddImage:(UIBarButtonItem *)sender
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:sourceType]){
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:Nil];
    }
}

- (IBAction)tapAddLibarary:(UIBarButtonItem *)sender
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:Nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    void (^completion)(void);
    completion = ^(void){
        if (!_object) {
            _object = [[NSMutableArray alloc] init];
        }
        NSLog(@"%ld:「image」", _object.count + 1);
        NSDate *dateMemo = [NSDate date];
        NSDictionary *imageDictionary = @{@"image": image, @"date": dateMemo};
        NSInteger rowObj = [_object count];
        [_object insertObject:imageDictionary atIndex:rowObj];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowObj inSection:0];
        [self addNoteViewCellForRowAtIndexPath:indexPath];
    };
    [self dismissViewControllerAnimated:YES
                             completion:completion
     ];
    
    self.editButtonItem.enabled = YES;
}

- (void)addNoteViewCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // noteViewにセルを挿入
    [self.noteView insertRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:(!_object[indexPath.row][@"image"]) ? UITableViewRowAnimationRight : UITableViewRowAnimationLeft];
    [self.noteView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
    
#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _object.count;
}

// tableに表示するセクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NoteViewControllerTableSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_object[indexPath.row][@"image"]) { // Memoセル
        static NSString *CellIdentifier = @"MemoCell";
        MemoNoteViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Memoセルの配列をセット
        NSDictionary *dictMemo = _object[indexPath.row];
        // MemoをtextFieldにセット
        cell.textMemo.text = dictMemo[@"text"];
        // Memoの追加日時をLabelにセット
        NSDate *date = dictMemo[@"date"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm dd/MM/yyyy";
        cell.labelMemoDate.text = [dateFormatter stringFromDate:date];
        return cell;
    } else {                                // Imageセル
        static NSString *CellIdentifier = @"ImageCell";
        ImageNoteViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        // Image
        NSDictionary *dictImage = _object[indexPath.row];
        UIImage *image = dictImage[@"image"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.clipsToBounds = YES;
        cell.imageView.image = image;
        // Date
        NSDate *date = dictImage[@"date"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm dd/MM/yyyy";
        cell.labelImageDate.text = [dateFormatter stringFromDate:date];
        return cell;
    }
}

- (CGFloat)heightFromAspectOfImage:(UIImage *)image cell:(UITableViewCell *)cell
{
    NSInteger aspect = image.size.height / image.size.width;
    CGFloat height = cell.imageView.frame.size.width * aspect;
    return height;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.noteView setEditing:editing animated:animated];
    
     [super setEditing:editing animated:YES];
    
    if (editing) { // 現在通常モードです。
        self.noteTabBar.hidden = YES;
    } else { // 現在編集モードです。
        self.noteTabBar.hidden = NO;
    }
    
    //編集のボタン名変更
    if(editing){
        self.editButtonItem.title = @"完了";
    }else{
        self.editButtonItem.title = @"編集";
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_object removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        if (self.object.count == 0) {
            self.editButtonItem.enabled = NO;
            self.editButtonItem.title = @"編集";
            [tableView setEditing:NO animated:YES];
        }
}
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_object[indexPath.row][@"image"]) {
        return [MemoNoteViewCell rowHeight];
    } else {
        return [ImageNoteViewCell rowHeight];
    }
}

#pragma mark - UITextFieldDelegate methods

- (void)keyboardOn:(NSNotification *)notification
{
    /* ScrollViewを使用した移動
     CGPoint scrollPoint = CGPointMake(0.0f, keyboardSize.height);
     [self.scrollView setContentOffset:scrollPoint animated:YES];
     */
    
    // 各アウトレットのサイズ
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    // 移動先の値
    CGFloat moveTo = self.view.frame.size.height - keyboardSize.height - _noteTabBar.frame.size.height;
    CGFloat resizeTo = self.view.frame.size.height - keyboardSize.height;
    
    //　アニメーションの呼び出し
    [self animationWithKeyboard:notification
                         moveTo:moveTo
                       resizeTo:resizeTo
     ];
}

- (void)keyboardOff:(NSNotification *)notification
{
    // 移動先の値
    CGFloat moveTo = self.view.frame.size.height - _noteTabBar.frame.size.height;
    CGFloat resizeTo = self.view.frame.size.height;
    
    //　アニメーションの呼び出し
    [self animationWithKeyboard:notification
                         moveTo:moveTo
                       resizeTo:resizeTo
     ];
}

- (void)animationWithKeyboard:(NSNotification *)notification moveTo:(CGFloat)moveTo resizeTo:(CGFloat)resizeTo
{
//    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    NSDictionary *info = [notification userInfo];
    // アニメーションの時間
    NSTimeInterval duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // アニメーションのタイプ
    UIViewAnimationCurve curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    // アニメーション本体
    CGSize viewSize = _noteView.frame.size;
    CGSize tabSize = _noteTabBar.frame.size;
    __weak typeof (self) _self = self;
    void (^animation)(void);
    animation = ^(void){
        CGRect TabRect = CGRectMake(0, moveTo, tabSize.width, tabSize.height);
        _self.noteTabBar.frame = TabRect;
        CGRect ViewRect = CGRectMake(0, 0, viewSize.width, resizeTo);
        _self.noteView.frame = ViewRect;
    };
    // アニメーションの実行
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:(curve << 16)
                     animations:animation
                     completion:NULL
     ];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    if (textField == _addTextMemo) {
        // デリート時
        if (string.length == 0) {
            if (textField.text.length == 1) {
                _addMemo.enabled = NO;
            }
        // 入力時
        } else {
            _addMemo.enabled = YES;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField insertText:@"\n"];
    return YES;
}

@end
