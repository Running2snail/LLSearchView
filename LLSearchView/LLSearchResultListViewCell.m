//
//  LLSearchResultListViewCell.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchResultListViewCell.h"

@interface LLSearchResultListViewCell ()

@property (nonatomic, strong) UIImageView *itemImg;
@property (nonatomic, strong) UILabel *itemTitle;

@end

@implementation LLSearchResultListViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UIImageView *)itemImg
{
    if (!_itemImg) {
        self.itemImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 110, 110)];
    }
    return _itemImg;
}


- (UILabel *)itemTitle
{
    if (!_itemTitle) {
        self.itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_itemImg.frame) + 10, CGRectGetMidY(_itemImg.frame) - 10, KScreenWidth - 54, 20)];
        _itemTitle.textAlignment = NSTextAlignmentLeft;
        _itemTitle.font = [UIFont systemFontOfSize:15];
    }
    return _itemTitle;
}


- (void)setSubViews
{
    [self.contentView addSubview:self.itemImg];
    [self.contentView addSubview:self.itemTitle];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_itemImg.frame) + 10, CGRectGetMaxY(_itemImg.frame) + 4, KScreenWidth - CGRectGetMaxX(_itemImg.frame) - 10, 1)];
    line.backgroundColor = KColor(241, 241, 241);
    [self.contentView addSubview:line];
}

- (void)configResultListViewCellWithTitle:(NSString *)title cellRow:(NSInteger)row
{
    _itemTitle.text = title;
    if (row % 2 == 0) {
        _itemImg.image = [UIImage imageNamed:@"leftImage220.jpg"];
    } else {
        _itemImg.image = [UIImage imageNamed:@"rightImage220.jpg"];
    }
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
