//
//  QCTableViewCell.m
//  QCBaseProjectForTest
//
//  Created by EricZhang on 2018/10/12.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import "QCTableViewCell.h"
#import "QCModel.h"


@implementation QCTableViewCell{
    UILabel *_titleLabel;
    NSArray *_imageViewsArray;
    
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
    
    
    //添加上三个imageView，初始化
    UIImageView * imageView0 = [UIImageView new];
    [self.contentView addSubview:imageView0];
    
    UIImageView * imageView1 = [UIImageView new];
    [self.contentView addSubview:imageView1];
    
    UIImageView * imageView2 = [UIImageView new];
    [self.contentView addSubview:imageView2];
    


    
    
    
    
    
    /*
     子控件的布局
     */
    
    //将imageView添加到同一书组里
    _imageViewsArray = @[imageView0, imageView1, imageView2];
    // 通过数组，将imageView设置为设置等宽的子view
    self.contentView.sd_equalWidthSubviews = _imageViewsArray;
    
    
    
    CGFloat margin = 15;
    UIView *contentView = self.contentView;
    
    
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);//高度自适应
    
    imageView0.sd_layout
    .topSpaceToView(_titleLabel, margin)
    .leftSpaceToView(contentView, margin)
    .autoHeightRatio(0.8);//高宽比为0.8，宽度再上边已经设置了
    
    imageView1.sd_layout
    .topSpaceToView(_titleLabel, margin)
    .leftSpaceToView(imageView0, margin)
    .autoHeightRatio(0.8);
    
    imageView2.sd_layout
    .topSpaceToView(_titleLabel, margin)
    .leftSpaceToView(imageView1, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0.8);
    
    
    
    //sdautoLayout的收底工作
    [self setupAutoHeightWithBottomView:imageView0 bottomMargin:margin];
}


- (void)setModel:(QCModel *)model
{
    //害怕缓存问题，而三个imageView是一直存在的所以一开始都先置为白板，然后根据具体的数据，刷新白板
    for (UIImageView *imageView in _imageViewsArray) {
        [imageView setImage:[UIImage imageNamed:@"wuwuwu"]];
    }
    
    _model = model;
    //我们用到了title
    _titleLabel.text = model.title;

    
    //通过遍历data数组    刷新白板
    [model.imagePathsArray enumerateObjectsUsingBlock:^(NSString * _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imageView = _imageViewsArray[idx];
        imageView.image = [UIImage imageNamed:str];

    }];


    
}





@end
