//
//  UIViewController+BRHelp.h
//  BRCategoryHelp
//
//  Created by gitBurning on 2017/4/17.
//  Copyright © 2017年 BR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BRBackButtonHandlerProtocol <NSObject>
@optional
// 是否拦截 nav back 事件
-(BOOL)br_navigationShouldPopOnBackButton;

@end

@interface UIViewController (BRHelp)<BRBackButtonHandlerProtocol>
/**
 *  下一控制的返回按钮的title是否为空
 */
@property (nonatomic, assign) BOOL isNilOfBackButtonTitle;
@end
