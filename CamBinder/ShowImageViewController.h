//
//  ShowImageViewController.h
//  CamBinder
//
//  Created by 松本拓真 on 2014/11/15.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowimageViewControllerDelegate;

@interface ShowImageViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) id<ShowimageViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *topToolBar;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolBar;

- (IBAction)closeButtonTapped:(UIBarButtonItem *)sender;

@property (nonatomic, strong) UIImage *image;

@end

@protocol ShowimageViewControllerDelegate <NSObject>

- (void)showImageViewControllerDidClosed:(ShowImageViewController *)controller;

@end