//
//  LCLScrollView.h
//  LCLScrollView
//
//  Created by lichanglai on 2018/3/31.
//  Copyright © 2018年 sankai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCLScrollView : UIView
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, assign) BOOL isAutoScroll;
- (void)build;
@end
