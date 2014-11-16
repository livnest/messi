//
//  NoteViewController.h
//  CamBinder
//
//  Created by 松本拓真 on 2014/08/25.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowImageViewController.h"

@interface NoteViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ShowimageViewControllerDelegate>

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *noteView;
@property (weak, nonatomic) IBOutlet UIToolbar *noteToolBar;
@property (weak, nonatomic) IBOutlet UITextField *addTextMemo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addMemo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addImage;
- (IBAction)tapAddImage:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addLibrary;
- (IBAction)tapAddLibarary:(UIBarButtonItem *)sender;

@property (strong, nonatomic) NSMutableArray *object;
@property (strong, nonatomic) UIImage *selectedImage;

@end
