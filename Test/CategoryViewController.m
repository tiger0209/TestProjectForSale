//
//  FirstViewController.m
//  Test
//
//  Created by Lion0324 on 5/28/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import "CategoryViewController.h"
#import "FRGWaterfallCollectionViewCell.h"
#import "FRGWaterfallCollectionViewLayout.h"
#import "FRGWaterfallHeaderReusableView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"


#define COLUMN_WIDTH_RATIO  0.45f
#define CATEGORY_NUM  12

static NSString* const WaterfallCellIdentifier = @"WaterfallCell";
static NSString* const WaterfallHeaderIdentifier = @"WaterfallHeader";


@interface CategoryViewController ()<FRGWaterfallCollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *cellHeights;
@property (nonatomic, retain) MBProgressHUD *HUD;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setHidden:NO];
    //self.title = @"Aghnam";
    self.navigationItem.hidesBackButton = YES;
    
    
    ////
    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
    //float v_height = [AppDelegate sharedInstance].window.bounds.size.height;
    self.m_categoryCollectionView.delegate = self;
    
    [self.m_categoryCollectionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:64.0f/255.0f blue:101.0f/255.0f alpha:1.0f]];
    FRGWaterfallCollectionViewLayout *cvLayout = [[FRGWaterfallCollectionViewLayout alloc] init];
    cvLayout.delegate = self;
    cvLayout.itemWidth = v_width * COLUMN_WIDTH_RATIO;//140.0f;
    cvLayout.topInset = 10.0f;
    cvLayout.bottomInset = 10.0f;
    cvLayout.stickyHeader = NO;
    [self.m_categoryCollectionView setCollectionViewLayout:cvLayout];
    
    /////
    [self setupViewControllers];
    
    [self customizeInterface];
}

- (void) viewDidAppear:(BOOL)animated
{
    
}
- (void) viewDidDisappear:(BOOL)animated
{
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    self.navigationItem.hidesBackButton = YES;

}
- (void) viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: newBackButton];
    self.navigationItem.hidesBackButton = YES;

}
- (void) viewWillDisappear:(BOOL)animated
{
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return CATEGORY_NUM;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FRGWaterfallCollectionViewCell *waterfallCell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterfallCellIdentifier
                                                                                              forIndexPath:indexPath];
    
    NSString *v_category_name;
    switch (indexPath.row) {
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
    waterfallCell.lblTitle_name.text = v_category_name;
    
    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
    UIImage *v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Category_%d.jpeg", (int)indexPath.row ]];
    float v_img_w = [v_img size].width;
    float v_ratio = v_width*COLUMN_WIDTH_RATIO / v_img_w;
    float v_img_h = [v_img size].height*v_ratio;
    v_img = [self scaleImageToSize:v_img newSize:CGSizeMake(v_width*COLUMN_WIDTH_RATIO, v_img_h)];
    v_img_w = [v_img size].width;
    v_img_h = [v_img size].height;
    
    waterfallCell.frameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, v_width*COLUMN_WIDTH_RATIO, v_img_h+20)];
    [waterfallCell.frameView setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    //waterfallCell.frameView.layer.masksToBounds = YES;
    //waterfallCell.frameView.layer.cornerRadius = 2;
    waterfallCell.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, v_width*COLUMN_WIDTH_RATIO, v_img_h)];
    waterfallCell.imageView.image = v_img;
    [waterfallCell.frameView addSubview:waterfallCell.imageView];
    
    waterfallCell.lblTitle_name  = [[UILabel alloc] initWithFrame:CGRectMake( 5, v_img_h, v_width*COLUMN_WIDTH_RATIO,  20)];
    waterfallCell.lblTitle_name.text = v_category_name;
    waterfallCell.lblTitle_name.textColor = [UIColor blackColor];
    waterfallCell.lblTitle_name.textAlignment = NSTextAlignmentCenter;
    waterfallCell.lblTitle_name.font = [UIFont fontWithName:@"Arial" size:14];
    [waterfallCell.frameView addSubview:waterfallCell.lblTitle_name];
    
    [waterfallCell addSubview:waterfallCell.frameView];
    
    return waterfallCell;
}

- (UIImage *)scaleImage:(UIImage*)image toResolution:(int)resolution
{
    CGImageRef imgRef = [image CGImage];
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGFloat ratio = width/height;
    
    bounds.size.width = resolution;
    bounds.size.height = bounds.size.width / ratio;
    UIGraphicsBeginImageContext(bounds.size);
    [image drawInRect:CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
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


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"----section %d item %d-----", indexPath.section, indexPath.item );
    //////lgilgilgi
    UIImage *v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Category_%d.jpeg", (int)indexPath.row ]];
    float v_img_w = [v_img size].width;
    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
    float v_ratio = v_width*COLUMN_WIDTH_RATIO / v_img_w;
    float v_img_h = [v_img size].height*v_ratio + 20;
    self.cellHeights[indexPath.section + 1 * indexPath.item] = @(v_img_h);
    return [self.cellHeights[indexPath.section + 1 * indexPath.item] floatValue];
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView
//                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
//heightForHeaderAtIndexPath:(NSIndexPath *)indexPath {
//    return (indexPath.section + 1) * 26.0f;
//}

- (NSMutableArray *)cellHeights {
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray arrayWithCapacity:CATEGORY_NUM];
        for (int i = 0; i < CATEGORY_NUM; i++) {
            UIImage *v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Category_%d.jpeg", i ]];
            float v_img_w = [v_img size].width;
            float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
            float v_ratio = v_width*COLUMN_WIDTH_RATIO / v_img_w;
            float v_img_h = [v_img size].height*v_ratio + 20;
            self.cellHeights[i] = @(v_img_h);
        }
    }
    return _cellHeights;
}


#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [AppDelegate sharedInstance].g_categoryType = (int)indexPath.row;
//    NSLog(@"Category View did Click!!!!!!");
//    [self performSegueWithIdentifier:@"toTabbarController" sender:nil];
    [self setupViewControllers];
    [self.navigationController pushViewController:self.viewController animated:NO];
    
}

- (void)setupViewControllers {
    
//    UIViewController *firstViewController = [[FirstViewController alloc] init];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    FirstViewController *firstViewController = (FirstViewController*)[mainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"FirstViewController"];
    firstViewController.m_CategoryViewController = self;
    
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    SecondViewController *secondViewController = (SecondViewController*)[mainStoryboard
                                                                instantiateViewControllerWithIdentifier: @"FiveViewController3"];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    ThirdViewController *thirdViewController = (ThirdViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"FiveViewController2"];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];

    FourViewController *fourViewController = (FourViewController*)[mainStoryboard
                                                                instantiateViewControllerWithIdentifier: @"FiveViewController1"];
    UIViewController *fourNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:fourViewController];

    FiveViewController *fiveViewController = (FiveViewController*)[mainStoryboard
                                                                instantiateViewControllerWithIdentifier: @"FiveViewController"];
    UIViewController *fiveNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:fiveViewController];

    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
//    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
//                                           thirdNavigationController, fourNavigationController, fiveNavigationController]];

    [tabBarController setViewControllers:@[firstViewController, secondViewController,
                                           thirdViewController, fourViewController, fiveViewController]];

    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"home", @"ask", @"photo", @"deal", @"profile"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
