//
//  AddNewSubject.m
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/08.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import "AddNewSubject.h"

@implementation AddNewSubject

@synthesize name = _name;
@synthesize done = _done;

- (id)initWithName:(NSString *)name done:(BOOL)done {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.done = done;
    }
    return self;
}

@end
