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


@interface SecAddNewSubjectViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) id<SecAddNewSubjectViewControllerDelegate> delegate;

//@property (nonatomic, strong) AddNewSubjectViewController *SubjectViewController;

@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *textSemeseter;
@property (nonatomic, strong) IBOutlet UITextField *textClass;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonDone;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonCancel;

- (IBAction)cacelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end

@protocol SecAddNewSubjectViewControllerDelegate <NSObject>

- (void)secAddNewSubjectDidCancel:(SecAddNewSubjectViewController *)controller;
- (void)secAddNewSubjectDidDone:(SecAddNewSubjectViewController *)controller item:(NSDictionary *)item;

@end