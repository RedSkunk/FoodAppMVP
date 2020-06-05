//
//  STLServerUtil.h
//
//  Created by Roman Mironenko on 2016-07-04.
//  Copyright © 2016 Roman Mironenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface STLServerUtil : NSObject

#pragma mark - Request Error
+ (BOOL)isError:(NSError *)error;


@end
