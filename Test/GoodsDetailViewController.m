//
//  GoodsDetailviewController.m
//  Test
//
//  Created by Lion0324 on 5/30/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GoodsDetailViewController.h"
#import "SSUIViewMiniMe.h"

#import "AppDelegate.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height
#define BUTTON_SIZE 10

@interface GoodsDetailViewController () <SSUIViewMiniMeDelegate>

@end

@implementation GoodsDetailViewController
{
    SSUIViewMiniMe *ssMiniMeView;
    NSInteger row;
    NSInteger col;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.title = @"Aghnam";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( 30, 0, 70, 44)];
    UIImage *v_bgImg = [self scaleImageToSize1:[UIImage imageNamed:@"browseBtn.png"] newSize:CGSizeMake(70, 44)];
    [button setBackgroundImage:v_bgImg forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBrowseBtn) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:button.frame];
    [view addSubview:button];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
    UIImage *v_bgImg1 = [self scaleImageToSize1:[UIImage imageNamed:@"inviteBtn.png"] newSize:CGSizeMake(70, 44)];
    [button1 setBackgroundImage:v_bgImg1 forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickInviteBtn) forControlEvents:UIControlEventTouchUpInside];
    UIView *view1 = [[UIView alloc] initWithFrame:button1.frame];
    [view1 addSubview:button1];
    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:view1];
    
    UINavigationItem *navigationItem = self.navigationItem;
    
    self.navigationItem.rightBarButtonItems = @[barButtonItem1, barButtonItem];

    
    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
    float v_height = [AppDelegate sharedInstance].window.bounds.size.height;

    
    UIView *tempView = [[UIView alloc]initWithFrame:self.view.frame];
    //UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BigPic"]];
    
    UIImage *v_image = [self scaleImageToSize:[AppDelegate sharedInstance].g_selectedGoods newSize:CGSizeMake(v_width, v_height)];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:v_image];
    imgView.frame = tempView.frame;
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [tempView addSubview:imgView];

    ssMiniMeView = [[SSUIViewMiniMe alloc]initWithView:tempView withRatio:8];
    [ssMiniMeView.scrollView setZoomScale:2.0f];
    ssMiniMeView.delegate = self;
    
    

    [self.m_goodsDetailView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:64.0f/255.0f blue:101.0f/255.0f alpha:1.0f]];
    [self.m_goodsDetailView setContentSize: CGSizeMake(v_width, v_height*1.5f)] ;
    [self.m_goodsDetailView addSubview:ssMiniMeView];
    
    //////////Title Price
    UIView *v_titleView = [[UIView alloc] initWithFrame:CGRectMake(0, v_height - v_height*0.16f, v_width, v_height*0.08f)];
    [v_titleView setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.7f]];

    UILabel *v_title = [[UILabel alloc] initWithFrame:CGRectMake(v_width*0.05f, 0, v_width*0.5f, v_height*0.08f)];
    v_title.font = [UIFont fontWithName:@"Arial" size:15];
    v_title.textAlignment = NSTextAlignmentLeft;
    v_title.textColor = [UIColor whiteColor];
    
    NSString *v_category_name;
    switch ([AppDelegate sharedInstance].g_categoryType) {
        case 0:
            v_category_name = @"Search Everything";
            break;
        case 1:
            v_category_name = @"Good Cow";
            break;
        case 2:
            v_category_name = @"Good Goat";
            break;
        case 3:
            v_category_name = @"Good Sheep";
            break;
        case 4:
            v_category_name = @"Good Horse";
            break;
        case 5:
            v_category_name = @"Good Ox";
            break;
        case 6:
            v_category_name = @"Best Cow";
            break;
        case 7:
            v_category_name = @"Best Goat";
            break;
        case 8:
            v_category_name = @"Best Sheep";
            break;
        case 9:
            v_category_name = @"Best Horse";
            break;
        case 10:
            v_category_name = @"Best Ox";
            break;
        case 11:
            v_category_name = @"Best Animals";
            break;
        default:
            break;
    }

    v_title.text = v_category_name;
    [v_titleView addSubview:v_title];
    
    UILabel *v_price = [[UILabel alloc] initWithFrame:CGRectMake(v_width - v_width*0.4f, 0, v_width*0.3f, v_height*0.08f)];
    v_price.textAlignment = NSTextAlignmentRight;
    v_price.font = [UIFont fontWithName:@"Arial" size:15];
    v_price.textColor = [UIColor whiteColor];
    int v_random = (int)arc4random();
    v_random = abs(v_random);
    v_price.text = [NSString stringWithFormat:@"$%d", v_random % 10000];
    [v_titleView addSubview:v_price];

    [self.m_goodsDetailView addSubview:v_titleView];
    
    
    ////////Description
    UIView *v_description_View = [[UIView alloc] initWithFrame:CGRectMake(0, v_height - v_height*0.16f + v_height*0.08f, v_width, v_height*0.32f)];
    [v_description_View setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f]];

    UILabel *v_descTitle = [[UILabel alloc] initWithFrame:CGRectMake(v_width*0.05f, 0, v_width*0.5f, v_height*0.08f)];
    v_descTitle.font = [UIFont fontWithName:@"Arial" size:15];
    v_descTitle.textAlignment = NSTextAlignmentLeft;
    v_descTitle.textColor = [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    v_descTitle.text = @"Furniture";

    UITextView *v_descTextView = [[UITextView alloc] initWithFrame:CGRectMake(v_width*0.05f, v_height*0.08f, v_width*0.9f, v_height*0.08f)];
    [v_descTextView setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f]];
    v_descTextView.text = @"This Sheep is best one among my ones.";
    v_descTextView.textAlignment = NSTextAlignmentLeft;
    v_descTextView.textColor = [UIColor blackColor];
    v_descTextView.font = [UIFont fontWithName:@"Arial" size:15];
    [v_descTextView setEditable:NO];
    
    UILabel *v_conditionTitle = [[UILabel alloc] initWithFrame:CGRectMake(v_width*0.05f, v_height*0.08f + v_height*0.08f, v_width*0.9f, v_height*0.08f)];
    v_conditionTitle.font = [UIFont fontWithName:@"Arial" size:15];
    v_conditionTitle.textAlignment = NSTextAlignmentLeft;
    v_conditionTitle.textColor = [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    v_conditionTitle.text = @"Condition: Used (Best Sheep)";
    
    UILabel *v_postDateTitle = [[UILabel alloc] initWithFrame:CGRectMake(v_width*0.05f, v_height*0.08f + v_height*0.08f + v_height*0.08f, v_width*0.9f, v_height*0.08f)];
    v_postDateTitle.font = [UIFont fontWithName:@"Arial" size:15];
    v_postDateTitle.textAlignment = NSTextAlignmentLeft;
    v_postDateTitle.textColor = [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    v_postDateTitle.text = @"Posted 5 days ago";
    
    [v_description_View addSubview:v_descTitle];
    [v_description_View addSubview:v_descTextView];
    [v_description_View addSubview:v_conditionTitle];
    [v_description_View addSubview:v_postDateTitle];
    
    [self.m_goodsDetailView addSubview:v_description_View];
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

- (UIImage *)scaleImageToSize1:(UIImage*)image newSize:(CGSize)newSize
{
    
    CGRect scaledImageRect = CGRectZero;
    
    CGFloat aspectWidth = newSize.width / image.size.width;
    CGFloat aspectHeight = newSize.height / image.size.height;
    //CGFloat aspectRatio = MIN ( aspectWidth, aspectHeight );
    
    scaledImageRect.size.width = image.size.width * aspectWidth;
    scaledImageRect.size.height = image.size.height * aspectHeight;
    scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0f;
    scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0f;
    
    UIGraphicsBeginImageContextWithOptions( newSize, NO, 0 );
    [image drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

- (void) viewDidDisappear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    
}
- (void) viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    
}


//- (void)aMethod:(UIButton *)sender
//{
//    NSLog(@"Button #%d Selected",sender.tag);
//    if(sender.isSelected)
//    {
//        sender.selected = NO;
//        [sender setBackgroundColor:[UIColor clearColor]];
//        
//    }
//    
//    else
//    {
//        sender.selected = YES;
//        [sender setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
//    }
//}

- (void)enlargedView:(SSUIViewMiniMe *)enlargedView willBeginDragging:(UIScrollView *)scrollView
{
    //Delegate Example
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
