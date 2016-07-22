//
//  AppDelegate.m
//  Test
//
//  Created by Lion0324 on 5/28/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

@synthesize window;
@synthesize g_categoryType;

+(AppDelegate*) sharedInstance
{
    return (AppDelegate*)([UIApplication sharedApplication].delegate);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES ];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    UINavigationController *controller = (UINavigationController*)[mainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"NavigationController"];
    controller.delegate = self;
    
    // Add the navigation controller's view to the window and display.

    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
     
        UIImage *v_Img = [self scaleImageToSize:[UIImage imageNamed:@"naviBar.png"] newSize:[UINavigationBar appearance].frame.size];
        [[UINavigationBar appearance] setBackgroundImage:v_Img forBarMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:0.0 forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor blueColor]];
        
        // Uncomment to change the color of back button
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
        // Uncomment to assign a custom backgroung image
        
        //CGRect navigationBarRect =self.window.rootViewController.navigationController.navigationBar.frame;
        float width = self.window.bounds.size.width;
        UIImage *v_Img = [self scaleImageToSize:[UIImage imageNamed:@"naviBar.png"] newSize:CGSizeMake(width, 44)];
        [[UINavigationBar appearance] setBackgroundImage:v_Img forBarMetrics:UIBarMetricsDefault];
        
        
        // Uncomment to change the back indicator image
        
        [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@""]];
        
        // Uncomment to change the font style of the title
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        shadow.shadowOffset = CGSizeMake(0, 1);
        
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0], NSFontAttributeName, nil]];
        
        
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:0.0 forBarMetrics:UIBarMetricsDefault];
    }
    
    return YES;
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

////
//#pragma mark NavigationDelegate
//- (void)navigationController:(UINavigationController *)navController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if ([viewController respondsToSelector:@selector(willAppearIn:)])
//        [viewController performSelector:@selector(willAppearIn:) withObject:navController];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
