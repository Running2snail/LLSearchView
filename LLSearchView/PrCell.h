//
//  PrCell.h
//  chickenProj
//
//  Created by Zin_戦 on 2017/8/16.
//  Copyright © 2017年 Zin_戦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UIButton *downAB;
@property (weak, nonatomic) IBOutlet UIButton *buyNowB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *butNowCons;


@end
