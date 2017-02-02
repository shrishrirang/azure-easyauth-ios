// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------

#import <Foundation/Foundation.h>

#pragma  mark * MSURLBuilder Public Interface


// The |MSURLBuilder| class encapsulates the logic for building the
// appropriate URLs for the Mobile Service requests.
@interface MSURLBuilder : NSObject

#pragma  mark * Public URL Builder Methods

+(NSURL *)URLByAppendingQueryParameters:(NSDictionary *)queryParameters
                                   toURL:(NSURL *)url;

+(void)appendParameterName:(NSString *)name andValue:(NSString *)value toQueryString:(NSMutableString *)queryString;

@end
