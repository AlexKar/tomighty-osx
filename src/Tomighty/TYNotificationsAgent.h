//
// Created by Aleksandr Karimov on 11.05.15.
// Copyright (c) 2015 Gig Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TYEventBus;

@protocol TYNotificationsAgent <NSObject>

- (void)showNotificationInResponseToEventsFrom:(id <TYEventBus>)eventBus;

@end