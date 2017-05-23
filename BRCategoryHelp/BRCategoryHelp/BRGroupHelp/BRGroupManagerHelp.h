//
//  BRKvoHelp.h
//  CarSeversDemoHelp
//
//  Created by gitBurning on 2017/5/22.
//  Copyright © 2017年 BR. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^br_paramsblock)(dispatch_group_t group);
@interface BRGroupManagerHelp : NSObject


/**
 并行 队列 需要 用完时 br_leaveGroup

 @param notifyBlock <#notifyBlock description#>
 @param blcok <#blcok description#>
 */
+ (void)br_asyncInGroupConcurrentQueueNotify:(void(^)(void))notifyBlock param:(br_paramsblock)blcok,...;


/**
 串行队列  需要 用完时 br_leaveGroup

 @param notifyBlock <#notifyBlock description#>
 @param blcok <#blcok description#>
 */
+ (void)br_asyncInGroupSerialQueueNotify:(void(^)(void))notifyBlock param:(br_paramsblock)blcok,...;

+ (void)br_leaveGroup:(dispatch_group_t)group;

@end

