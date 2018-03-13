//
//  UIViewController+MHNavBarBGView.m
//  OceanhighRelation
//
//  Created by Oceanhigh on 16/9/21.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "UIViewController+MHNavBarBGView.h"
#import <objc/runtime.h>
#import "MHDefines.h"
#import "MHDefaultItemTitleBGView.h"

static const void *kNavBarBackgroundViewKey = &kNavBarBackgroundViewKey;
static const void *kNavBarBottomLineImgViewKey = &kNavBarBottomLineImgViewKey;
static const void *kStatusBarBackgroundViewKey = &kStatusBarBackgroundViewKey;
static const void *kLeftNavItemModelArrayKey = &kLeftNavItemModelArrayKey;
static const void *kRightNavItemModelArrayKey = &kRightNavItemModelArrayKey;
static const void *kTitleNavItemModelKey = &kTitleNavItemModelKey;
static const void *kHideNavBarShadowKey = &kHideNavBarShadowKey;
static const void *kHideNavBarBGViewKey = &kHideNavBarBGViewKey;

@implementation UIViewController (MHNavBarBGView)
@dynamic mhNavBarBackgroundView;
@dynamic mhNavBarBottomLineImgView;
@dynamic mhStatusBarBackgroundView;
@dynamic leftMHNavItemModelArray;
@dynamic rightMHNavItemModelArray;
@dynamic titleMHNavItemModel;
@dynamic hideMHNavBarShadow;
@dynamic hideMHNavBarBGView;


#pragma mark - 属性设置
//导航栏背景view
-(void)setNavBarBackgroundView:(UIView *)navBarBackgroundView
{
    objc_setAssociatedObject(self, kNavBarBackgroundViewKey, navBarBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//导航栏底线ImageView
-(void)setNavBarBottomLineImgView:(UIImageView *)navBarBottomLineImgView
{
    objc_setAssociatedObject(self, kNavBarBottomLineImgViewKey, navBarBottomLineImgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//状态栏背景View
-(void)setStatusBarBackgroundView:(UIView *)statusBarBackgroundView
{
    objc_setAssociatedObject(self, kStatusBarBackgroundViewKey, statusBarBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//导航栏左侧Items数组
-(void)setLeftNavItemModelArray:(NSArray<MHNavBarItemModel *> *)leftNavItemModelArray
{
    objc_setAssociatedObject(self, kLeftNavItemModelArrayKey, leftNavItemModelArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.navigationItem.leftBarButtonItems = [self buildNavItemViewWithModelArray:leftNavItemModelArray withItemType:MHNavBarItemTypeLeft];
    
    //设置点击回调监听
    [self setupNavBarItemCallback];
    
    [self updateNavbarItemFrame];
}

//导航栏右侧Items数组
-(void)setRightNavItemModelArray:(NSArray<MHNavBarItemModel *> *)rightNavItemModelArray
{
    objc_setAssociatedObject(self, kRightNavItemModelArrayKey, rightNavItemModelArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.navigationItem.rightBarButtonItems = [self buildNavItemViewWithModelArray:rightNavItemModelArray withItemType:MHNavBarItemTypeRight];
    //设置点击回调监听
    [self setupNavBarItemCallback];
    
    [self updateNavbarItemFrame];
}

//导航栏Title Items数组
-(void)setTitleNavItemModel:(MHNavBarItemModel *)titleNavItemModel
{
    objc_setAssociatedObject(self, kTitleNavItemModelKey, titleNavItemModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //设置item数据mode其他属性
    titleNavItemModel.navBarItemType = MHNavBarItemTypeTitle;
    //生成itemView
    MHSuperNavItemBGView *titleItemBGView = [self createNavItemBGViewWithNavItemModel:titleNavItemModel];
    titleItemBGView.navBarItemModel = titleNavItemModel;
    self.navigationItem.titleView = titleItemBGView;
    
    [self setupNavBarItemCallback];
    
    [self updateNavbarItemFrame];
}

//隐藏/显示导航栏底部线条
-(void)setHideNavBarShadow:(BOOL)hideNavBarShadow
{
    objc_setAssociatedObject(self, kHideNavBarShadowKey, @(hideNavBarShadow), OBJC_ASSOCIATION_ASSIGN);
    self.navBarBottomLineImgView.hidden = hideNavBarShadow;
}

//隐藏/显示导航栏底部线条
-(void)setHideNavBarBGView:(BOOL)hideNavBarBGView
{
    objc_setAssociatedObject(self, kHideNavBarBGViewKey, @(hideNavBarBGView), OBJC_ASSOCIATION_ASSIGN);
    
    self.navBarBackgroundView.hidden = hideNavBarBGView;
    self.statusBarBackgroundView.hidden = hideNavBarBGView;
}

#pragma mark - 属性获取
-(UIView *)navBarBackgroundView
{
    if (!objc_getAssociatedObject(self, kNavBarBackgroundViewKey))
    {
        //新建
        CGFloat navBarY = kIPhoneX?44:20;
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, navBarY, kSCREEN_WIDTH, 44)];
        tempView.backgroundColor = kCOLOR_Clear;
        [self.view addSubview:tempView];
        self.navBarBackgroundView = tempView;
    }
    return objc_getAssociatedObject(self, kNavBarBackgroundViewKey);
}

-(UIImageView *)navBarBottomLineImgView
{
    if (!objc_getAssociatedObject(self, kNavBarBottomLineImgViewKey))
    {
        //新建
        CGFloat navBarHeight = kIPhoneX?88:64;
        UIImageView *tempImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, navBarHeight, kSCREEN_WIDTH, 1)];
        tempImgView.backgroundColor = kCOLOR_Clear;
        [self.view addSubview:tempImgView];
        self.navBarBottomLineImgView = tempImgView;
    }
    return objc_getAssociatedObject(self, kNavBarBottomLineImgViewKey);
}

-(UIView *)statusBarBackgroundView
{
    if (!objc_getAssociatedObject(self, kStatusBarBackgroundViewKey))
    {
        //新建
        CGFloat statusBarHeight = kIPhoneX?44:20;
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, statusBarHeight)];
        tempView.backgroundColor = kCOLOR_Clear;
        [self.view addSubview:tempView];
        self.statusBarBackgroundView = tempView;
    }
    
    return objc_getAssociatedObject(self, kStatusBarBackgroundViewKey);
}

-(NSArray<MHNavBarItemModel *> *)leftNavItemModelArray
{
    return objc_getAssociatedObject(self, kLeftNavItemModelArrayKey);
}

-(NSArray<MHNavBarItemModel *> *)rightNavItemModelArray
{
    return objc_getAssociatedObject(self, kRightNavItemModelArrayKey);
}

-(MHNavBarItemModel *)titleNavItemModel
{
    return objc_getAssociatedObject(self, kTitleNavItemModelKey);
}

#pragma mark - 初始化
//初始化导航栏
-(void)setupDefaultNavItems
{
    //背景view及颜色
    self.navBarBackgroundView.backgroundColor = kCOLOR_White;
    self.hideNavBarShadow = NO;
    //背景view底部线条颜色
//    self.navBarBottomLineImgView.backgroundColor = kCOLOR_GRAY_EEEEEE;
    self.navBarBottomLineImgView.backgroundColor = kCOLOR_Clear;
    //状态栏设置
    self.statusBarBackgroundView.backgroundColor = kCOLOR_White;
    //title
    self.titleNavItemModel = [[MHNavBarItemModel alloc]initNavBarModelWithItemText:self.title andItemImage:nil withNibName:nil];
    self.titleNavItemModel.textFont = kFONT_Medium(15.f);
    
    //item
    if (self.navigationController.viewControllers.count != 1)
    {
        //非顶层界面
        //左侧默认
        self.leftNavItemModelArray = @[[MHNavBarItemModel navItemModelOnlyWithImage:kIMG_GET(@"")  withNibName:nil]];
    }
}

-(void)updateNavbarItemFrame
{
    //计算两边item总长度
    UIView *leftLastView = ((UIBarButtonItem*)self.navigationItem.leftBarButtonItems.lastObject).customView;
    CGFloat leftItemWidth = leftLastView?(leftLastView.frame.size.width + leftLastView.frame.origin.x):0;
    UIView *rightFirstView = ((UIBarButtonItem*)self.navigationItem.rightBarButtonItems.lastObject).customView;
    CGFloat rightItemWidth = rightFirstView?(kSCREEN_WIDTH - rightFirstView.frame.origin.x):0;
    
    //对比长度
    CGFloat titleWidth = 0;
    CGFloat x = 0.f;
    if (leftItemWidth >= rightItemWidth)
    {
        //左边为准
        titleWidth = kSCREEN_WIDTH - leftItemWidth*2;
        x = leftItemWidth;
    }
    else
    {
        //右边为准
        titleWidth = kSCREEN_WIDTH - rightItemWidth*2;
        x = rightItemWidth;
    }
    
    //刷新titleview
    MHSuperNavItemBGView *titleItemBGView = [self getNavItemBGViewWithItemType:MHNavBarItemTypeTitle];
    titleItemBGView.adjustFrame = CGRectMake(x, titleItemBGView.frame.origin.y, titleWidth, titleItemBGView.frame.size.height);
}

//设置按钮数组对应的view
-(NSArray*)buildNavItemViewWithModelArray:(NSArray<MHNavBarItemModel*> *)modelArray withItemType:(MHNavBarItemType)itemType
{
    NSMutableArray *listItemViewArray = [[NSMutableArray alloc]init];
    int index = 0;
    for (MHNavBarItemModel *navBarItemModel in modelArray)
    {
        //设置item数据model其他属性
        navBarItemModel.tag = index;
        navBarItemModel.navBarItemType = itemType;
        //生成itemView
        MHSuperNavItemBGView *itemBGView = [self createNavItemBGViewWithNavItemModel:navBarItemModel];
        itemBGView.navBarItemModel = navBarItemModel;
        UIBarButtonItem *barBtnView = [[UIBarButtonItem alloc]initWithCustomView:itemBGView];
        [listItemViewArray addObject:barBtnView];
        index++;
    }
    
    
    
    return listItemViewArray;
}

//点击回调设置
-(void)setupNavBarItemCallback
{
    kWeak(weakSelf)
    for (UIBarButtonItem *leftBarBtnItem in self.navigationItem.leftBarButtonItems)
    {
        MHSuperNavItemBGView *itemBGView = leftBarBtnItem.customView;
        [itemBGView setCallbackBtnClick:^(id value) {
            //点击回调
            [weakSelf btnLeftAction:value];
        }];
    }
    
    for (UIBarButtonItem *rightBarBtnItem in self.navigationItem.rightBarButtonItems)
    {
        MHSuperNavItemBGView *itemBGView = rightBarBtnItem.customView;
        [itemBGView setCallbackBtnClick:^(id value) {
            //点击回调
            [weakSelf btnRightAction:value];
        }];
    }
    
    MHSuperNavItemBGView *itemBGView = (MHSuperNavItemBGView*)self.navigationItem.titleView;
    [itemBGView setCallbackBtnClick:^(id value){
        //点击回调
        [weakSelf btnTitleAction:value];
    }];
}

//根据nibName生成nib对象
-(id)createNavItemBGViewWithNavItemModel:(MHNavBarItemModel*)itemModel
{
    NSString *nibName = itemModel.nibName;
    MHNavBarItemType itemType = itemModel.navBarItemType;
    
    if (itemType == MHNavBarItemTypeNone)
    {
        //没有设置类型
        return nil;
    }
    else
    {
        BOOL isEmpty = !nibName || [nibName isEqualToString:@""];
        Class navItemBGViewClass = NSClassFromString(isEmpty?(itemType==MHNavBarItemTypeTitle?[MHDefaultItemTitleBGView view_ClassName]:[MHDefaultItemTitleBGView view_ClassName]):nibName);
        id navItemBGView = [navItemBGViewClass createNavItemViewFromXIB];
        
        return navItemBGView;
    }
}

#pragma mark - item设置
#pragma mark 导航栏item获取
//获取指定位置的导航栏item bgview
-(MHSuperNavItemBGView *)getNavItemBGViewWithTag:(NSInteger)tag andItemType:(MHNavBarItemType)itemType
{
    if (itemType == MHNavBarItemTypeRight || itemType == MHNavBarItemTypeLeft)
    {
        //右侧按钮
        NSArray *barBtnItemsArray = itemType == MHNavBarItemTypeLeft? self.navigationItem.leftBarButtonItems:self.navigationItem.rightBarButtonItems;
        for (UIBarButtonItem *tempBarBtnItem in barBtnItemsArray)
        {
            MHSuperNavItemBGView *tempNavItemBGView = tempBarBtnItem.customView;
            if (tempNavItemBGView.navBarItemModel.tag == tag)
            {
                //一致
                return tempNavItemBGView;
            }
        }
    }
    else
    {
        //title
        return (MHSuperNavItemBGView*)self.navigationItem.titleView;
    }
    
    return nil;
}

//获取第1个导航栏item
-(MHSuperNavItemBGView *)getNavItemBGViewWithItemType:(MHNavBarItemType)itemType
{
    return [self getNavItemBGViewWithTag:0 andItemType:itemType];
}

#pragma mark 导航栏item对应数据model获取
-(MHNavBarItemModel *)getNavBarItemModelWithTag:(NSInteger)tag andItemType:(MHNavBarItemType)itemType
{
    NSArray *itemModelArray = itemType == MHNavBarItemTypeLeft? self.leftNavItemModelArray:self.rightNavItemModelArray;
    
    for (MHNavBarItemModel *tempNavBarItemModel in itemModelArray)
    {
        if (tempNavBarItemModel.tag == tag)
        {
            return tempNavBarItemModel;
        }
    }
    
    return nil;
}

//获取第1个导航栏item数据model
-(MHNavBarItemModel *)getNavBarItemModelWithItemType:(MHNavBarItemType)itemType
{
    return [self getNavBarItemModelWithTag:0 andItemType:itemType];
}

#pragma mark 导航栏item功能设置
//导航栏指定按钮是否隐藏
-(void)hideNavItem:(BOOL)shouldHide withTag:(NSInteger)tag andItemType:(MHNavBarItemType)itemType
{
    MHSuperNavItemBGView *navItemBGView = [self getNavItemBGViewWithTag:tag andItemType:itemType];
    navItemBGView.hidden = shouldHide;
}

-(void)hideNavItem:(BOOL)shouldHide withItemType:(MHNavBarItemType)itemType
{
    MHSuperNavItemBGView *navItemBGView = [self getNavItemBGViewWithItemType:itemType];
    navItemBGView.hidden = shouldHide;
}

//导航栏指定按钮是否可用
-(void)enableNavItem:(BOOL)isEnable withTag:(NSInteger)tag andItemType:(MHNavBarItemType)itemType
{
    MHSuperNavItemBGView *navItemBGView = [self getNavItemBGViewWithTag:tag andItemType:itemType];
    navItemBGView.userInteractionEnabled = NO;
}

-(void)enableNavItem:(BOOL)isEnable withItemType:(MHNavBarItemType)itemType
{
    MHSuperNavItemBGView *navItemBGView = [self getNavItemBGViewWithItemType:itemType];
    navItemBGView.userInteractionEnabled = isEnable;
}


//显示/隐藏导航栏
-(void)hideNavBar:(BOOL)shouldHide animated:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:shouldHide animated:animated];
}

//点击左边按钮事件
-(void)btnLeftAction:(MHNavBarItemModel*)navBarItemModel
{
    //返回
    NSLog(@"左侧按钮点击");
    [self returnToLastVC];
}

//点击右边按钮事件
-(void)btnRightAction:(MHNavBarItemModel*)navBarItemModel
{
    NSLog(@"右侧按钮点击");
}

-(void)btnTitleAction:(MHNavBarItemModel*)navBarItemModel
{
    NSLog(@"点击title");
}

#pragma 导航栏设置 end

//返回上级vc
-(void)returnToLastVC
{
    if (self.navigationController.viewControllers.count == 1)
    {
        //最顶层vc
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        //非最顶层
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
