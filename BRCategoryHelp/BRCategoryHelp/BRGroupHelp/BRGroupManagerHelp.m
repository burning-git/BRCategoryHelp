//
//  BRKvoHelp.m
//  CarSeversDemoHelp
//
//  Created by gitBurning on 2017/5/22.
//  Copyright © 2017年 BR. All rights reserved.
//

#import "BRGroupManagerHelp.h"

@implementation BRGroupManagerHelp


/*FIXME:  并行 队列 需要 用完时 br_leaveGroup */
+ (void)br_asyncInGroupConcurrentQueueNotify:(void (^)(void))notifyBlock param:(br_paramsblock)blcok, ...
{
    va_list params;//定义一个指向个数可变的参数列表指针
    va_start(params, blcok);//va_start 得到第一个可变参数地址
    NSString *arg;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (blcok) {
        //将第一个参数添加到array
        id prev = blcok;
        [array addObject:[prev copy]];
        
        //va_arg 指向下一个参数地址
        //
        while ((arg = va_arg(params, NSString *))) {
            if (arg) {
               // NSLog(@"%@",arg);
                [array addObject:[arg copy]];
            }
        }
        //置空
        va_end(params);
    }
    [BRGroupManagerHelp br_asyncInGroupQueueNotify:notifyBlock type:0 params:array];
    
}

/*FIXME:  串行队列  需要 用完时 br_leaveGroup */
+ (void)br_asyncInGroupSerialQueueNotify:(void (^)(void))notifyBlock param:(br_paramsblock)blcok, ... {
    
    va_list params;//定义一个指向个数可变的参数列表指针
    va_start(params, blcok);//va_start 得到第一个可变参数地址
    NSString *arg;
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (blcok) {
        //将第一个参数添加到array
        id prev = blcok;
        [array addObject:[prev copy]];
        
        //va_arg 指向下一个参数地址
        //
        while ((arg = va_arg(params, NSString *))) {
            if (arg) {
                // NSLog(@"%@",arg);
                [array addObject:[arg copy]];
            }
        }
        //置空
        va_end(params);
    }
    [BRGroupManagerHelp br_asyncInGroupQueueNotify:notifyBlock type:1 params:array];
    
}


/**
 串、并行队列

 @param notifyBlock 执行完了，汇总
 @param type 0 串 1 并
 @param array 参数
 */
+ (void)br_asyncInGroupQueueNotify:(void (^)(void))notifyBlock type:(NSInteger)type params:(NSArray *)array{
    
    dispatch_queue_t queue ;
    if (type == 1) {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    else if (type == 0){
        queue = dispatch_queue_create("br.com.dispatch.serial", DISPATCH_QUEUE_SERIAL);
    }
    dispatch_group_t group = dispatch_group_create();
    
    for (br_paramsblock params in array) {
        
        dispatch_group_enter(group);
        params(group);
    }
    dispatch_group_notify(group, queue, ^{
        
        if (notifyBlock) {
            notifyBlock();
        }
    });

    
}

+ (void)br_leaveGroup:(dispatch_group_t)group {
    
    dispatch_group_leave(group);

}
@end
