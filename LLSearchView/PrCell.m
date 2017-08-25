//
//  PrCell.m
//  chickenProj
//
//  Created by Zin_戦 on 2017/8/16.
//  Copyright © 2017年 Zin_戦. All rights reserved.
//

#import "PrCell.h"

@implementation PrCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PrCell";
    PrCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell ==nil)
    {
        //从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PrCell" owner:nil options:nil] lastObject];
        
    }
    
    return cell;
}



@end
