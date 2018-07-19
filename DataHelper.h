//
//  DataHelper.h
//  duanzhu
//
//  Created by 盛涛 on 2017/7/14.
//  Copyright © 2017年 盛涛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsModel,DingDanModel;
@interface DataHelper : NSObject


+ (DataHelper *)shareDataHelper;
+ (float)shopCartCellHeight:(GoodsModel *)model;
+ (float)dingdanCellHeight:(DingDanModel *)model;

@property (nonatomic, strong)NSArray * hotSearchAry;//热门搜索列表

//用户信息
@property (nonatomic, copy)NSString * account;//用户名
@property (nonatomic, assign)NSInteger userID;//用户ID
@property (nonatomic, copy)NSString * phoneNum;//手机号
@property (nonatomic, copy)NSString * headerImage;//头像
@property (nonatomic, assign)NSInteger shopCarCount;//购物车数量
@property (nonatomic, copy)NSString * realName;//真实姓名
@property (nonatomic, copy)NSString * email;//邮箱
@property (nonatomic, copy)NSString * companyName;//公司名称
- (void)saveUserMessages;
- (void)getUserMessages;


//登录状态
@property (nonatomic, assign)BOOL isLogin;

//是否WiFi
@property (nonatomic, assign)BOOL isWifiOrNot;

//定位位置
@property (nonatomic, copy)NSString * localPlace;

//存储选择日期
@property (nonatomic, strong)NSMutableArray * selectedDateAry;

//存储日期是否选择
@property (nonatomic, strong)NSMutableDictionary * dangqiYESOrNODic;
//存储场地是否选择
@property (nonatomic, strong)NSMutableDictionary * changdiYESOrNODic;


//本地plist文件
- (NSDictionary *)localPlistDic;

//本地存储
- (NSString *)filePath:(NSString *)path;

//判断是否是邮箱
-(BOOL)isValidateEmail:(NSString *)email;

//判断是否是手机号码
- (BOOL)isValidatePhone:(NSString *)phone;

//日期格式转换
- (NSString *)dateStringToString:(NSString *)dateStr;


@end
