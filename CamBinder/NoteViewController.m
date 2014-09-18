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

@interface NoteViewController ()

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
    [self textFieldDesign:_addTextMemo];
    
    if (_addTextMemo.text.length == 0) {
        _addMemo.enabled = NO;
    }
    
    /* スクロールビューを利用したTableViewの上昇
    // TableViewの位置をキーボードの上部に移動するための準備
    [self.scrollView setDelegate:self];
    [self.scrollView setScrollEnabled:NO];
    [self.scrollView setDelaysContentTouches:NO];
     */
}

- (void)textFieldDesign:(UITextField *)textField
{
    // 編集時にクリアボタンを表示
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView AddNoteObject Method

- (IBAction)addMemo:(id)sender
{
    [_addTextMemo resignFirstResponder];
    [self addObjectMemo:_addTextMemo.text];
}

- (void)addObjectMemo:(NSString *)textField
{
    // 配列が作られていない場合、配列を初期化
    if (!_object) {
        _object = [[NSMutableArray alloc] init];
    }
    // テキストの配列を追加
    NSLog(@"%ld:「%@」", _object.count + 1, textField);
    NSDate *dateMemo = [NSDate date];
    NSDictionary *memoDictionary = @{@"text": textField, @"date": dateMemo};
    
    // テキストと日時をMemoセルの配列に追加
    NSInteger rowObj = [_object count];
    [_object insertObject:memoDictionary atIndex:rowObj];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowObj inSection:0];
    // noteViewにMemoセルを挿入するメソッドを実行
    [self addMemoCellForRowAtIndexPath:indexPath];
}

- (void)addMemoCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // noteViewにMemoセルを挿入
    [self.noteView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
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
    // セルの初期化
    /*
     *オブジェクトがMemoかImageの分岐の実装が必要
     */
    static NSString *CellIdentifier = @"MemoCell";
    MemoNoteViewCell *memoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Memoセルの配列をセット
    NSDictionary *dictMemo = _object[indexPath.row];
    // MemoをtextFieldにセット
    memoCell.textMemo.text = dictMemo[@"text"];
    // Memoの追加日時をLabelにセット
    NSDate *dateMemo = dictMemo[@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm dd/MM/yyyy";
    memoCell.labelMemoDate.text = [dateFormatter stringFromDate:dateMemo];
    
    /*
    UITableViewCell *memoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!memoCell) {
        memoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
     memoCell.textLabel.text = self.dataSourceNote[indexPath.row];
     */
    
    return memoCell;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MemoNoteViewCell rowHeight];
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
    CGFloat moveTo = _noteTabBar.frame.origin.y - keyboardSize.height;
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
                     completion:NULL];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    if (textField == _addTextMemo) {
        if (string.length == 0) {
            if (textField.text.length == 1) {
                _addMemo.enabled = NO;
            }
        } else if (string.length != 0) {
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
