//
//  MMCategoryController.m
//  TableLinkageEffect
//
//  Created by Mortimey on 16/6/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMCategoryController.h"
#import "MMProduceController.h"

@interface MMCategoryController ()<UITableViewDataSource,UITableViewDelegate,MMProduceControllerDelegate>

@property (nonatomic, strong) NSArray *cagegoryArray;
@property (nonatomic, strong) UITableView *cagegoryTabelView;
@property (nonatomic, strong) MMProduceController *produceVC;
@property (nonatomic, strong) NSString *name;





@end

@implementation MMCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LinkageEffectTableView";
    [self.view addSubview:self.cagegoryTabelView];
    [self initUI];
    [self initData];
}

// MMProduceController 作为 MMCategoryController 实现tableView 联动效果
- (void)initUI{
    _produceVC = [[MMProduceController alloc] init];
    _produceVC.delegate = self;
    [self addChildViewController:_produceVC];
    [self.view addSubview:_produceVC.view];

}
// 初始化数据源
- (void)initData{
    if (_cagegoryArray == nil) {
        NSArray  *numberArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            NSString *tmpStr = [NSString stringWithFormat:@"第%@类", numberArray[i]];
            [tmpArr addObject:tmpStr];
        }
        _cagegoryArray = tmpArr;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _cagegoryArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [_cagegoryArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_produceVC) {
        [_produceVC scrollToSelectedIndexPath:indexPath];
    }
}


#pragma mark - MMProduceControllerDelegate
- (void)willDisplayHeaderView:(NSInteger)section {
    
    [self.cagegoryTabelView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didEndDisplayingHeaderView:(NSInteger)section {
    
    [self.cagegoryTabelView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (UITableView *)cagegoryTabelView{
    if (_cagegoryTabelView == nil) {
        _cagegoryTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.25, self.view.frame.size.height) style:UITableViewStylePlain];
        _cagegoryTabelView.delegate = self;
        _cagegoryTabelView.dataSource = self;
        _cagegoryTabelView.showsVerticalScrollIndicator = NO;
        
    }
    return _cagegoryTabelView;
}

@end
