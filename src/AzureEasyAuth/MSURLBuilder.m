// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------

#import "MSURLBuilder.h"
#import "MSConnectionConfiguration.h"
#import "MSError.h"

#pragma mark * MSURLBuilder Implementation

@implementation MSURLBuilder

#pragma mark * Private Methods
// This is for 'strict' URL encoding that will encode even reserved URL
// characters.  It should be used only on URL pieces, not full URLs.
NSString* encodeToPercentEscapeString(NSString *string) {
    NSMutableCharacterSet *strictSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    
    // We also want these encoded, regardless of if they are allowed in a query
    [strictSet removeCharactersInString:@"!*;:@&=+/?%#[]"];

    return [string stringByAddingPercentEncodingWithAllowedCharacters:strictSet];
}

+(NSString *) queryStringFromParameters:(NSDictionary *)queryParameters
{
    // Iterate through the parameters to build the query string as key=value
    // pairs seperated by '&'
    NSMutableString *queryString = [NSMutableString string];
    for (NSString* key in [queryParameters allKeys]) {
        NSString *name = [key description];
        
        // Get the paremeter name and value
        id value = [queryParameters objectForKey:key];
        if ([value isKindOfClass:[NSArray class]]) {
            for (id arrayValue in value) {
                [MSURLBuilder appendParameterName:name andValue:[arrayValue description] toQueryString:queryString];
            }
        } else {
                [MSURLBuilder appendParameterName:name andValue:[value description] toQueryString:queryString];
        }
    }
    
    return queryString;
}

+(void) appendParameterName:(NSString *)name andValue:(NSString *)value toQueryString:(NSMutableString *)queryString
{
    // URL Encode the parameter name and the value
    NSString *encodedValue = encodeToPercentEscapeString(value);
    NSString *encodedName = encodeToPercentEscapeString(name);

    if (queryString.length > 0) {
        [queryString appendFormat:@"&%@=%@", encodedName, encodedValue];
    } else {
        [queryString appendFormat:@"%@=%@", encodedName, encodedValue];
    }
}

+(NSURL *) URLByAppendingQueryParameters:(NSDictionary *)queryParameters
                                   toURL:(NSURL *)url
{
    NSURL *newUrl = url;
    
    // Do nothing if there are no query paramters
    if (queryParameters && queryParameters.count > 0) {
        
        NSString *queryString =
            [MSURLBuilder queryStringFromParameters:queryParameters];
        newUrl = [MSURLBuilder URLByAppendingQueryString:queryString
                                                        toURL:newUrl];
    }
    
    return newUrl;
}

+(NSURL *) URLByAppendingQueryString:(NSString *)queryString
                               toURL:(NSURL *)url
{
    NSURL *newUrl = url;
    
    // Do nothing if the parameters were empty strings
    if (queryString && queryString.length > 0) {
        
        // Check if we are appending to existing parameters or not
        BOOL alreadyHasQuery = url.query != nil;
        NSString *queryChar = alreadyHasQuery ? @"&" : @"?";
        
        // Rebuild a new URL from a string
        NSString *newUrlString = [NSString stringWithFormat:@"%@%@%@",
                                  [url absoluteString],
                                  queryChar,
                                  queryString];
        
        newUrl = [NSURL URLWithString:newUrlString];
    }
    
    return newUrl;
}

+(BOOL) userParametersAreValid:(NSDictionary *)parameters
                       orError:(NSError **)error
{
    BOOL areValid = YES;
    NSError *localError = nil;
    
    // Do nothing if there are no query paramters
    if (parameters && parameters.count > 0) {
       
        for (NSString* key in [parameters allKeys]){
            
            // Ensure none of the user parameters start with the '$', as this
            // is reserved for system-defined query parameters
            if ([key length] > 0 && [key characterAtIndex:0] == '$') {
                localError = [MSURLBuilder errorWithUserParameter:key];
                areValid = NO;
                break;
            }
        }
    }
    
    if (!areValid && error) {
        *error = localError;
    }
    
    return areValid;
}


#pragma mark * Private NSError Generation Methods


+(NSError *) errorWithUserParameter:(NSString *)parameterName
{
    NSString *descriptionKey = @"'%@' is an invalid user-defined query string parameter. User-defined query string parameters must not begin with a '$'.";
    NSString *descriptionFormat = NSLocalizedString(descriptionKey, nil);
    NSString *description = [NSString stringWithFormat:descriptionFormat, parameterName];
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey :description };
    
    return [NSError errorWithDomain:MSErrorDomain
                               code:MSInvalidUserParameterWithRequest
                           userInfo:userInfo];
}

@end
