//
//  NextViewController.m
//  ResidentThread
//
//  Created by EZen on 2025/05/06.
//

#import "NextViewController.h"
#import "ResidentThread.h"

@interface NextViewController ()

@property (nonatomic, strong) ResidentThread *thread;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.thread = [[ResidentThread alloc] init];
    [self.thread run];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.thread excuteTaskWithTarget:self action:@selector(testTask)];
}


- (void)testTask {
    NSLog(@"%s: %@", __func__, [NSThread currentThread]);
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
