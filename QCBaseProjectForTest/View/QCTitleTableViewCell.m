//
//  QCTitleTableViewCell.m
//  QCBaseProjectForTest
//
//  Created by EricZhang on 2018/10/13.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import "QCTitleTableViewCell.h"

@implementation QCTitleTableViewCell{
    UILabel *_titleLabel;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    
    
    /*
     子控件的初始化
     */
    
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor darkGrayColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.numberOfLines = 0;
    
    
    
    CGFloat margin = 15;
    UIView *contentView = self.contentView;
    
    
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);//高度自适应
    
    
    //sdautoLayout的收底工作
    [self setupAutoHeightWithBottomView:_titleLabel bottomMargin:margin];
    
    
    
}


- (void)setModel:(QCModel *)model
{
    
    _model = model;
    //我们用到了title
    _titleLabel.text = model.title;
    
}



@end
