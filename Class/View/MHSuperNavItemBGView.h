//
//  MHSuperNavItemBGView.h
//  MHTestCustomNavBar
//
//  Created by Oceanhigh on 16/9/20.
//  Copyright © 2016年 MHX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHNavBarItemModel.h"

typedef void(^BtnClickCallback)(id value);

@interface MHSuperNavItemBGView : UIView

@property (nonatomic, copy) BtnClickCallback callbackBtnClick;

@property (nonatomic, strong) MHNavBarItemModel *navBarItemModel;

@property (nonatomic, assign) CGRect adjustFrame;


//-(void)setCallbackBtnClickAction:(BtnClickCallback)result;

-(void)updateFrame;

-(void)reloadNavItem;

+ (instancetype)createNavItemViewFromXIB;

-(void)resizeFrame:(CGRect)toFrame;


/**
 *  viewClassName
 
 @return model Class 字符串
 */
+ (NSString *)view_ClassName;

@end
