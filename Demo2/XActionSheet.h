//
//  XActionSheet.h
//  Demo2
//
//  Created by xlx on 15/7/29.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XActionSheet;
@protocol XActionSheetDelegate <NSObject>
@optional
-(void)buttonClick:(NSInteger)index;

@end
@interface XActionSheet : UIViewController

- (void)addCancelButton:(NSString *)Title;
- (void)addButtonwithTitle:(NSString *)Title;

@property (nonatomic, strong) UIView *layView;
@property (nonatomic, strong) UIButton *CancelButton;
@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, assign) id<XActionSheetDelegate>delegate;
@end
