//
//  LLSearchView.h
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapActionBlock)(NSString *str);
@interface LLSearchView : UIView

@property (nonatomic, copy) TapActionBlock tapAction;

- (instancetype)initWithFrame:(CGRect)frame hotArray:(NSMutableArray *)hotArr historyArray:(NSMutableArray *)historyArr;

@end
