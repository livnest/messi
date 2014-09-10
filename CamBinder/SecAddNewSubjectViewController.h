//
//  SecAddNewSubjectTableViewController.h
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/08.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecAddNewSubjectViewControllerDelegate;

//@class AddNewSubjectViewController;


@interface SecAddNewSubjectViewController : UITableViewController

@property (weak, nonatomic) id<SecAddNewSubjectViewControllerDelegate> delegate;

//@property (nonatomic, strong) AddNewSubjectViewController *SubjectViewController;

@property (nonatomic, strong) IBOutlet UITextField *nameField;
- (IBAction)cacelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end

@protocol SecAddNewSubjectViewControllerDelegate <NSObject>

- (void)secAddNewSubjectDidCancel:(SecAddNewSubjectViewController *)controller;
- (void)secAddNewSubjectDidDone:(SecAddNewSubjectViewController *)controller item:(NSString *)item;

@end