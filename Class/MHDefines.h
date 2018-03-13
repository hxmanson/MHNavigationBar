//
//  Defines.h
//  OceanhighIPA
//
//  Created by Oceanhigh on 16/2/29.
//  Copyright © 2016年 OH. All rights reserved.
//
//
//  Defines.h
//  OceanhighIPA
//
//  Created by Oceanhigh on 16/2/29.
//  Copyright © 2016年 OH. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - !!!宏定义!!!
/**
 *  此版本作废接口（方法/函数）标记
 */
#define MHFunctionDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
/**
 *  系统信息Define
 */
//版本信息
#define kINFO_SYSTEM_DICT [[NSBundle mainBundle] infoDictionary]
#define kINFO_OS_PLATFORM [[UIDevice currentDevice]systemName]
#define kINFO_OS_VERSION [[UIDevice currentDevice]systemVersion] //文字版本号
#define kIOS_SYS_VERSION [[UIDevice currentDevice].systemVersion doubleValue] //数字版本号
#define kINFO_APP_VERSION [kINFO_SYSTEM_DICT objectForKey:@"CFBundleShortVersionString"]
#define kINFO_APP_NAME [kINFO_SYSTEM_DICT objectForKey:@"CFBundleDisplayName"]
#define kINFO_APP_BUILD [kINFO_SYSTEM_DICT objectForKey:@"CFBundleVersion"]
//tabbar高度
#define kTabbarHeight_X 83.
#define kTabbarHeight_6 49.
//设备型号高度尺寸
#define kDeviceHeight_4 480.
#define kDeviceHeight_5 568.
#define kDeviceHeight_6 667.
#define kDeviceHeight_6P 736.
#define kDeviceHeight_X 812.
//设备型号判断
#define kIPHONE4 (kDeviceHeight_4 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define kIPHONE5 (kDeviceHeight_5 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define kIPhone6 (kDeviceHeight_6 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define kIPhone6plus (kDeviceHeight_6P == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define kIPhoneX (kDeviceHeight_X == [[UIScreen mainScreen] bounds].size.height ? YES : NO)

#define kiPhone_Above(deviceHeight) ((kSCREEN_HEIGHT >= deviceHeight)?(YES):(NO))
#define kiPhone_Less(deviceHeight) ((kSCREEN_HEIGHT <= deviceHeight)?(YES):(NO))
//设备屏幕尺寸
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kNavBarHeight (kIPhoneX?88.:64.)
//系统版本
#define kIOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
#define kIOS_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))
#define kIOS_VERSION_9_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)? (YES):(NO))
#define kIOS_VERSION_10_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)? (YES):(NO))
#define kIOS_VERSION_11_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)? (YES):(NO))

/**
 *  获取用户时间戳
 */
#define kTimeStamp [[NSDate date]timeIntervalSince1970]
#define YEAR_START 1910//滚轮显示的起始年份
#define YEAR_END 2049//滚轮显示的结束年份
/**
 *  文字属性定义
 */
#define kFONT(fontName,fontSize) [UIFont fontWithName:fontName size:fontSize]
#define kFONT_Regular(fontSize) kFONT(@"PingFangSC-Regular",fontSize)
#define kFONT_Medium(fontSize) kFONT(@"PingFangSC-Medium",fontSize)
#define kFONT_Bold(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define kFONT_Light(fontSize) kFONT(@"PingFangSC-Light",fontSize)
#define kFONT_Heavy(fontSize) kFONT(@"PingFangSC-Heavy",fontSize)

//颜色值定义
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//RGB
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
//常用颜色
#define kCOLOR_White [UIColor whiteColor]
#define kCOLOR_Black [UIColor blackColor]
#define kCOLOR_Clear [UIColor clearColor]
#define kCOLOR_Red [UIColor redColor]

/**
 *  控件属性预定义
 */
#define kTAG_DEFAULT_BUTTON(tag) (1000+tag)/**<按钮tag*/
#define kTAG_DEFAULT_VIEW(tag) (2000+tag)/**<视图框tag*/
#define kTAG_DEFAULT_IMAGE_VIEW(tag) (3000+tag)/**<图片框tag*/
#define kTAG_DEFAULT_LABEL(tag) (4000+tag)/**<显示框tag*/
#define kTAG_DEFAULT_TEXTFIELD(tag) (5000+tag)/**<文本框tag*/
#define kTAG_DEFAULT_TEXTView(tag) (6000+tag)/**<文本框tag*/
#define kTAG_DEFAULT_ACTIONSHEET(tag) (7000+tag)/**<Actionsheet底部弹出选择框tag*/
#define kTAG_DEFAULT_ALERTVIEW(tag) (8000+tag)/**<弹出提示框tag*/
#define kTAG_DEFAULT_TABBARITEM(tag) (9000+tag)/**<Tabbar底部按钮tag*/
//图片宏
#define kIMG_GET(imgName) [UIImage imageNamed:imgName]
/**
 *  本地化文本显示
 */
#define MHLocalizedText(key) NSLocalizedString(key, @"")

/**
 * 获取Appdelegate
 */
#define kAppDelegate ((AppDelegate *)[[UIApplication sharedApplication]delegate])

//定义弱引用常量
#define kWeak(weakSelf) __weak __typeof(&*self)weakSelf = self;


/**
 *  定义返回请求数据的block类型
 */
typedef void (^ReturnValueBlock) (id returnValue,NSUInteger requestType);
typedef void (^ErrorCodeBlock) (id errorCode,id errorMsg);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);
//定义数据处理返回的block类型
typedef void (^HandleDataBlock) (id result);

@interface MHDefines : NSObject
@end
