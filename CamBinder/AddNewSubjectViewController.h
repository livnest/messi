//
//  AddNewSubjectViewController.h
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/08.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewSubject.h"
#import "SecAddNewSubjectViewController.h"

@interface AddNewSubjectViewController : UITableViewController <SecAddNewSubjectViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    int selectedindex;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableSubject;

@property (nonatomic, nonatomic) NSMutableArray *tasks;

@end
