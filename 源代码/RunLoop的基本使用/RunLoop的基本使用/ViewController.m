//
//  ViewController.m
//  RunLoop的基本使用
//
//  Created by 张文艺 on 2021/1/16.
//

/**
 1、RunLoop的创建
 2、RunLoop的Mode设置
 3、RunLoop的销毁----直接销毁线程
 4、添加事件源、时间源，监听者
 
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //主线程
    //    [self mainThreadTest];
    //子线程创建和销毁
    [self subThreadTest];
    //添加事件

}

//这里我们可以看到在线程中会不停的触发时间，这就表示主线程的循环一直在执行
/*
 主线程的RunLoop自动开启，
 */
- (void)mainThreadTest{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"主线程下定时器的循环调用");
    }];
    /*
     1、主线程已经默认开启，这里不需要run
     */
//    [[NSRunLoop mainRunLoop] run];
    /*
     2、默认是在SDefaultRunLoopMode下
     */
    NSLog(@"mode=%@",[[NSRunLoop currentRunLoop] currentMode]);
    
}

/*
 子线程的RunLoop不会自动开启
 需要手动运行
 */
- (void)subThreadTest{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"这是一个子线程");
      NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
          NSLog(@"子线程下定时器的循环调用");
      }];
        /*
         1、子线程必须手动开启
         */
        
        /*
         2、如何设置mode
         */
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        NSLog(@"mode111=%@",[[NSRunLoop currentRunLoop] currentMode]);
        
        /*
         3、如何更改模式？
            只能先退出循环再切换模式，再进入循环
         */
        [[NSRunLoop currentRunLoop] runMode:UITrackingRunLoopMode beforeDate:[NSDate now]];
        NSLog(@"mode222=%@",[[NSRunLoop currentRunLoop] currentMode]);
        [[NSRunLoop currentRunLoop] run];
    });


@end
