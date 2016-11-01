//
//  PramasOperator.h
//  ZTLife
//
//  Created by raven on 16/3/18.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignData : NSObject

/**
 *  将网络请求参数进行签名
 *
 *  @param params 传入的字典参数
 *
 *  @return 签名好名的参数
 */
+ (NSDictionary *)signData:(NSDictionary *)params;

/**
 *  将字典中的参数进行签名
 *
 *  @param params 传入的字典参数
 *
 *  @return 签名好名的字符串
 */
+ (NSString *)privateKeySignatureWithDict:(NSDictionary *)params;

/**
 *  将密码进行加密处理
 *
 *  @param params 传入密码的字符 
 *
 *  @return 加密后的字符串
 */
+ (NSString *)encryptPassword:(NSString *)password;

@end
