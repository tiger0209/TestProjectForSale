//
//  FirstViewController.h
//  Test
//
//  Created by Lion0324 on 5/28/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryViewController.h"

@interface FirstViewController : UIViewController
{
    int m_itemCount;
}

@property (strong, nonatomic)       IBOutlet UICollectionView   *m_goodsCollectionView;
@property (strong, nonatomic)       CategoryViewController*        m_CategoryViewController;
@end

