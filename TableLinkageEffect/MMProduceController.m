//
//  MMProduceController.m
//  TableLinkageEffect
//
//  Created by Mortimey on 16/6/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMProduceController.h"

@interface MMProduceController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *productTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *sectionArray;


@property(nonatomic, assign)BOOL isScrollUp;//是否是向上滚动
@property(nonatomic, assign)CGFloat lastOffsetY;//滚动即将结束时scrollView的偏移量


@end

@implementation MMProduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, 64, self.view.frame.size.width * 0.75, self.view.frame.size.height - 64)];
    
    NSArray *array = [self.productTableView visibleCells];
    
    
    
    
    [self.view addSubview:self.productTableView];
    
    _lastOffsetY = 0;

    // 初始化数据源
    [self initData];
    
}
- (void)initData{
    if (!_sectionArray) {
        NSArray *numberArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十"];
        NSMutableArray *tmpAarrat = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            NSString *tmpStr = [NSString stringWithFormat:@"第%@类", numberArray[i]];
            [tmpAarrat addObject:tmpStr];
        }
        _sectionArray = tmpAarrat;
    }
    
    self.dataArray  = @[@"鞋子",@"衣服",@"化妆品",@"饮用水",@"副食品",@"小吃",@"鞋子",@"衣服",@"化妆品",@"饮用水"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [_sectionArray objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *productCellID = @"productCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellID];
    }
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(willDisplayHeaderView:)] != _isScrollUp &&_productTableView.isDecelerating) {
        [self.delegate willDisplayHeaderView:section];
    }
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didEndDisplayingHeaderView:)] && _isScrollUp &&_productTableView.isDecelerating) {
        [self.delegate didEndDisplayingHeaderView:section];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"_lastOffsetY : %f,scrollView.contentOffset.y : %f", _lastOffsetY, scrollView.contentOffset.y);
    _isScrollUp = _lastOffsetY < scrollView.contentOffset.y;
    _lastOffsetY = scrollView.contentOffset.y;
    NSLog(@"______lastOffsetY: %f", _lastOffsetY);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 实现 childViewVC  联动
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath {
    
    [self.productTableView selectRowAtIndexPath:([NSIndexPath indexPathForRow:0 inSection:indexPath.row]) animated:YES scrollPosition:UITableViewScrollPositionTop];
}


#pragma mark ----- Lazy 加载
- (UITableView *)productTableView{
    if (_productTableView == nil) {
        _productTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _productTableView.delegate = self;
        _productTableView.dataSource = self;
        _productTableView.showsVerticalScrollIndicator = NO;
        
    }
    return _productTableView;
}


@end
