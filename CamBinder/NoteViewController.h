//
//  NoteViewController.h
//  CamBinder
//
//  Created by 松本拓真 on 2014/08/25.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *noteView;
@property (weak, nonatomic) IBOutlet UIToolbar *noteTabBar;
@property (weak, nonatomic) IBOutlet UITextField *addTextMemo;

@property (strong, nonatomic) NSMutableArray *object;

@end
