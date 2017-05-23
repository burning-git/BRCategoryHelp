//
//  ViewController.m
//  BRCategoryHelp
//
//  Created by gitBurning on 2017/4/17.
//  Copyright © 2017年 BR. All rights reserved.
//

#import "ViewController.h"
#import "BRCategoryHelpHeader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BRGroupManagerHelp br_asyncInGroupConcurrentQueueNotify:^{
        NSLog(@"执行 完成");

    } param:
         ^(dispatch_group_t group) {
            
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 
                 NSLog(@"执行 1");
                 [BRGroupManagerHelp br_leaveGroup:group];

             });
             
         },
         ^(dispatch_group_t group) {
             NSLog(@"执行 2");

             [BRGroupManagerHelp br_leaveGroup:group];

         },
         ^(dispatch_group_t group) {
             NSLog(@"执行 3");

             [BRGroupManagerHelp br_leaveGroup:group];

             
         },
           nil
     ];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
