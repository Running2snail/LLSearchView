//
//  LLSearchResultDoubleViewCell.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchResultDoubleViewCell.h"

@interface LLSearchResultDoubleViewCell ()

@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UILabel *leftTitle;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UILabel *rightTitle;

@end

@implementation LLSearchResultDoubleViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftImage];
        [self.contentView addSubview:self.leftTitle];
        [self.contentView addSubview:self.rightImage];
        [self.contentView addSubview:self.rightTitle];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kSpace, CGRectGetMaxY(_leftTitle.frame) + 9, KScreenWidth - kSpace * 2, 1)];
        line.backgroundColor = KColor(241, 241, 241);
        [self.contentView addSubview:line];
        
    }
    return self;
}

- (UIImageView *)leftImage
{
    if (!_leftImage) {
        self.leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(kSpace, 10, KWidth, KWidth)];
        _leftImage.backgroundColor = [UIColor purpleColor];
    }
    return _leftImage;
}

- (UILabel *)leftTitle
{
    if (!_leftTitle) {
        self.leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(kSpace, CGRectGetMaxY(_leftImage.frame) + 10, KWidth, 20)];
        _leftTitle.textAlignment = NSTextAlignmentCenter;
        _leftTitle.font = [UIFont systemFontOfSize:12];
    }
    return _leftTitle;
}

- (UIImageView *)rightImage
{
    if (!_rightImage) {
        self.rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth - kSpace - KWidth, 10, KWidth, KWidth)];
        _rightImage.backgroundColor = [UIColor yellowColor];
    }
    return _rightImage;
}

- (UILabel *)rightTitle
{
    if (!_rightTitle) {
        self.rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_rightImage.frame), CGRectGetMaxY(_rightImage.frame) + 10, KWidth, 20)];
        _rightTitle.textAlignment = NSTextAlignmentCenter;
        _rightTitle.font = [UIFont systemFontOfSize:12];
    }
    return _rightTitle;
}


- (void)configResultDoubleViewCellWithFirstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle
{
    _leftTitle.text = firstTitle;
    if (KScreenWidth > 375) {
        _leftImage.image = [UIImage imageNamed:@"leftImage576.jpg"];
        _rightImage.image = [UIImage imageNamed:@"rightImage576.jpg"];
    } else {
        _leftImage.image = [UIImage imageNamed:@"leftImage345.jpg"];
        _rightImage.image = [UIImage imageNamed:@"rightImage345.jpg"];
    }
    
    if (secondTitle == nil) {
        _rightImage.hidden = YES;
        _rightTitle.hidden = YES;
    } else {
        _rightImage.hidden = NO;
        _rightTitle.hidden = NO;
        _rightTitle.text = secondTitle;
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
