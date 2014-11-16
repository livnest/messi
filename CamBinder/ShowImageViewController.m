//
//  ShowImageViewController.m
//  CamBinder
//
//  Created by 松本拓真 on 2014/11/15.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import "ShowImageViewController.h"

@interface ShowImageViewController (){
    BOOL deAction;
}

@end

@implementation ShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_imageView setImage:_image];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    [_imageView addGestureRecognizer:tap];
    deAction = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tapImage
{
    UINavigationBar *nBar = self.navigationController.navigationBar;
    if (deAction) {
        [UIView animateWithDuration:0.3 animations:^{
            nBar.alpha = 0;
        }completion:^(BOOL finished){
            nBar.hidden = YES;
        }];
        deAction = NO;
    } else {
        nBar.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            nBar.alpha = 1;
        }completion:nil];
        deAction = YES;
    }
}

- (void)closeButtonTapped:(UIBarButtonItem *)sender {
    [self.delegate showImageViewControllerDidClosed:self];
}

@end
