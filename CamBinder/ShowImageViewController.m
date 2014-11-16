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
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.maximumZoomScale = 5.0;
    _scrollView.bouncesZoom = NO;
    self.scrollView.delegate = self;
    [_imageView setImage:_image];
    
    deAction = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    [_imageView addGestureRecognizer:tap];
    /*
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
    [_imageView addGestureRecognizer:pinch];
     */
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

#pragma mark - Delegate methods

- (void)closeButtonTapped:(UIBarButtonItem *)sender {
    [self.delegate showImageViewControllerDidClosed:self];
}

#pragma mark - UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        return _imageView;
    }
    return nil;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
}

#pragma mark - actionImage methods

- (void)tapImage
{
    if (deAction) {
        [UIView animateWithDuration:0.3 animations:^{
            _navBar.alpha = 0;
        }completion:^(BOOL finished){
            _navBar.hidden = YES;
        }];
        deAction = NO;
    } else {
        _navBar.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _navBar.alpha = 1;
        }completion:nil];
        deAction = YES;
    }
}

/*
- (void)pinchImage:(UIPinchGestureRecognizer *)sender
{
    CGAffineTransform currentTransForm;
    if (sender.state == UIGestureRecognizerStateBegan) {
        currentTransForm = _imageView.transform;
    }
    CGFloat scale = [sender scale];
    _imageView.transform = CGAffineTransformConcat(currentTransForm, CGAffineTransformMakeScale(scale, scale));
}
 */

@end
