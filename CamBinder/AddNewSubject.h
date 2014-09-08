//
//  AddNewSubject.h
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/08.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddNewSubject : NSObject

@property (nonatomic,  strong) NSString *name;

@property (nonatomic, assign) BOOL done;

- (id)initWithName:(NSString *)name done:(BOOL)done;

@end
