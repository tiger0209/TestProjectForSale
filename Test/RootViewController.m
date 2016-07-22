//
//  FirstViewController.m
//  Test
//
//  Created by Lion0324 on 5/28/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import "RootViewController.h"
#import "DDPageControl.h"
#import "AppDelegate.h"

#define NUMBER_INTRO_SCENES 4

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    mb_isEnding = NO;
    
    [self.navigationController.navigationBar setHidden:YES];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // define the scroll view content size and enable paging
    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
    float v_height = [AppDelegate sharedInstance].window.bounds.size.height;

    [self.m_IntroduceImagesView setBackgroundColor:[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:239.0f/255.0f]];
    [self.m_IntroduceImagesView setPagingEnabled: YES] ;
    
    [self.m_IntroduceImagesView setContentSize: CGSizeMake(v_width * NUMBER_INTRO_SCENES, v_height)] ;
    
    // programmatically add the page control
    pageControl = [[DDPageControl alloc] init] ;
    [pageControl setCenter: CGPointMake(self.view.center.x, self.view.frame.size.height - 60.0f)] ;
    [pageControl setNumberOfPages: NUMBER_INTRO_SCENES] ;
    [pageControl setCurrentPage: 0] ;
    [pageControl addTarget:self action: @selector(pageControlClicked:) forControlEvents: UIControlEventValueChanged] ;
    [pageControl setDefersCurrentPageDisplay: YES] ;
    [pageControl setType: DDPageControlTypeOnFullOffEmpty] ;
    [pageControl setOnColor: [UIColor colorWithWhite: 0.9f alpha: 1.0f]];
    [pageControl setOffColor: [UIColor colorWithWhite: 0.7f alpha: 1.0f]];
    [pageControl setIndicatorDiameter: 7.0f] ;
    [pageControl setIndicatorSpace: 7.0f] ;
    [self.view addSubview: pageControl] ;
    
    CGRect pageFrame;
    UIImageView *v_pageImageFrame;
    
    for (int i = 0 ; i < NUMBER_INTRO_SCENES ; i++)
    {
        // determine the frame of the current page
        
        pageFrame = CGRectMake(i * v_width, 0.0f, v_width, v_height) ;
        
        v_pageImageFrame = [[UIImageView alloc] initWithFrame:CGRectMake(pageFrame.origin.x,
                                                                         pageFrame.origin.y,
                                                                         v_width,
                                                                         v_height)];
        //UIImage *v_image = [UIImage imageNamed:[NSString stringWithFormat:@"intro_%d.jpeg", i+1 ]];
        UIImage *v_image = [UIImage imageNamed:[NSString stringWithFormat:@"introView_Bg_%d.png", i ]];
        v_image = [self scaleImageToSize:v_image newSize:CGSizeMake(v_width, v_height)];
         
        [v_pageImageFrame setImage:v_image];
        [self.m_IntroduceImagesView addSubview: v_pageImageFrame];
    }
    
    self.m_skipBtn.layer.masksToBounds = YES;
    self.m_skipBtn.layer.cornerRadius = 5;

    
}
- (void) viewDidDisappear:(BOOL)animated
{
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    [self.navigationController.navigationBar setHidden:NO];
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    [self.navigationController.navigationBar setHidden:YES];
    
}

- (UIImage *)scaleImageToSize:(UIImage*)image newSize:(CGSize)newSize
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

#pragma mark -
#pragma mark DDPageControl triggered actions

- (void)pageControlClicked:(id)sender
{
    DDPageControl *thePageControl = (DDPageControl *)sender ;
    
    // we need to scroll to the new index
    [self.m_IntroduceImagesView setContentOffset: CGPointMake(self.m_IntroduceImagesView.bounds.size.width * thePageControl.currentPage, self.m_IntroduceImagesView.contentOffset.y) animated: YES] ;
}

#pragma mark -
#pragma mark UIScrollView delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    [self.m_IntroduceImagesView setContentOffset: CGPointMake(self.m_IntroduceImagesView.contentOffset.x,0)];
    
    CGFloat pageWidth = self.m_IntroduceImagesView.bounds.size.width ;
    float fractionalPage = self.m_IntroduceImagesView.contentOffset.x / pageWidth ;
    NSInteger nearestNumber = lround(fractionalPage) ;
    
    if (pageControl.currentPage != nearestNumber)
    {
        pageControl.currentPage = nearestNumber ;
        
        // if we are dragging, we want to update the page control directly during the drag
        if (self.m_IntroduceImagesView.dragging)
            [pageControl updateCurrentPageDisplay];
    }
    
    ///////lgilgilgi
//    NSLog(@"-------%d--------", (int)pageControl.currentPage);
//    if (pageControl.currentPage == NUMBER_INTRO_SCENES-1 && !mb_isEnding)
//    {
//        mb_isEnding = YES;
//        [self performSegueWithIdentifier:@"ToCategoryViewController" sender:nil];
//    }
    
    if (pageControl.currentPage == 0)
    {
        [self.m_prevBtn setEnabled:NO];
        [self.m_prevBtn setHidden:YES];
        [self.m_skipBtn setTitle:@"skip" forState:UIControlStateNormal];
    }else if (pageControl.currentPage == NUMBER_INTRO_SCENES-1)
    {
        [self.m_nextBtn setEnabled: NO];
        [self.m_nextBtn setHidden:YES];
        [self.m_skipBtn setTitle:@"done" forState:UIControlStateNormal];
    }else {
        [self.m_prevBtn setEnabled:YES];
        [self.m_nextBtn setEnabled:YES];
        [self.m_prevBtn setHidden:NO];
        [self.m_nextBtn setHidden:NO];
        [self.m_skipBtn setTitle:@"skip" forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
    // if we are animating (triggered by clicking on the page control), we update the page control
    [pageControl updateCurrentPageDisplay] ;
}

-(IBAction)clickPrevBtn:(id)sender
{
    [self.m_IntroduceImagesView setContentOffset: CGPointMake(self.m_IntroduceImagesView.bounds.size.width * (pageControl.currentPage-1), self.m_IntroduceImagesView.contentOffset.y) animated: YES] ;

}

-(IBAction)clickNextBtn:(id)sender
{
    [self.m_IntroduceImagesView setContentOffset: CGPointMake(self.m_IntroduceImagesView.bounds.size.width * (pageControl.currentPage+1), self.m_IntroduceImagesView.contentOffset.y) animated: YES] ;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
