//
//  DataHelper.m
//  duanzhu
//
//  Created by 盛涛 on 2017/7/14.
//  Copyright © 2017年 盛涛. All rights reserved.
//

#import "DataHelper.h"
#import "GoodsModel.h"
#import "DingDanModel.h"
static DataHelper * helper;
@implementation DataHelper

+ (DataHelper *)shareDataHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[DataHelper alloc] init];
    });
    return helper;
}

+ (float)shopCartCellHeight:(GoodsModel *)model
{
    NSInteger dateCount = model.dateList.count;
    NSInteger rows = (dateCount / 6) + ((dateCount % 6) > 0 ? 1 : 0);
    return rows * 30;
}
+ (float)dingdanCellHeight:(DingDanModel *)model
{
    NSInteger dateCount = model.dateAry.count;
    NSInteger rows = (dateCount / 6) + ((dateCount % 6) > 0 ? 1 : 0);
    return rows * 30;
}

- (void)saveUserMessages
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%ld",(long)self.userID] forKey:@"userID"];
    [userDefaults setObject:self.headerImage forKey:@"userFace"];
    [userDefaults setObject:self.account forKey:@"userName"];
    [userDefaults setObject:self.phoneNum forKey:@"phoneNum"];
    [userDefaults setObject:[NSString stringWithFormat:@"%ld",(long)self.shopCarCount] forKey:@"ShopCarCount"];
    [userDefaults setObject:self.realName forKey:@"RealName"];
}

- (void)getUserMessages
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    self.userID = [[userDefaults objectForKey:@"userID"] integerValue];
    self.headerImage = [userDefaults objectForKey:@"userFace"];
    self.account = [userDefaults objectForKey:@"userName"];
    self.phoneNum = [userDefaults objectForKey:@"phoneNum"];
    self.shopCarCount = [[userDefaults objectForKey:@"ShopCarCount"] integerValue];
    self.realName = [userDefaults objectForKey:@"RealName"];
}




//本地plist
- (NSDictionary *)localPlistDic
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ChoosePlist" ofType:@"plist" inDirectory:nil];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    return dic;
}

//本地缓存
//沙盒存储路径
- (NSString *)filePath:(NSString *)path
{
    NSString * documents = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath = [documents stringByAppendingPathComponent:path];
    return filePath;
}


//判断是否是邮箱
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}


//判断是否是手机号码
- (BOOL)isValidatePhone:(NSString *)phone
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(16[0-9])|(17[0-9])|(19[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:phone];
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188 (147,178)
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|5[0127-9]|78|8[2-478])\\d)\\d{7}$";
//    
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,155,156,176,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[56]|76|8[56])\\d{8}$";
//    
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,153,173,177,180,181,189
//     22         */
//    NSString * CT = @"^1((33|53|7[39]|8[019])[0-9]|349)\\d{7}$";
//    /**
//     25         * 大陆地区固话及小灵通
//     26         * 区号：010,020,021,022,023,024,025,027,028,029
//     27         * 号码：七位或八位
//     28         */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:phone] == YES)
//        || ([regextestcm evaluateWithObject:phone] == YES)
//        || ([regextestct evaluateWithObject:phone] == YES)
//        || ([regextestcu evaluateWithObject:phone] == YES))
//    {
//        if([regextestcm evaluateWithObject:phone] == YES) {
//            NSLog(@"China Mobile");
//        } else if([regextestct evaluateWithObject:phone] == YES) {
//            NSLog(@"China Telecom");
//        } else if ([regextestcu evaluateWithObject:phone] == YES) {
//            NSLog(@"China Unicom");
//        } else {
//            NSLog(@"Unknow");
//        }
//        
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

//日期格式转换
- (NSString *)dateStringToString:(NSString *)dateStr
{
    //转换成正常时间显示
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate * dateTime = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:dateTime];
    NSLog(@"时间===%@",str);
    return str;
}

- (NSMutableArray *)selectedDateAry
{
    if (_selectedDateAry == nil) {
        self.selectedDateAry = [NSMutableArray  arrayWithCapacity:1];
    }
    return _selectedDateAry;
}

- (NSMutableDictionary *)changdiYESOrNODic
{
    if (_changdiYESOrNODic == nil) {
        self.changdiYESOrNODic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _changdiYESOrNODic;
}

- (NSMutableDictionary *)dangqiYESOrNODic
{
    if (_dangqiYESOrNODic == nil) {
        self.dangqiYESOrNODic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _dangqiYESOrNODic;
}

@end
