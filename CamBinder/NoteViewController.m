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
    
    self.dataSourceNote = @[@"memo1",@"memo2",@"memo3"];
    // カスタムセルをセット
    UINib *nib = [UINib nibWithNibName:NoteViewMemoCellIdentifier bundle:nil];
    [self.noteView registerNib:nib forCellReuseIdentifier:@"MemoCell"];
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

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceNote.count;
}

// tableに表示するセクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return NoteViewControllerTableSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MemoCell";
    MemoNoteViewCell *memoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    memoCell.textMemo.text = self.dataSourceNote[indexPath.row];
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

@end
