//
//  AddNewSubjectViewController.h
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/08.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecAddNewSubjectViewController.h"

@interface AddNewSubjectViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *tasks;

- (IBAction)editButtonPressed:(id)sender;

@end
