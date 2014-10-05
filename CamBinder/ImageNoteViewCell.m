//
//  ImageNoteViewCell.m
//  CamBinder
//
//  Created by 松本拓真 on 2014/09/06.
//  Copyright (c) 2014年 MatsumotoTakuma. All rights reserved.
//

#import "ImageNoteViewCell.h"

@implementation ImageNoteViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight
{
    return 253.0f;
}

@end
