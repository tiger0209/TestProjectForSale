//
//  FirstViewController.m
//  Test
//
//  Created by Lion0324 on 5/28/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import "FirstViewController.h"
#import "FRGWaterfallCollectionViewCell.h"
#import "FRGWaterfallCollectionViewLayout.h"
#import "FRGWaterfallHeaderReusableView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "RDVTabBarController.h"
#import "GoodsDetailViewController.h"

#define COLUMN_WIDTH_RATIO  0.30f

#define TABLE_ITES_COUNT0    30
#define TABLE_ITES_COUNT1    30
#define TABLE_ITES_COUNT2    40
#define TABLE_ITES_COUNT3    45
#define TABLE_ITES_COUNT4    50
#define TABLE_ITES_COUNT5    50
#define TABLE_ITES_COUNT6    50
#define TABLE_ITES_COUNT7    45
#define TABLE_ITES_COUNT8    30
#define TABLE_ITES_COUNT9    20
#define TABLE_ITES_COUNT10    30
#define TABLE_ITES_COUNT11    25

static NSString* const GoodsCellIdentifier = @"GoodsCell";
static NSString* const WaterfallHeaderIdentifier = @"WaterfallHeader";

@interface FirstViewController ()<FRGWaterfallCollectionViewDelegate, MBProgressHUDDelegate>
@property (nonatomic, strong) NSMutableArray *cellHeights;
@property (nonatomic, retain) MBProgressHUD *HUD;

@end


@implementation FirstViewController

@synthesize HUD;
@synthesize m_CategoryViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"First";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( 30, 0, 70, 44)];
//    UIImage *v_bgImg = [self scaleImageToSize1:[UIImage imageNamed:@"browseBtn.png"] newSize:CGSizeMake(70, 44)];
//    [button setBackgroundImage:v_bgImg forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(clickBrowseBtn) forControlEvents:UIControlEventTouchUpInside];
//    UIView *view = [[UIView alloc] initWithFrame:button.frame];
//    [view addSubview:button];
//    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
//    
//    
//    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 70, 44)];
//    UIImage *v_bgImg1 = [self scaleImageToSize1:[UIImage imageNamed:@"inviteBtn.png"] newSize:CGSizeMake(70, 44)];
//    [button1 setBackgroundImage:v_bgImg1 forState:UIControlStateNormal];
//    [button1 addTarget:self action:@selector(clickInviteBtn) forControlEvents:UIControlEventTouchUpInside];
//    UIView *view1 = [[UIView alloc] initWithFrame:button1.frame];
//    [view1 addSubview:button1];
//    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:view1];
//    
//    UINavigationItem *navigationItem = self.navigationItem;
//    
//    self.navigationItem.rightBarButtonItems = @[barButtonItem1, barButtonItem];


    
    ////
    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
    //float v_height = [AppDelegate sharedInstance].window.bounds.size.height;
    
    self.m_goodsCollectionView.delegate = self;    
    [self.m_goodsCollectionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:64.0f/255.0f blue:101.0f/255.0f alpha:1.0f]];
    FRGWaterfallCollectionViewLayout *cvLayout = [[FRGWaterfallCollectionViewLayout alloc] init];
    cvLayout.delegate = self;
    cvLayout.itemWidth = v_width * COLUMN_WIDTH_RATIO;//140.0f;
    cvLayout.topInset = 10.0f;
    cvLayout.bottomInset = 10.0f;
    cvLayout.stickyHeader = NO;
    [self.m_goodsCollectionView setCollectionViewLayout:cvLayout];
    
    
    int v_retValue;
    switch ([AppDelegate sharedInstance].g_categoryType) {
            
        case 0:
            v_retValue = TABLE_ITES_COUNT1;
            break;
        case 1:
            v_retValue = TABLE_ITES_COUNT2;
            break;
        case 2:
            v_retValue = TABLE_ITES_COUNT3;
            break;
        case 3:
            v_retValue = TABLE_ITES_COUNT4;
            break;
        case 4:
            v_retValue = TABLE_ITES_COUNT5;
            break;
        case 5:
            v_retValue = TABLE_ITES_COUNT6;
            break;
        case 6:
            v_retValue = TABLE_ITES_COUNT7;
            break;
        case 7:
            v_retValue = TABLE_ITES_COUNT8;
            break;
        case 8:
            v_retValue = TABLE_ITES_COUNT9;
            break;
        case 9:
            v_retValue = TABLE_ITES_COUNT10;
            break;
        case 10:
            v_retValue = TABLE_ITES_COUNT11;
            break;
        case 11:
            v_retValue = TABLE_ITES_COUNT0;
            break;
            
        default:
            break;
    }

    m_itemCount = v_retValue;
    
    ///lgilgilgi
    //HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    [HUD setLabelFont:[UIFont systemFontOfSize:12]];
    [HUD setLabelText:@"Loading..."];

    [HUD hide:YES afterDelay:2.0];

}

- (void) viewDidDisappear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    
}
- (void) viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return m_itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FRGWaterfallCollectionViewCell *waterfallCell = [collectionView dequeueReusableCellWithReuseIdentifier:GoodsCellIdentifier
                                                                                              forIndexPath:indexPath];
    
    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
    UIImage *v_img;
    switch ([AppDelegate sharedInstance].g_categoryType) {
            
        case 1:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 2:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Goat_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 3:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Sheep_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 4:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Horse_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 5:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Ox_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 6:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 7:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Goat_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 8:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Sheep_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 9:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Horse_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 10:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Ox_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 11:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 0:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
            
        default:
            break;
    }

    
    float v_img_w = [v_img size].width;
    float v_ratio = v_width*COLUMN_WIDTH_RATIO / v_img_w;
    float v_img_h = [v_img size].height*v_ratio;
    v_img = [self scaleImageToSize:v_img newSize:CGSizeMake(v_width*COLUMN_WIDTH_RATIO, v_img_h)];
    v_img_w = [v_img size].width;
    v_img_h = [v_img size].height;
    
    waterfallCell.frameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, v_width*COLUMN_WIDTH_RATIO, v_img_h)];
    [waterfallCell.frameView setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    //waterfallCell.frameView.layer.masksToBounds = YES;
    //waterfallCell.frameView.layer.cornerRadius = 2;
    
    waterfallCell.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, v_width*COLUMN_WIDTH_RATIO, v_img_h)];
    waterfallCell.imageView.image = v_img;
    //waterfallCell.imageView.layer.masksToBounds = YES;
    //waterfallCell.imageView.layer.cornerRadius = 2;
    
    
    [waterfallCell.frameView addSubview:waterfallCell.imageView];

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


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"----section %d item %d-----", indexPath.section, indexPath.item );
    //////lgilgilgi
    
    UIImage *v_img;
    switch ([AppDelegate sharedInstance].g_categoryType) {
            
        case 1:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 2:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Goat_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 3:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Sheep_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 4:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Horse_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 5:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Ox_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 6:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 7:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Goat_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 8:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Sheep_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 9:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Horse_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 10:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Ox_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 11:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 0:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
            
        default:
            break;
    }

    float v_img_w = [v_img size].width;
    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
    float v_ratio = v_width*COLUMN_WIDTH_RATIO / v_img_w;
    float v_img_h = [v_img size].height*v_ratio;
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
        _cellHeights = [NSMutableArray arrayWithCapacity:m_itemCount];
        for (int i = 0; i < m_itemCount; i++) {
            
            UIImage *v_img;
            switch ([AppDelegate sharedInstance].g_categoryType) {
                    
                case 1:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", i % 10 ]];
                    break;
                case 2:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Goat_%d.jpeg", i % 10 ]];
                    break;
                case 3:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Sheep_%d.jpeg", i % 10 ]];
                    break;
                case 4:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Horse_%d.jpeg", i % 10 ]];
                    break;
                case 5:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Ox_%d.jpeg", i % 10 ]];
                    break;
                case 6:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", i % 10 ]];
                    break;
                case 7:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Goat_%d.jpeg", i % 10 ]];
                    break;
                case 8:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Sheep_%d.jpeg", i % 10 ]];
                    break;
                case 9:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Horse_%d.jpeg", i % 10 ]];
                    break;
                case 10:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Ox_%d.jpeg", i % 10 ]];
                    break;
                case 11:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", i % 10 ]];
                    break;
                case 0:
                    v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", i % 10 ]];
                    break;
                    
                default:
                    break;
            }

            float v_img_w = [v_img size].width;
            float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
            float v_ratio = v_width*COLUMN_WIDTH_RATIO / v_img_w;
            float v_img_h = [v_img size].height*v_ratio;
            self.cellHeights[i] = @(v_img_h);
        }
    }
    return _cellHeights;
}


#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *v_img;
    switch ([AppDelegate sharedInstance].g_categoryType) {
            
        case 1:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 2:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Goat_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 3:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Sheep_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 4:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Horse_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 5:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Ox_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 6:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 7:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Goat_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 8:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Sheep_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 9:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Horse_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 10:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Ox_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 11:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
        case 0:
            v_img = [UIImage imageNamed:[NSString stringWithFormat:@"Cow_%d.jpeg", (int)indexPath.row % 10 ]];
            break;
            
        default:
            break;
    }

    NSLog(@"Category View did Click!!!!!!");
    [AppDelegate sharedInstance].g_selectedGoods = v_img;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    GoodsDetailViewController *v_viewController= (GoodsDetailViewController*)[mainStoryboard
                                                           instantiateViewControllerWithIdentifier: @"GoodsDetailViewController"];

    [self.navigationController pushViewController:v_viewController animated:YES];
    
    //[self performSegueWithIdentifier:@"toGoodsDetailViewController" sender:nil];
    
    ///////lgilgilgi
    //[self.m_CategoryViewController.viewController setTabBarHidden:YES animated:YES];
}

//- (void)clickBrowseBtn
//{
//    NSLog(@" === click Browse Btn === ");
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)clickInviteBtn
//{
//    NSLog(@" === click Invite Btn === ");
//    float v_width = [AppDelegate sharedInstance].window.bounds.size.width;
//    float v_height = [AppDelegate sharedInstance].window.bounds.size.height;
//    
//    NSString *text = @"Hello world";
//    NSString *url = @"http://bufferapp.com";
//    NSArray *activityItems = @[text, url];
//    
//    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:activityItems   applicationActivities:nil];
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        [self presentViewController:activityView animated:YES completion:^{
//            
//        }];
//    } else {
//        // Change Rect to position Popover
//        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityView];
//        [popup presentPopoverFromRect:CGRectMake(v_width, -v_height/5, v_height/4, v_height/4) inView:[AppDelegate sharedInstance].window.rootViewController.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//    }
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
