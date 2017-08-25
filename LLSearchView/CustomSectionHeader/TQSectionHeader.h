//
//  TQSectionHeader.h
//  TQMall
//
//  Created by Zin_戦 on 17/3/17.
//  Copyright © 2017年 Hangzhou Xuanchao Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**不显示 或者不显示 DetailLabel */
typedef NS_ENUM(NSInteger, HeaderStyle){
    HeaderStyleNoneDetail,
    HeaderStyleWithDetail
};

@protocol FoldSectionHeaderViewDelegate <NSObject>

- (void)foldHeaderInSection:(NSInteger)SectionHeader;

@end

@interface TQSectionHeader : UITableViewHeaderFooterView

@property(nonatomic, assign) BOOL fold;/**< 是否折叠 */
@property(nonatomic, assign) NSInteger section;/**< 选中的section */
@property(nonatomic, weak) id<FoldSectionHeaderViewDelegate> delegate;/**< 代理 */


- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title detail:(NSString *)detail type:(HeaderStyle)type section:(NSInteger)section canFold:(BOOL)canFold;
- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title imageName:(NSString *)imageName section:(NSInteger)section;

@end
