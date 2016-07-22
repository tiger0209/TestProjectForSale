//
//  FirstViewController.h
//  Test
//
//  Created by Lion0324 on 5/28/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RDVTabBarController;

@interface CategoryViewController : UIViewController
{
    
}

@property (strong, nonatomic)       IBOutlet UICollectionView   *m_categoryCollectionView;
@property (strong, nonatomic)       RDVTabBarController *viewController;
@end

