//
//  AddNewSubjectViewController.h
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/08.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewSubjectViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tasks;

- (IBAction)editButtonPressed:(id)sender;

@end
