//
//  ViewController.m
//  CamBinder
//
//  Created by 松本拓真 on 2014/07/19.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *Title;

@property (weak, nonatomic) IBOutlet UIImageView *ImageList;
@property (weak, nonatomic) IBOutlet UITextView *Text;



@property (weak, nonatomic) IBOutlet UIToolbar *Toolbar;
- (IBAction)CallCamera:(id)sender;
- (IBAction)CallPhotoLibrary:(id)sender;
- (IBAction)CallStamp:(id)sender;
- (IBAction)CallCompose:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // 
}

- (IBAction)CallCamera:(id)sender {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:sourceType]){
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentViewController:picker
                           animated:YES
                         completion:NULL
         ];
    }
}

- (IBAction)CallPhotoLibrary:(id)sender {
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    if([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentViewController:picker
                           animated:YES
                         completion:NULL
         ];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 self.ImageList.image=image;
                             }];
}

- (IBAction)CallStamp:(id)sender {
}

- (IBAction)CallCompose:(id)sender {
}
@end
