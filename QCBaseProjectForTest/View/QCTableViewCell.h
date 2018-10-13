//
//  QCTableViewCell.h
//  QCBaseProjectForTest
//
//  Created by EricZhang on 2018/10/12.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCModel;

@interface QCTableViewCell : UITableViewCell

@property(nonatomic,strong) QCModel *model;

@end


