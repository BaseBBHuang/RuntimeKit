//
//  HBARuntimeKit.m
//  RuntimeKitDemo
//
//  Created by 乔贝斯 on 2017/8/16.
//  Copyright © 2017年 BAH. All rights reserved.
//

#import "HBARuntimeKit.h"

@implementation HBARuntimeKit

/**
 获取类型
 
 @param class 相应类
 @return 类名
 */
+ (NSString *)fetchClassName:(Class)class
{
    const char *className = class_getName(class);
    return [NSString stringWithUTF8String:className];
}

/**
 获取成员变量
 
 @param class 相应类
 @return NSArray
 */
+ (NSArray *)fetchIvarList:(Class)class
{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        const char *ivarName = ivar_getName(ivarList[i]);
        dic[@"IvarType"] = [NSString stringWithUTF8String:ivarType];
        dic[@"IvarName"] = [NSString stringWithUTF8String:ivarName];
        [mutArr addObject:dic];
    }
    free(ivarList);
    
    return [NSArray arrayWithArray:mutArr];
}


/**
 获取类的属性列表，包括私有和公有属性，以及定义在延展中的属性
 
 @param class 相应类
 @return NSArray
 */
+ (NSArray *)fetchPropertyList:(Class)class
{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutArr addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutArr];
}



/**
 获取类的实例方法列表： getter, setter, 对象方法等。
 
 @param class 相应类
 @return NSArray
 */
+ (NSArray *)fetchMethodList:(Class)class
{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutArr addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutArr];
}


/**
 获取协议列表
 
 @param class <#class description#>
 @return <#return value description#>
 */
+ (NSArray *)fetchProtocolList:(Class)class
{
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutArr addObject:[NSString stringWithUTF8String:protocolName]];
    }
    free(protocolList);
    return [NSArray arrayWithArray:mutArr];
}


/**
 给类添加新的方法与实现
 
 @param class 类型
 @param methodSel 方法名
 @param methodSelImp 方法实现
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImp
{
    Method method = class_getInstanceMethod(class, methodSelImp);
    IMP methodIMP = method_getImplementation(method);
    const char *type = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, type);
}


/**
 方法交换
 
 @param class 类
 @param method1 method1 description
 @param method2 method2 description
 */
+ (void)exchangeMethod:(Class)class method1:(SEL)method1 method2:(SEL)method2
{
    Method firstMethod = class_getInstanceMethod(class, method1);
    Method secondMethod = class_getInstanceMethod(class, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}


@end
