//
//  UIViewController+MHNavBarBGView.h
//  OceanhighRelation
//
//  Created by Oceanhigh on 16/9/21.
//  Copyright © 2016年 MH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHNavBarItemModel.h"
#import "MHSuperNavItemBGView.h"

@interface UIViewController (MHNavBarBGView)

#pragma mark - 属性
//view
@property (nonatomic, strong, readonly) UIView *mhNavBarBackgroundView;/**<导航栏背景view*/
@property (nonatomic, strong, readonly) UIImageView *mhNavBarBottomLineImgView;/**<导航栏底部线条*/
@property (nonatomic, strong, readonly) UIView *mhStatusBarBackgroundView;/**<状态栏背景view*/
@property (nonatomic, assign) BOOL hideMHNavBarShadow;/**<是否隐藏导航栏底部阴影*/
@property (nonatomic, assign) BOOL hideMHNavBarBGView;/**<是否隐藏导航栏底部背景*/
//数据model
@property (nonatomic, copy) NSArray<MHNavBarItemModel *> *leftMHNavItemModelArray;
@property (nonatomic, copy) NSArray<MHNavBarItemModel *> *rightMHNavItemModelArray;
@property (nonatomic, strong) MHNavBarItemModel *titleMHNavItemModel;

#pragma mark - 初始化

/**
 *  初始化导航栏
 */
-(void)setupDefaultNavItems;

/**
 *  更新导航栏itemFrame
 */
-(void)updateNavbarItemFrame;

/**
 *  初始化点击回调设置
 */
-(void)setupNavBarItemCallback;

#pragma mark - item设置
#pragma mark 导航栏item获取
//==========================>获取指定位置的导航栏item<===============================
//=>需要更改导航栏item子类view的属性时，可先通过下面的方法获取导航栏item【注意转换成对应子类】<=
/**
 *  获取指定位置的导航栏item bgview
 
 @param tag      所需获取的item tag
 @param itemType 所需获取的item所属位置(右侧/左侧/title)
 
 @return 导航栏item bgview
 */
-(MHSuperNavItemBGView *)getNavItemBGViewWithTag:(NSInteger)tag andItemType:(MHNavBarItemType)itemType;
-(MHSuperNavItemBGView *)getNavItemBGViewWithItemType:(MHNavBarItemType)itemType;

//<--------------------------------------end----------------------------------------

#pragma mark 导航栏item对应数据model获取
//==========================>获取指定位置的导航栏item<===============================
//====>需要更改导航栏item文字或图片内容时，可通过下面的方法获取导航栏item数据model进行更改<====
/**
  获取指定的导航栏item数据model

 @param tag      model tag
 @param itemType model对应按钮所属位置

 @return 导航栏item数据model
 */
-(MHNavBarItemModel *)getNavBarItemModelWithTag:(NSInteger)tag andItemType:(MHNavBarItemType)itemType;
-(MHNavBarItemModel *)getNavBarItemModelWithItemType:(MHNavBarItemType)itemType;

//<--------------------------------------end----------------------------------------

#pragma mark 导航栏item功能设置
/**
 *  导航栏指定按钮是否隐藏

 @param shouldHide 是否隐藏
 @param tag        按钮tag
 @param itemType   按钮所属位置
 */
-(void)hideNavItem:(BOOL)shouldHide withTag:(NSInteger)tag andItemType:(MHNavBarItemType)itemType;
-(void)hideNavItem:(BOOL)shouldHide withItemType:(MHNavBarItemType)itemType;

/**
 *  导航栏指定按钮是否可用

 @param isEnable 按钮是否可用
 @param tag      按钮tag
 @param itemType 按钮所属位置
 */
-(void)enableNavItem:(BOOL)isEnable withTag:(NSInteger)tag andItemType:(MHNavBarItemType)itemType;
-(void)enableNavItem:(BOOL)isEnable withItemType:(MHNavBarItemType)itemType;

/**
 *  显示/隐藏导航栏

 @param shouldHide 是否隐藏导航栏
 @param animated   是否执行动画
 */
-(void)hideNavBar:(BOOL)shouldHide animated:(BOOL)animated;

#pragma mark - 点击事件
/**
 *  点击左边按钮事件
 
 @param navBarItemModel 导航栏model
 */
-(void)btnLeftAction:(MHNavBarItemModel*)navBarItemModel;

/**
 *  点击右边按钮事件
 
 @param navBarItemModel 导航栏model
 */
-(void)btnRightAction:(MHNavBarItemModel*)navBarItemModel;

/**
 *  点击导航栏标题按钮事件

 @param navBarItemModel 导航栏item model
 */
-(void)btnTitleAction:(MHNavBarItemModel*)navBarItemModel;


/**
 *  返回上级vc
 */
-(void)returnToLastVC;

@end
