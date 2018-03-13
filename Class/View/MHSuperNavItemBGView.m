//
//  MHSuperNavItemBGView.m
//  MHTestCustomNavBar
//
//  Created by Oceanhigh on 16/9/20.
//  Copyright © 2016年 MHX. All rights reserved.
//

#import "MHSuperNavItemBGView.h"
#import "MHDefines.h"

@implementation MHSuperNavItemBGView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createNavItemViewFromXIB
{
    id view;
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:nil];
//    NSAssert((nib && (nib.count > 0)), @" ! can not find nib file.\n\nxib file name is not the same as class name?\n");
    if (nib.count > 0)
    {
        view = [nib objectAtIndex:0];
    }
    else
    {
        return nil;
    }
    
    return view;
}

-(void)setCallbackBtnClick:(BtnClickCallback)callbackBtnClick
{
    _callbackBtnClick = [callbackBtnClick copy];
}

//-(void)setCallbackBtnClickAction:(BtnClickCallback)result
//{
//    _callbackBtnClick = result;
//}

-(void)setNavBarItemModel:(MHNavBarItemModel *)navBarItemModel
{
    _navBarItemModel = navBarItemModel;
    
    kWeak(weakSelf)
    [_navBarItemModel setCallbackModelReloadAction:^{
        //刷新view
        [weakSelf reloadNavItem];
    }];
    
    [self reloadNavItem];
}

-(void)updateFrame
{
    
}

-(void)reloadNavItem
{
    
}

-(void)resizeFrame:(CGRect)toFrame
{
    self.frame = toFrame;
}


//返回viewClassName
+ (NSString *)view_ClassName
{
    return NSStringFromClass([self class]);
}

@end
