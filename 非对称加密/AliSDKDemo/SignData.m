//
//  PramasOperator.m
//  ZTLife
//
//  Created by raven on 16/3/18.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import "SignData.h"
#import "HBRSAHandler.h"

//static NSString *const kPrivateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBANjPN62PGcUy35WCMDdr81MSM8zBYtOpcFVpz3VLYLTfwuIgwUsKJ3Aj55xlk9SPlFIQdmQEKtaxZP6eV2B24OYivT71ptMphevciVfQ/wkKnOTeodkM8ixSWfo/7cGPvR7+4ehYgMuBXg/V7/keY2NaXfLWyX0qAWmJCF90PfOVAgMBAAECgYBFBbM0DdqmbQvBDTFMc5GDYMgc53QO7mJUztq8/MJM0u+4DbV7rj/f845IvA3UHeGaPqNyM+FveAovBTnL/AycoTbgkf1+9VWQrZpUwLXvf7aEWiMSRX+etXu62/GBAhtPfMlm6J24UTmKR9tyrykK4vhn6ofWz5IfMMjIjo7wAQJBAPjxwCDO2XFWQy7pq7h8bUkR2xY2zW/A9tom7lTRU0/CIgtRPR2BkNdJtJkf3qfDrZCTJGtpj8raN+sUn9yLGl0CQQDe9E7SHnE+N3AZds8Z8xi974DwxM6mZWDLHUA9zlVF6kgK0WinTuxYlZbmwUAGxkL9lH0bedMrm6BOJhZ4yNqZAkA/wDESdcZLdurHhcGbAgo+jxsK6kfb2Y+duCCKifyKzU1IlqpO9xIvf8mG+Rlc3wiAoJ3P//151j5BrktuABVlAkA42oPfAPRPsUNcuvdE3sDIbnKq8wTfWaq9INBo8ly8X2nPmGbfgzixvjOk1FLHZ3ddwqfEgeRfkmfmhb/lPRLBAkAMzVCAC3LbfRT9KbGJLp3eNpDwDUieQFxTBOj2wms79gwyNfcyl1FiatNR44iAyRBL+4vplW3fyqSSHKXEosRf";

static NSString *const kPrivateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMEuXzdYn4NlbroZzGIvpcL+70R4zd4yFY1k/sNK3I1iTpGYDqUyEQbnBMnRTurpXUYwQYKkBR9xhUid6CqRcx0BkUo/TUdWRlnQkqW1mkgkfe7FpUeIXvu5TUzZoIZs+ubX5CH7CUfSyTtc0Prc0a7aiL/8BUkXBx0VVWEgyJ8RAgMBAAECgYEAj90e37LKKCpTyZgI0140jgEY4t8sQTr/Petmpr2Lfmclp9ubnH6qm39T25BauyrLYcfyIX5Qqlf6MFgYXAsxs6wh/xNaH6exbA6+0nL+9LYKut6aw6LSxNWqZevrkltKdLumra60mnIrtOENyTd1CJOnCZ6KtnEzpIfsFTqaxaECQQD94gcS0eRYPyvw150gTc5/XOTJWu98vWZtGglPjqT7cU7HMt3XKwR6YpgGiq1o9BZw4I4zlaXVbxpwFIrwL/rtAkEAwsrDHpYUa1gSpnKh2b3xLeA2nZreKzdLjAyuj9egF/RohYnzg2SxZbENXwJ9jjoZvHXtgJ3FE/23nqFqs07cNQJAFIgW8lqvEMPrFcsaFea08G/ewLnt7DSU9/XHEvwCM6NyL4HZlvEPp6YZjU3hwD8dIXvHhDxx8NTPWokOw2Xd8QJAaEc7pUgarkx7z3dWhcZVMoXxNvYNMX1siBDR8lcwcSJ6QeLT5eclwJbD3bTrmhQoaueGuW+8bTNJ9TXcdRkmcQJAIxiM69Gt8vp/0pbuIYW0Pfos0LuxyDXO9MtE4rhFSIlzjo1SiZgzD8vQMey3EQDPjF2J+zfCcz1amYDa0zlW/w==";


@implementation SignData

+ (NSDictionary *)signData:(NSDictionary *)params
{
    NSString *stringSign = [self privateKeySignatureWithDict:params];
    
    NSMutableDictionary *returnDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    [returnDic setObject:stringSign forKey:@"sign"];
    
    return returnDic;
}

+ (NSString *)privateKeySignatureWithDict:(NSDictionary *)params
{
    NSString *privateKey = kPrivateKey;
    
    NSString *signStr = [self appPrivateKeyWithDict:params];
    HBRSAHandler *handler = [HBRSAHandler new];
    [handler importKeyWithType:KeyTypePrivate andkeyString:privateKey];
    
    NSString *signedString = [handler signString:signStr];
   // NSLog(@"signedString签名::     %@", signedString);
    return signedString;
}

+ (NSString *)encryptPassword:(NSString *)password
{
    HBRSAHandler *handler = [HBRSAHandler new];
    [handler importKeyWithType:KeyTypePrivate andkeyString:kPrivateKey];
    
    NSString *encryptStr = [handler encryptWithPrivateKey:password];
  //  NSLog(@"加密密码::     %@", encryptStr);
    
    
    
    return [encryptStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

+ (NSString *)appPrivateKeyWithDict:(NSDictionary *)params
{
    NSMutableString *contentString  = [NSMutableString string];
    NSDictionary* dict = params;
    NSArray *keys = [dict allKeys];
    
    // 按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 拼接字符串
    for (NSString *categoryId in sortedArray)
    {
        [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
    }
    
    // 添加key字段
    NSString *removeSpaceStr = [contentString stringByReplacingOccurrencesOfString:@"  " withString:@""];
    NSString *sortStr = [removeSpaceStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    sortStr = [sortStr substringToIndex:sortStr.length - 1];
    
    // NSLog(@"排好序的字符串：：%@", sortStr);
    return sortStr;
}


@end
