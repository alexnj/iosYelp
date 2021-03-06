//
//  YelpClient.m
//  Yelp
//
//  Created by Alex on 6/21/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

#import "YelpClient.h"
#import "YelpApiSecrets.h"

@implementation YelpClient

- (id)init {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret];
    
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:kYelpToken secret:kYelpTokenSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }

    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term sort:(NSString*)sort category:(NSString*)category radius:(NSString*)radius deals:(NSString*)deals success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSDictionary *parameters = @{@"term": term, @"location" : @"San Francisco", @"sort":sort, @"category_filter":category, @"radius_filter":radius, @"deals_filter":deals };
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

@end
