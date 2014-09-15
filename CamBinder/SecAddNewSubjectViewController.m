//
//  SecAddNewSubjectTableViewController.m
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/08.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import "SecAddNewSubjectViewController.h"
#import "AddNewSubjectViewController.h"
#import "AddNewSubject.h"

@interface SecAddNewSubjectViewController ()<UITextFieldDelegate>

@end

@implementation SecAddNewSubjectViewController

//@synthesize nameField = _nameField;
//@synthesize  SubjectViewController = _SubjectViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions


- (void)cacelButtonPressed:(id)sender
{
    /*
    [self dismissModalViewControllerAnimated:YES];
     */
    
    [self.delegate secAddNewSubjectDidCancel:self];
}

- (void)doneButtonPressed:(id)sender
{
    /*
     AddNewSubject *newSubject = [[AddNewSubject alloc] initWithName:self.nameField.text done:NO];
    [self.SubjectViewController.tasks addObject:newSubject];
    
    [self dismissModalViewControllerAnimated:YES];
    
     
    [self.SubjectViewController.tableView reloadData];
     */
    
    [self.delegate secAddNewSubjectDidDone:self item:self.nameField.text];
}

#pragma mark - UITextField Delegate method
- (BOOL)textFieldShouldReturn:(UITextField *)textField  // called when 'return' key pressed. return NO to ignore.
{
    if (textField == _nameField) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
