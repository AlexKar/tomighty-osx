//
// Created by Aleksandr Karimov on 11.05.15.
// Copyright (c) 2015 Gig Software. All rights reserved.
//

#import <Growl/Growl.h>
#import "TYGrowlAgent.h"
#import "TYEventBus.h"
#import "TYTimerContext.h"


@interface TYGrowlAgent () <GrowlApplicationBridgeDelegate>
@end

@implementation TYGrowlAgent {

}

#pragma mark - init

- (instancetype)init {
    self = [super init];
    if (self) {
        [GrowlApplicationBridge setGrowlDelegate:self];
    }
    return self;
}

#pragma mark - TYNotificationsAgent

- (void)showNotificationInResponseToEventsFrom:(id <TYEventBus>)eventBus {
    __typeof(self) __weak wself = self;
    [eventBus subscribeTo:POMODORO_COMPLETE subscriber:^(id eventData) {
        [wself showNotification:@"Current pomodoro is finished"];
    }];
    [eventBus subscribeTo:TIMER_GOES_OFF subscriber:^(id eventData) {
        id <TYTimerContext> timerContext = eventData;
        __typeof(self) sself = wself;
        if ([timerContext getContextType] == SHORT_BREAK) {
            [sself showNotification:@"Short break is finished"];
        }
        else if ([timerContext getContextType] == LONG_BREAK) {
            [sself showNotification:@"Long break is finished"];
        }
    }];
}

#pragma mark - GrowlApplicationBridgeDelegate

- (void)growlNotificationWasClicked:(id)clickContext {

}

#pragma mark - private

- (void)showNotification:(NSString *)notification {
    NSCParameterAssert(notification);
    if (!notification) {
        return;
    }
    [GrowlApplicationBridge notifyWithTitle:@"Status update"
                                description:notification
                           notificationName:notification
                                   iconData:nil
                                   priority:0
                                   isSticky:NO
                               clickContext:nil];
}


@end