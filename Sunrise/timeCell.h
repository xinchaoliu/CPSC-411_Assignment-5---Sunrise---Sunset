//
//  timeCell.h
//  Sunrise
//
//  Created by Xinchao Liu on 5/9/13.
//  Copyright (c) 2013 Assignment5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface timeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLocalLabel;

@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLocalLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
