//
//  Define.h
//  QCBaseProjectForTest
//
//  Created by EricZhang on 2018/9/8.
//  Copyright © 2018年 BYX. All rights reserved.
//

#ifndef Define_h
#define Define_h
#import "BlocksKit/BlocksKit.h"
#import "BlocksKit/BlocksKit+UIKit.h"
#import <libextobjc/EXTScope.h>
#import "SVProgressHUD.h"
#import "UIView+SDAutoLayout.h"
#pragma mark - 字体和颜色
#define FontHeiti(fontSize) [UIFont fontWithName:@"STHeitiSC-Light" size:(fontSize)]




//颜色
static inline UIColor *RGBA(int R, int G, int B, double A) {
    return [UIColor colorWithRed: R/255.0 green: G/255.0 blue: B/255.0 alpha: A];
}

static inline UIColor *HexColorA(int v, double A) {
    return RGBA((double)((v&0xff0000)>>16), (double)((v&0xff00)>>8), (double)(v&0xff), A);
}

static inline UIColor *HexColor(int v) {
    return RGBA((double)((v&0xff0000)>>16), (double)((v&0xff00)>>8), (double)(v&0xff), 1.0f);
}


#pragma mark - 单例的时候使用

#define NONullString(key)       [key length] > 0 ? key : @""
#define SINGLETON(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \


#pragma mark - 屏宽和屏高

#define CKScreenW ([UIScreen mainScreen].bounds.size.width)
#define CKScreenH ([UIScreen mainScreen].bounds.size.height)

#endif /* Define_h */
