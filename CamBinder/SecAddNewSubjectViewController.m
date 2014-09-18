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

@interface SecAddNewSubjectViewController ()

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
    
    _nameField.delegate = self;
    _textClass.delegate = self;
    _textSemeseter.delegate = self;
    
    if (_nameField.text.length ==0) {
        _buttonDone.enabled = NO;
    }
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
    
    NSDictionary *dictSubject = @{@"name": _nameField.text, @"semester": _textSemeseter.text, @"class": _textClass.text};
    
    [self.delegate secAddNewSubjectDidDone:self item:dictSubject];
}

#pragma mark - UITextField Delegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField  // called when 'return' key pressed. return NO to ignore.
{
    if (textField == _nameField) {
        [textField resignFirstResponder];
    } else if (textField == _textSemeseter) {
        [textField resignFirstResponder];
    } else if (textField == _textClass) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_nameField.text.length != 0) {
        _buttonDone.enabled = YES;
    }
}

@end
