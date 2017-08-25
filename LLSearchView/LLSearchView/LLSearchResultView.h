//
//  LLSearchResultView.h
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSearchResultView : UIView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray *)dataArr;

- (void)refreshResultViewWithIsDouble:(BOOL)isDouble;

@end
