//
//  AddTableTableViewCell.h
//  CamBinder
//
//  Created by Takuma Horiuchi on 2014/09/14.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTableTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelSubject;
@property (weak, nonatomic) IBOutlet UILabel *labelSemester;
@property (weak, nonatomic) IBOutlet UILabel *labelClass;

+ (CGFloat)rowHeight;


@end
