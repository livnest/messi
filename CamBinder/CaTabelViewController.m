//
//  CaTabelViewController.m
//  CamBinder
//
//  Created by Okasita Masahiro on 2014/08/20.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import "CaTabelViewController.h"

@interface CaTabelViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSourceSubject;

@end

@implementation CaTabelViewController

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
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // テーブルに表示したいデータソースをセット
    self.dataSourceSubject = @[@"授業1"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.dataSourceSubject[indexPath.row];
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger dataCount;
    
//    // テーブルに表示するデータ件数を返す
//    switch (section) {
//        case 0:
//            dataCount = self.dataSourceSubject.count;
//            break;
//                default:
//            break;
//    }
    dataCount = self.dataSourceSubject.count;
    return dataCount;
}

//- (IBAction)MakeSubjectButton:(id)sender {
//    // UITableViewの初期化
//    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"新規授業名"
//                                                    message:@"授業名を入力してください。"
//                                                   delegate:self
//                                          cancelButtonTitle:@"キャンセル"
//                                          otherButtonTitles:@"保存", nil
//                          ];
//    [Alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    [Alert show];
//}
//
//// AlertViewが終了した後
//-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    NSMutableArray *dataSourceSubject = [NSMutableArray array];
//    if (buttonIndex==1) {
//        NSLog(@"%@",[[alertView textFieldAtIndex:0] text]);
//        [dataSourceSubject addObject:[[alertView textFieldAtIndex:0] text]];
//    }
//}
//
//// AlertViewのボタンを使えるようにする
//- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
//    return YES;
//}

@end



