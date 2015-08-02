//
//  XActionSheet.m
//  Demo2
//
//  Created by xlx on 15/7/29.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "XActionSheet.h"

@interface XActionSheet ()
{
    CGFloat width;
    CGFloat height;
}
@end

@implementation XActionSheet
- (id)init{
    self = [super init];
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.view.backgroundColor   = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    _btnArray                   = [[NSMutableArray alloc]init];
    width                       = self.view.bounds.size.width;
    height                      = self.view.bounds.size.height;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tap{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}
/**
 *  添加取消按钮
 */
-(void)addCancelButton:(NSString *)Title{
    if (!_layView) {
        _layView = [[UIView alloc]initWithFrame:CGRectMake(width * 0.1,height - ( _btnArray.count * 40 + 40 + 30), width * 0.8,  _btnArray.count * 40 + 40 + 20)];
        _layView.layer.cornerRadius = 5;
        _layView.alpha = 0.8;
        _layView.layer.masksToBounds = true;
        [self.view addSubview:_layView];
    }else{
        CGFloat nowHeight = _layView.bounds.size.height;
        nowHeight += 50;
        _layView.frame = CGRectMake(width * 0.1, height - nowHeight, width * 0.8, nowHeight);
    }
    if (!_CancelButton) {
        _CancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40 * _btnArray.count + 10, width * 0.8, 40)];
        [_CancelButton setTitle:Title forState:normal];
        _CancelButton.layer.cornerRadius = 5;
        _CancelButton.layer.masksToBounds = true;
        _CancelButton.backgroundColor = [UIColor brownColor];
        [_CancelButton addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
        [_layView addSubview:_CancelButton];
    }else{
        [_CancelButton setTitle:Title forState:normal];
    }
}
/**
 *  添加按钮
 */
-(void)addButtonwithTitle:(NSString *)Title{
    if (!_layView) {
        _layView = [[UIView alloc]initWithFrame:CGRectMake(width * 0.1,height - ( 40 + 10), width * 0.8,  _btnArray.count * 40 + 40 + 20)];
        _layView.layer.cornerRadius = 5;
        _layView.alpha = 0.8;
        _layView.layer.masksToBounds = true;
        [self.view addSubview:_layView];
    }else{
        CGFloat nowHeight = _layView.bounds.size.height;
        nowHeight += 40;
        _layView.frame = CGRectMake(width * 0.1, height - nowHeight, width * 0.8, nowHeight);
    }
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, _btnArray.count * 40, width * 0.8, 39)];
    btn.tag = _btnArray.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor colorWithRed:(CGFloat)52/255 green:(CGFloat)170/255 blue:(CGFloat)135/255 alpha:1];
    [btn setTitle:Title forState:normal];
    [_btnArray addObject:btn];
    [_layView addSubview:btn];
    
    CGFloat cancelY = _CancelButton.frame.origin.y;
    _CancelButton.frame = CGRectMake(0, cancelY + 40, width * 0.8, 40);
}
/**
 *  按钮点击动作
 */
- (void)buttonClick:(id)sender{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
    UIButton *btn = (UIButton *)sender;
    [_delegate buttonClick:btn.tag];
}


@end
