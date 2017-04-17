//
//  UIViewController+BRHelp.m
//  BRCategoryHelp
//
//  Created by gitBurning on 2017/4/17.
//  Copyright © 2017年 BR. All rights reserved.
//

#import "UIViewController+BRHelp.h"
#import <objc/runtime.h>
static char *kBackButtonTitle = "kBackButtonTitle";

@implementation UIViewController (BRHelp)
- (BOOL)isNilOfBackButtonTitle {
    return objc_getAssociatedObject(self, kBackButtonTitle);
}

- (void)setIsNilOfBackButtonTitle:(BOOL)isNilOfBackButtonTitle {
    NSString *temp = @"NO";
    if (isNilOfBackButtonTitle) {
        temp = @"YES";
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        [backButtonItem setTitle:@""];
        self.navigationItem.backBarButtonItem = backButtonItem;
    }
    objc_setAssociatedObject(self, kBackButtonTitle, temp, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

@end


@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(br_navigationShouldPopOnBackButton)]) {
        shouldPop = [vc br_navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return NO;
}
@end
