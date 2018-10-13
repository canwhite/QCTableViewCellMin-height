//
//  ViewController.m
//  QCBaseProjectForTest
//
//  Created by EricZhang on 2018/9/8.
//  Copyright © 2018年 BYX. All rights reserved.
//


/*
 我们的目的是上字下多图的tableViewCell的自适应高度
 */


#import "ViewController.h"
#import "QCTableViewCell.h"
#import "QCModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "QCTitleTableViewCell.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *modelsArray;
@property(nonatomic,strong) UITableView *tableView;
@end



@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化数据
    [self.view addSubview:self.tableView];
    [self createModelsWithCount:20];
    


    
}

- (void)createModelsWithCount:(NSInteger)count
{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"touxiang.jpg",
                                     @"touxiang.jpg",
                                     @"touxiang.jpg",
                                     @"touxiang.jpg",
                                     @"touxiang.jpg",
                                     ];
    
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的LaunchImage 时。然后等比例拉伸",
                           @"然后等比例拉伸到大屏。屏幕宽度返回 320否则在大屏上会显得字大",
                           @"长期处于这种模式下，否则在大屏上会显得字大，内容少这种情况下对界面不会",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任小。但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。"
                           ];
    
    for (int i = 0; i < count; i++) {
        
        
        int iconRandomIndex = arc4random_uniform(5);//获取 0到5-1的随机数
        int nameRandomIndex = arc4random_uniform(5);
        
        
        //添加标题
        QCModel *model = [QCModel new];
        model.title = textArray[nameRandomIndex];
        
        
        // 模拟“有或者无图片”
        int random = arc4random_uniform(100);//获取 0-99 的随机数
        
        
        if (random <= 30) {//有30%的概率是有图片
            NSMutableArray *temp = [NSMutableArray new];
            
            for (int i = 0; i < 3; i++) {
                int randomIndex = arc4random_uniform(5);
                NSString *text = iconImageNamesArray[randomIndex];
                [temp addObject:text];
            }
            
            model.imagePathsArray = [temp copy];//用了copy，把可变数组的内容给了不可变数组
            
            
        } else  if(random > 30 && random <= 60){
            //30%是一张图片
            model.imagePathsArray = @[iconImageNamesArray[iconRandomIndex]];
            
        }else{
            
            //剩下的40%是没有图片的
            model.imagePathsArray = @[];
            
        }
        
        [self.modelsArray addObject:model];
    }
    [self.tableView reloadData];
    
}


-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.frame = CGRectMake(0, 0, CKScreenW, CKScreenH);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[QCTableViewCell class] forCellReuseIdentifier:NSStringFromClass([QCTableViewCell class])];
        [_tableView registerClass:[QCTitleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([QCTitleTableViewCell class])];
        _tableView.separatorStyle = NO;

    }
    return _tableView;
    
}
#pragma mark - UITableViewDataSource

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.modelsArray.count;
    
    
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class currentClass = [QCTableViewCell class];
    QCTableViewCell *cell = nil;
    
    QCModel *model = self.modelsArray[indexPath.row];
    
    if (model.imagePathsArray.count ==0) {
        currentClass = [QCTitleTableViewCell class];
    }
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass) forIndexPath:indexPath];
    cell.model = model;
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    return [tableView cellHeightForIndexPath:indexPath model:self.detailModelArr[indexPath.row] keyPath:@"commentModel" cellClass:[WorkDetailTableViewCell class] contentViewWidth:self.view.frame.size.width];
    Class currentClass = [QCTableViewCell class];
    QCModel *model = self.modelsArray[indexPath.row];
    if (model.imagePathsArray.count ==0) {
        currentClass = [QCTitleTableViewCell class];
    }
    
    // 推荐使用此普通简化版方法（一步设置搞定高度自适应，性能好，易用性好）
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]];
    
    
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
