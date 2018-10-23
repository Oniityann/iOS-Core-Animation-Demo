//
//  ViewController.m
//  CPMatchingDemo
//
//  Created by Oniityann on 2018/10/23.
//  Copyright © 2018 Oniityann. All rights reserved.
//

#import "ViewController.h"
#import "CPMatchingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CPMatchingView *matchingView = [[CPMatchingView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:matchingView];
}


@end
