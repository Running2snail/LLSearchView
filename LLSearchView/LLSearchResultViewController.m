//
//  LLSearchResultViewController.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchResultViewController.h"
#import "LLSearchViewController.h"
#import "LLSearchSuggestionVC.h"
#import "LLSearchResultView.h"
#import "LLSearchView.h"

@interface LLSearchResultViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL activity;
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) LLSearchResultView *resultView;
@property (nonatomic, strong) LLSearchView *searchView;
@property (nonatomic, strong) LLSearchSuggestionVC *searchSuggestVC;

@end

@implementation LLSearchResultViewController

- (NSMutableArray *)searchArray
{
    if (!_searchArray) {
        self.searchArray = [NSMutableArray arrayWithObjects:@"芙丽芳丝补水保湿面膜", @"澳佳宝皇家玫瑰蚕丝面膜", @"科颜氏草本养颜面膜", @"自然乐园保湿控油小清新面膜", @"佰草集新七白面膜",@"美即水漾肌密补水保湿净化面", @"膜法世家白松露睡眠面膜", @"蜗牛玻尿酸蚕丝面膜", @"水密码补水保湿面膜", nil];
    }
    return _searchArray;
}


- (LLSearchResultView *)resultView
{
    if (!_resultView) {
        self.resultView = [[LLSearchResultView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) dataSource:self.searchArray];
    }
    return _resultView;
}


- (LLSearchView *)searchView
{
    if (!_searchView) {
        self.searchView = [[LLSearchView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64) hotArray:self.hotArray historyArray:self.historyArray];
        __weak LLSearchResultViewController *weakSelf = self;
        _searchView.backgroundColor = [UIColor whiteColor];
        _searchView.tapAction = ^(NSString *str) {
            [weakSelf setSearchResultWithStr:str];
        };
    }
    return _searchView;
}

- (LLSearchSuggestionVC *)searchSuggestVC
{
    if (!_searchSuggestVC) {
        self.searchSuggestVC = [[LLSearchSuggestionVC alloc] init];
        _searchSuggestVC.view.frame = CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64);
        _searchSuggestVC.view.hidden = YES;
        __weak LLSearchResultViewController *weakSelf = self;
        _searchSuggestVC.searchBlock = ^(NSString *searchTest) {
            [weakSelf setSearchResultWithStr:searchTest];
        };
    }
    return _searchSuggestVC;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBarButtonItem];
    [self.view addSubview:self.resultView];
    [self.view addSubview:self.searchSuggestVC.view];
}

- (void)setBarButtonItem
{
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    UIImage *img = [UIImage imageNamed:@"NavBar_backImg"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(-10, 10, 22, 22);
    [btn setImage:img forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(presentVCFirstBackClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bbiBack = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, self.view.frame.size.width - 44 * 2 - 16, 30)];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_titleView.frame), 30)];
    _searchBar.text = _searchStr;
    _searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    _searchBar.delegate = self;
    _searchBar.tintColor = [UIColor redColor];
    
    UIView *searchTextField = searchTextField = [self.searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    
    [self.searchBar setImage:[UIImage imageNamed:@"sort_magnifier"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [_titleView addSubview:_searchBar];
    
    self.navigationItem.titleView = _titleView;
    self.navigationItem.leftBarButtonItem = bbiBack;
    self.rightItem = [self setRightBarItem];
    self.navigationItem.rightBarButtonItem = _rightItem;
    
}


- (UIBarButtonItem *)setRightBarItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.selected = NO;
    rightBtn.frame = CGRectMake(14, 7, 30, 30);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    [rightBtn setImage:[UIImage imageNamed:@"icon_wangge"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    return rightBtnItem;
}

- (void)rightBtnItemAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"nav_list_single"] forState:UIControlStateNormal];
        [_resultView refreshResultViewWithIsDouble:NO];
    } else {
        [sender setImage:[UIImage imageNamed:@"icon_wangge"] forState:UIControlStateNormal];
        [_resultView refreshResultViewWithIsDouble:YES];
    }
}


- (void)cancelDidClick
{
    [_searchBar resignFirstResponder];
}

- (void)presentVCFirstBackClick:(UIButton *)sender
{
    [_searchBar resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)setSearchResultWithStr:(NSString *)str
{
    [self.searchBar resignFirstResponder];
    _searchBar.text = str;
    [_searchView removeFromSuperview];
    _searchSuggestVC.view.hidden = YES;
}


#pragma mark -  UISearchBarDelegate  -

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldBeginEditing");
    _activity = !_activity;
    if (_activity) {
        self.navigationItem.rightBarButtonItem = nil;
        _titleView.frame = CGRectMake(0, 7, self.view.frame.size.width - 44 - 16, 30);
        _searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(_titleView.frame), 30);
        searchBar.showsCancelButton = YES;
        UIButton *cancleBtn = [_searchBar valueForKey:@"cancelButton"];
        //修改标题和标题颜色
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return YES;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidBeginEditing-searchTest:%@",searchBar.text);
    if ([searchBar.text length] > 0) {
        _searchSuggestVC.view.hidden = NO;
        [self.view bringSubviewToFront:_searchSuggestVC.view];
        [_searchSuggestVC searchTestChangeWithTest:searchBar.text];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldEndEditing");
    self.navigationItem.rightBarButtonItem = _rightItem;
    _titleView.frame = CGRectMake(0, 7, self.view.frame.size.width - 44 * 2 - 16, 30);
    _searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(_titleView.frame), 30);
    searchBar.showsCancelButton = NO;
    _activity = NO;
    if (![searchBar.text length]) {
        _searchBar.text = _searchStr;
        [_searchView removeFromSuperview];
    };
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange");
    
    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        _searchSuggestVC.view.hidden = YES;
        [self.view addSubview:self.searchView];
        [self.view bringSubviewToFront:_searchView];
    } else {
        _searchSuggestVC.view.hidden = NO;
        [self.view bringSubviewToFront:_searchSuggestVC.view];
        [_searchSuggestVC searchTestChangeWithTest:searchBar.text];
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    self.navigationItem.rightBarButtonItem = _rightItem;
    _titleView.frame = CGRectMake(0, 7, self.view.frame.size.width - 44 * 2 - 16, 30);
    _searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(_titleView.frame), 30);
    searchBar.showsCancelButton = NO;
    _activity = NO;
    
    _searchSuggestVC.view.hidden = YES;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked");
    [_searchView removeFromSuperview];
    [self setSearchResultWithStr:searchBar.text];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
