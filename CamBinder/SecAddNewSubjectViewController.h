//
//  SecAddNewSubjectTableViewController.h
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/08.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddNewSubjectViewController;

@interface SecAddNewSubjectViewController : UITableViewController

- (IBAction)cacelButtonPressed:(id)sender;

- (IBAction)doneButtonPressed:(id)sender;

@property (nonatomic, strong) IBOutlet UITextField *nameField;

@property (nonatomic, strong) AddNewSubjectViewController *SubjectViewController;

@end
