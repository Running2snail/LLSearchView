//
//  TQSectionHeader.m
//  TQMall
//
//  Created by Zin_戦 on 17/3/17.
//  Copyright © 2017年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//
#define SCREENSIZE [UIScreen mainScreen].bounds.size
#import "TQSectionHeader.h"

@implementation TQSectionHeader

{
    BOOL _created;/**< 是否创建过 */
    UILabel *_titleLabel;/**< 标题 */
    UILabel *_detailLabel;/**< 其他内容 */
    UIImageView *_imageView;/**< 图标 */
    UIButton *_btn;/**< 收起按钮 */
    BOOL _canFold;/**< 是否可展开 */
    
}


- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title detail:(NSString *)detail type:(HeaderStyle)type section:(NSInteger)section canFold:(BOOL)canFold {
    if (!_created) {
        [self creatUI];
    }
    _titleLabel.text = title;
//    [_titleLabel setTitle:title forState:UIControlStateNormal];
    if (type == HeaderStyleNoneDetail) {
        _detailLabel.hidden = YES;
    } else {
        _detailLabel.hidden = NO;
        _detailLabel.attributedText = [self attributeStringWith:detail];
    }
    _section = section;
    _canFold = canFold;
    if (canFold) {
        _imageView.hidden = NO;
    } else {
        _imageView.hidden = YES;
    }
}
- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title imageName:(NSString *)imageName section:(NSInteger)section {
    if ((!_created)) {
        [self creatUI];
    }
//    _titleLabel.text = title;
    NSString *tempString = [NSString stringWithFormat:@" %@",title];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:tempString];
    NSTextAttachment *attach=[[NSTextAttachment alloc]init];
    attach.image=[UIImage imageNamed:imageName];
    attach.bounds=CGRectMake(0, -2, 15, 15);
    NSAttributedString *attrStr=[NSAttributedString attributedStringWithAttachment:attach];
//    [mutStr appendAttributedString:attrStr];//图在文字后面
    [mutStr insertAttributedString:attrStr atIndex:0];//深入的插在前面
    _titleLabel.attributedText=mutStr;
    
    _detailLabel.hidden = YES;
    _section = section;
    _imageView.hidden = YES;
    
}
- (NSMutableAttributedString *)attributeStringWith:(NSString *)money {
    NSString *str = [NSString stringWithFormat:@"指数:%@", money];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:money];
    [ats setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    return ats;
}


- (void)creatUI {
    _created = YES;
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, KScreenWidth - 20, 30)];
//    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.layer.cornerRadius = 1;
    _titleLabel.clipsToBounds = YES;
//    _titleLabel.adjustsFontSizeToFitWidth= YES;
    [self.contentView addSubview:_titleLabel];
    
    //其他内容
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, 320-40, 30)];
    //    _detailLabel.backgroundColor = [UIColor greenColor];
    _detailLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_detailLabel];
    
    //按钮
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(0, 5, SCREENSIZE.width, 30);
    //    _btn.backgroundColor = [UIColor redColor];
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btn];
    
    //图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 30, 15, 15, 15)];
    _imageView.image = [UIImage imageNamed:@"right_arrow"];
    [self.contentView addSubview:_imageView];
    
    //线
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREENSIZE.width, 1)];
//    line.image = [UIImage imageNamed:@"line"];
    line.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:line];
}

- (void)setFold:(BOOL)fold {
    _fold = fold;
    if (fold) {
        _imageView.image = [UIImage imageNamed:@"right_arrow"];
    } else {
        _imageView.image = [UIImage imageNamed:@"APC_yellow_acc"];
    }
}

#pragma mark = 按钮点击事件
- (void)btnClick:(UIButton *)btn {
    if (_canFold) {
        if ([self.delegate respondsToSelector:@selector(foldHeaderInSection:)]) {
            [self.delegate foldHeaderInSection:_section];
        }
    }
}

@end
