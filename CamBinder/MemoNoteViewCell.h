//
//  MemoNoteViewCell.h
//  CamBinder
//
//  Created by 松本拓真 on 2014/09/06.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoNoteViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textMemo;
@property (weak, nonatomic) IBOutlet UILabel *labelMemoDate;

+ (CGFloat)rowHeight;

@end
