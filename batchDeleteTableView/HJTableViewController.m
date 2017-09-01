//
//  HJTableViewController.m
//  batchDeleteTableView
//
//  Created by MrHuang on 17/9/1.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

#import "HJTableViewController.h"
#import "HJTableViewCell.h"

@interface HJTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong)NSMutableArray *sourceArray;


@end

@implementation HJTableViewController


- (NSMutableArray *)sourceArray{
    
    if (_sourceArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals.plist" ofType:nil];
        
        NSArray *file = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *dicArray = [NSMutableArray array];
        
        for (NSDictionary *dic in file) {
            SourceModel *sources = [SourceModel dealWithDict:dic];
            [dicArray addObject:sources];
        }
        
        _sourceArray = dicArray;
    }
    return _sourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 允许在编辑模式下进行多选操作
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
}


//批量选中
- (IBAction)multiOperation:(id)sender {
    
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}


//删除数据
- (IBAction)removeSources:(id)sender {
  
    // 获取被选中的行号
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    
   //便利所有的行号
    NSMutableArray *deleteArray = [NSMutableArray array];
    
    for (NSIndexPath *paths in indexPaths) {
        [deleteArray addObject:self.sourceArray[paths.row]];
    }

    // 删除被选中的行号模型数据
    [self.sourceArray removeObjectsInArray:deleteArray];
    
    [self.tableView reloadData];
    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return self.sourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HJTableViewCell *cell = [HJTableViewCell cellWithTableView:tableView];
    cell.sourceModel = self.sourceArray[indexPath.row];
    
  
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
 }
@end
