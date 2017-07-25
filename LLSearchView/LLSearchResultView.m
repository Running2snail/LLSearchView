//
//  LLSearchResultView.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchResultView.h"
#import "LLSearchResultListViewCell.h"
#import "LLSearchResultDoubleViewCell.h"

@interface LLSearchResultView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isDoubleList;

@end
@implementation LLSearchResultView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray *)dataArr
{
    if (self = [super initWithFrame:frame]) {
        self.dataSource = dataArr;
        _isDoubleList = YES;
        [self addSubview:self.contentTableView];
    }
    return self;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        self.contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_contentTableView registerClass:[LLSearchResultListViewCell class] forCellReuseIdentifier:@"SearchResultListViewCell"];
        [_contentTableView registerClass:[LLSearchResultDoubleViewCell class] forCellReuseIdentifier:@"SearchResultDoubleViewCell"];
    }
    return _contentTableView;
}

- (void)refreshResultViewWithIsDouble:(BOOL)isDouble
{
    _isDoubleList = isDouble;
    [_contentTableView reloadData];
}


#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = _dataSource.count;
    if (_isDoubleList) {
        if (count % 2 > 0) {
            return count / 2 + 1;
        } else {
            return count / 2;
        }
    } else {
        return count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isDoubleList) {
        LLSearchResultListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultListViewCell" forIndexPath:indexPath];
        [cell configResultListViewCellWithTitle:_dataSource[indexPath.row] cellRow:indexPath.row];
        return cell;
    } else {
        LLSearchResultDoubleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultDoubleViewCell" forIndexPath:indexPath];
        NSInteger row = indexPath.row * 2;
        if (_dataSource.count % 2 > 0 && row + 1 == _dataSource.count) {
            [cell configResultDoubleViewCellWithFirstTitle:_dataSource[row] secondTitle:nil];
        } else {
            [cell configResultDoubleViewCellWithFirstTitle:_dataSource[row] secondTitle:_dataSource[row + 1]];
        }
        return cell;
    }
}


#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _isDoubleList ? KWidth+50 : 120;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
