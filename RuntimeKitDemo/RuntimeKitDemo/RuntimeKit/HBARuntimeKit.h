//
//  HBARuntimeKit.h
//  RuntimeKitDemo
//
//  Created by 乔贝斯 on 2017/8/16.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface HBARuntimeKit : NSObject


/**
 获取类型

 @param class 相应类
 @return 类名
 */
+ (NSString *)fetchClassName:(Class)class;



/**
 获取成员变量

 @param class 相应类
 @return NSArray
 */
+ (NSArray *)fetchIvarList:(Class)class;



/**
 获取类的属性列表，包括私有和公有属性，以及定义在延展中的属性

 @param class 相应类
 @return NSArray
 */
+ (NSArray *)fetchPropertyList:(Class)class;



/**
 获取类的实例方法列表： getter, setter, 对象方法等。

 @param class 相应类
 @return NSArray
 */
+ (NSArray *)fetchMethodList:(Class)class;



/**
 获取协议列表

 @param class <#class description#>
 @return <#return value description#>
 */
+ (NSArray *)fetchProtocolList:(Class)class;



/**
 给类添加新的方法与实现

 @param class 类型
 @param methodSel 方法名
 @param methodSelImp 方法实现
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImp;




/**
 方法交换

 @param class 类
 @param method1 method1 description
 @param method2 method2 description
 */
+ (void)exchangeMethod:(Class)class method1:(SEL)method1 method2:(SEL)method2;

@end
