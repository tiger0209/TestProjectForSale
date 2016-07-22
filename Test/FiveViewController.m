//
//  SecondViewController.m
//  Test
//
//  Created by Lion0324 on 5/28/15.
//  Copyright (c) 2015 Lion0324. All rights reserved.
//

#import "FiveViewController.h"
#import "SecondViewController.h"

@interface FiveViewController ()

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:64.0f/255.0f blue:101.0f/255.0f alpha:1.0f]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onTestBtn:(id)sender
{
    SecondViewController *v_controller = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:v_controller animated:nil];
}

@end
