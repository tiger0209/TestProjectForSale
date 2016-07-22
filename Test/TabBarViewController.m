//
//  PathViewController.m
//  RaisedCenterTabBar
//
//  Created by Peter Boctor on 12/15/10.
//
// Copyright (c) 2011 Peter Boctor
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//

#import "TabBarViewController.h"
#import "AppDelegate.h"

@implementation TabBarViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navigationItem.hidesBackButton = YES;

    //self.title = @"Aghnam";
    
    
//    CGRect navigationBarRect =self.navigationController.navigationBar.frame;
//    UIImage *v_Img = [self scaleImageToSize:[UIImage imageNamed:@"naviBar.png"] newSize:navigationBarRect.size];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"naviBar.png"] forBarMetrics:UIBarMetricsDefault];

    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( 30, 0, 70, 44)];
    UIImage *v_bgImg = [self scaleImageToSize:[UIImage imageNamed:@"browseBtn.png"] newSize:CGSizeMake(70, 44)];
    [button setBackgroundImage:v_bgImg forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBrowseBtn) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:button.frame];
    [view addSubview:button];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
    UIImage *v_bgImg1 = [self scaleImageToSize:[UIImage imageNamed:@"inviteBtn.png"] newSize:CGSizeMake(70, 44)];
    [button1 setBackgroundImage:v_bgImg1 forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickInviteBtn) forControlEvents:UIControlEventTouchUpInside];
    UIView *view1 = [[UIView alloc] initWithFrame:button1.frame];
    [view1 addSubview:button1];
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:view1];
    
    self.navigationItem.rightBarButtonItems = @[barButtonItem1, barButtonItem];

    
}

- (UIImage *)scaleImageToSize:(UIImage*)image newSize:(CGSize)newSize
{
    
    CGRect scaledImageRect = CGRectZero;
    
    CGFloat aspectWidth = newSize.width / image.size.width;
    CGFloat aspectHeight = newSize.height / image.size.height;
    CGFloat aspectRatio = MIN ( aspectWidth, aspectHeight );
    
    scaledImageRect.size.width = image.size.width * aspectRatio;
    scaledImageRect.size.height = image.size.height * aspectRatio;
    scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0f;
    scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0f;
    
    UIGraphicsBeginImageContextWithOptions( newSize, NO, 0 );
    [image drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

//- (void) viewDidDisappear:(BOOL)animated
//{
//    self.navigationItem.hidesBackButton = YES;
//    
//}
//- (void) viewWillAppear:(BOOL)animated
//{
//    self.navigationItem.hidesBackButton = YES;
//    
//}

-(void)willAppearIn:(UINavigationController *)navigationController
{
  [self addCenterButtonWithImage:[UIImage imageNamed:@"capture-button.png"] highlightImage:nil];
}

- (void)clickBrowseBtn
{
    NSLog(@" === click Browse Btn === ");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickInviteBtn
{
    NSLog(@" === click Invite Btn === ");
    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
    float v_height = [AppDelegate sharedInstance].window.bounds.size.height;

    NSString *text = @"Hello world";
    NSString *url = @"http://bufferapp.com";
    NSArray *activityItems = @[text, url];

    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:activityItems   applicationActivities:nil];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityView animated:YES completion:^{
            
        }];
    } else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityView];
        [popup presentPopoverFromRect:CGRectMake(v_width, -v_height/5, v_height/4, v_height/4) inView:[AppDelegate sharedInstance].window.rootViewController.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }

}


@end
