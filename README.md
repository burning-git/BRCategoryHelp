# BRCategoryHelp
搜集一些常用的Category.    少造轮子


### UIViewController+BRHelp  扩展 

1：  // 是否拦截 nav back 事件
-(BOOL)br_navigationShouldPopOnBackButton;

2:
/**
 *  下一控制的返回按钮的title是否为空
 */
@property (nonatomic, assign) BOOL isNilOfBackButtonTitle;

### BRGroupHelp 队列使用

1:   //并行 队列 需要 用完时 br_leaveGroup
+ (void)br_asyncInGroupConcurrentQueueNotify:(void(^)(void))notifyBlock param:(br_paramsblock)blcok,...;
2:   // 串行队列  需要 用完时 br_leaveGroup
+ (void)br_asyncInGroupSerialQueueNotify:(void(^)(void))notifyBlock param:(br_paramsblock)blcok,...;
3:  //离线group
+ (void)br_leaveGroup:(dispatch_group_t)group;



待完善，大家常用的扩展请联系我，我增加到 里面去，后续增加 pod 引入
