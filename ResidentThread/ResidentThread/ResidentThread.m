//
//  ResidentThread.m
//  ResidentThread
//
//  Created by EZen on 2025/05/06.
//

#import "ResidentThread.h"
#import "SYJThread.h"

@interface ResidentThread ()

@property (nonatomic, strong) SYJThread *thread;
@property (nonatomic, assign, getter=isStopped) BOOL stopped;

@end

@implementation ResidentThread

- (void)dealloc
{
    NSLog(@"%s", __func__);
    
    [self stop];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        __weak typeof(self) weakSelf = self;
        self.thread = [[SYJThread alloc] initWithBlock:^{
            
            // OC 方式启动 Runloop
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode: NSRunLoopCommonModes];
            while (weakSelf && !weakSelf.stopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate: [NSDate distantFuture]];
            }
            
            /** C 的方式启动 Runloop
             
             CFRunLoopSourceContext context = {0};
             CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
             CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
             CFRelease(source);
             
             /// 第三个参数, 执行完 一次source 就退出当前 loop
             while (weakSelf && !weakSelf.stopped) {
             CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
             }  // or CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
             
             */
        }];
    }
    return self;
}

- (void)run {
    
    if (!self.thread) return;
    
    [self.thread start];
}

- (void)stop {
    
    if (!self.thread) return;
    
    [self performSelector:@selector(_stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)excuteTaskWithTarget:(id)target action:(SEL)action {
    
    if (!self.thread) return;
    if (!target) return;
    
    [target performSelector:action onThread:self.thread withObject:nil waitUntilDone:NO];
}


#pragma mark - Private Function

- (void)_stop {
    
    self.stopped = YES;
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    
    self.thread  = nil;
}


@end
