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

@interface NoteViewController () {
    NSMutableArray *_objectText;
    NSMutableArray *_objectImage;
    NSMutableArray *_object;
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
    
//    self.dataSourceNote = @[@"memo1",@"memo2",@"memo3"];
    
    // カスタムセルをセット
    UINib *nibMemo = [UINib nibWithNibName:NoteViewMemoCellIdentifier bundle:nil];
    UINib *nibImage = [UINib nibWithNibName:NoteViewImageCellIdentifier bundle:nil];
    [self.noteView registerNib:nibMemo forCellReuseIdentifier:@"MemoCell"];
    [self.noteView registerNib:nibImage forCellReuseIdentifier:@"ImageCell"];
}

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

- (void)addObjectMemo
{
    // 配列が作られていない場合、新規作成
    if (!_object) {
        _object = [[NSMutableArray alloc] init];
    }
    if (!_objectText) {
        _objectText = [[NSMutableArray alloc] init];
    }
    
    NSInteger row = [_objectText count];
    NSLog(@"配列の追加:%ld個目", row + 1);
    [_objectText addObject:[[NSString alloc] initWithFormat:@"New memo :%ld", row + 1]];
    NSString *text = _objectText[row];
    NSDate *memoDate = [NSDate date];
    NSDictionary *memoDictionary = @{@"text": text, @"date": memoDate};
    // Memoセルの配列を追加
    NSInteger rowData = [_object count];
    [_object insertObject:memoDictionary atIndex:rowData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowData inSection:0];
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
    static NSString *CellIdentifier = @"MemoCell";
    MemoNoteViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Memoセルの配列をセット
    NSDictionary *dictMemo = _object[indexPath.row];
    // MemoをtextFieldにセット
    cell.textMemo.text = dictMemo[@"text"];
    // Memoの追加日時をLabelにセット
    NSDate *dateMemo = dictMemo[@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm dd/MM/yyyy";
    cell.labelMemoDate.text = [dateFormatter stringFromDate:dateMemo];
    
    /*
    UITableViewCell *memoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!memoCell) {
        memoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
     memoCell.textLabel.text = self.dataSourceNote[indexPath.row];
     */
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MemoNoteViewCell rowHeight];
}

- (IBAction)addMemo:(id)sender
{
    [self addObjectMemo];
}

@end
