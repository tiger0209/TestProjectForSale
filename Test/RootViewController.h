//
//  FirstViewController.h
//  Test
//
//  Created by Lion0324 on 5/28/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDPageControl;

@interface RootViewController : UIViewController<UIScrollViewDelegate>
{
    DDPageControl *pageControl;
    BOOL          mb_isEnding;
}

@property (nonatomic, readwrite)  IBOutlet UIScrollView     *m_IntroduceImagesView;
@property (nonatomic, readwrite)  IBOutlet UIButton         *m_prevBtn;
@property (nonatomic, readwrite)  IBOutlet UIButton         *m_nextBtn;
@property (nonatomic, readwrite)  IBOutlet UIButton         *m_skipBtn;

-(IBAction)clickPrevBtn:(id)sender;
-(IBAction)clickNextBtn:(id)sender;

@end

