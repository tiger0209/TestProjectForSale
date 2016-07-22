//
//  AppDelegate.h
//  Test
//
//  Created by Lion0324 on 5/28/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>
{
    UIWindow *window;

}

+(AppDelegate*) sharedInstance;

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) int g_categoryType;
@property (strong, nonatomic) UIImage *g_selectedGoods;

@end

