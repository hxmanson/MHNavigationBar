//
//  MHNavBarItemModel.m
//  MHTestCustomNavBar
//
//  Created by Oceanhigh on 16/9/20.
//  Copyright © 2016年 MHX. All rights reserved.
//

#import "MHNavBarItemModel.h"
#import "MHDefines.h"

@implementation MHNavBarItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        //数据初始化
    }
    return self;
}

#pragma mark - 初始化
//导航栏内容部分初始化(文字+图片)
-(instancetype)initNavBarModelWithItemText:(NSString*)itemText andItemImage:(UIImage*)itemImage withNibName:(NSString*)nibName
{
    self = [super init];
    if (self) {
        //数据初始化
        _itemText = itemText;
        _itemImg = itemImage;
        _nibName = nibName;
        
        self.textColor = kCOLOR_Black;
        self.textFont = kFONT_Regular(15.);
        self.textAlignment = NSTextAlignmentLeft;
        
    }
    return self;
}

#pragma mark 便捷初始化
//(便捷)导航栏【完整内容】数据model初始化
+ (instancetype)navItemModelWithText:(NSString *)text andImage:(UIImage *)image withNibName:(NSString*)nibName
{
    return [[self alloc]initNavBarModelWithItemText:text andItemImage:image withNibName:nibName];
}

//(便捷)导航栏【仅文字内容】数据model初始化
+(instancetype)navItemModelOnlyWithText:(NSString *)text withNibName:(NSString*)nibName
{
    return [self navItemModelWithText:text andImage:nil withNibName:nibName];
}

//(便捷)导航栏【仅图片内容】数据model初始化
+(instancetype)navItemModelOnlyWithImage:(UIImage *)image withNibName:(NSString*)nibName
{
    return [self navItemModelWithText:nil andImage:image withNibName:nibName];
}

#pragma mark - 回调设置
-(void)setCallbackModelReloadAction:(ModelReloadCallback)result
{
    _callbackModelReload = result;
}

#pragma mark - 数据设置
-(void)setItemText:(NSString *)itemText
{
    _itemText = itemText;
    
    [self reloadViewByModel];
}

-(void)setItemImg:(UIImage *)itemImg
{
    _itemImg = itemImg;
    
    [self reloadViewByModel];
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    
    [self reloadViewByModel];
}

-(void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    
    [self reloadViewByModel];
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    
    [self reloadViewByModel];
}



//-(void)setNavBarItemType:(MHNavBarItemType)navBarItemType
//{
//    _navBarItemType = navBarItemType;
//    
//    [self reloadViewByModel];
//}


-(void)reloadViewByModel
{
    if (self.callbackModelReload)
    {
        self.callbackModelReload();
    }
}
#pragma end


//获取当前导航栏item内容格式类型
-(MHNavItemStyle)navItemStyle
{
    if (_itemImg && (_itemText && ![_itemText isEqualToString:@""]))
    {
        //全部有值
        _navItemStyle = MHNavItemStyleImgText;
    }
    else if (_itemImg)
    {
        //只有图片有值
        _navItemStyle = MHNavItemStyleImg;
    }
    else if (_itemText && ![_itemText isEqualToString:@""])
    {
        //只有文字
        _navItemStyle = MHNavItemStyleText;
    }
    else
    {
        //空
        _navItemStyle = MHNavItemStyleNone;
    }
    
    return _navItemStyle;
}

@end
