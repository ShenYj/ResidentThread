//
//  ResidentThread.h
//  ResidentThread
//
//  Created by EZen on 2025/05/06.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResidentThread : NSObject

- (void)run;
- (void)stop;
- (void)excuteTaskWithTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
