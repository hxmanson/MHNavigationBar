//
//  MHNavBarItemModel.h
//  MHTestCustomNavBar
//
//  Created by Oceanhigh on 16/9/20.
//  Copyright © 2016年 MHX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MHNavItemStyleNone,/**<空类型*/
    MHNavItemStyleImgText,/**<图片+文字类型*/
    MHNavItemStyleText,/**<纯文字类型*/
    MHNavItemStyleImg,/**<纯图片类型*/
} MHNavItemStyle;/**<导航栏item内容格式类型*/

typedef enum : NSUInteger {
    MHNavBarItemTypeNone,/**<无类型*/
    MHNavBarItemTypeLeft, /**<导航栏左侧item*/
    MHNavBarItemTypeRight,/**<导航栏右侧item*/
    MHNavBarItemTypeTitle,/**<导航栏title*/
} MHNavBarItemType;/**<导航栏item所属位置类型*/

typedef void(^ModelReloadCallback)(void);

@interface MHNavBarItemModel : NSObject

@property (nonatomic, copy) NSString *itemText;
@property (nonatomic, strong) UIImage *itemImg;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) MHNavItemStyle navItemStyle;
@property (nonatomic, assign) MHNavBarItemType navBarItemType;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, copy) NSString *nibName;

@property (nonatomic, copy) ModelReloadCallback callbackModelReload;

-(void)setCallbackModelReloadAction:(ModelReloadCallback)result;



/**
 *  重新载入数据model
 */
-(void)reloadViewByModel;
/**
 *  导航栏内容完全初始化

 @param itemText       导航栏item文字
 @param itemImage      导航栏item图片
 @param navBarItemType 导航栏item类型

 @return self(MHNavBarItemModel)
 */
-(instancetype)initNavBarModelWithItemText:(NSString*)itemText andItemImage:(UIImage*)itemImage withNibName:(NSString*)nibName;

#pragma mark - 便捷初始化
/**
 *  (便捷)导航栏【完整内容】数据model初始化

 @param text     文字内容
 @param image    图片内容
 @param itemType item所属位置类型(左边按钮/右边按钮/title)
 
 @return 导航栏item model
 */
+(instancetype)navItemModelWithText:(NSString*)text andImage:(UIImage*)image withNibName:(NSString*)nibName;

/**
 *  (便捷)导航栏【仅文字内容】数据model初始化

 @param text     文字内容
 @param itemType item所属位置类型(左边按钮/右边按钮/title)

 @return 导航栏item model
 */
+(instancetype)navItemModelOnlyWithText:(NSString*)text withNibName:(NSString*)nibName;

/**
 *  (便捷)导航栏【仅图片内容】数据model初始化
 
 @param text     图片内容
 @param itemType item所属位置类型(左边按钮/右边按钮/title)
 
 @return 导航栏item model
 */
+(instancetype)navItemModelOnlyWithImage:(UIImage*)image withNibName:(NSString*)nibName;

@end
