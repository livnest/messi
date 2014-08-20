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
@property (nonatomic, strong) NSArray *dataSourceiPhone;
@property (nonatomic, strong) NSArray *dataSourceAndroid;
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
    self.dataSourceiPhone = @[@"iPhone 4", @"iPhone 4S", @"iPhone 5", @"iPhone 5c", @"iPhone 5s"];
    self.dataSourceAndroid = @[@"Nexus", @"Galaxy", @"Xperia"];
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
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = self.dataSourceiPhone[indexPath.row];
            break;
        case 1:
            cell.textLabel.text = self.dataSourceAndroid[indexPath.row];
            break;
        default:
            break;
    }
    return cell;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger dataCount;
    
    // テーブルに表示するデータ件数を返す
    switch (section) {
        case 0:
            dataCount = self.dataSourceiPhone.count;
            break;
        case 1:
            dataCount = self.dataSourceAndroid.count;
            break;
        default:
            break;
    }
    return dataCount;
}

@end



