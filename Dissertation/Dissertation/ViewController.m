//
//  ViewController.m
//  Dissertation
//
//  Created by Samuel B Heather on 09/04/2015.
//  Copyright (c) 2015 Samuel B Heather. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableData *_responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)sendQuery:(id)sender {
    [responseField setText:@"Processing..."];
    [self transmitThisDictAsJson:@{
                                   @"cellNumber" : [numberField text],
                                   @"question" : [questionField text]}];
}

#pragma mark - Network stuff

-(void)returnedDict:(NSDictionary *)returnedData {
    [responseField setText:[returnedData description]];
}

-(void)transmitThisDictAsJson:(NSDictionary *)dictionary {
    
    //    NSLog([dictionary description]);
    
    NSString *inputURL = @"http://dis.heather.sh:5000/entry";
    
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:inputURL]];
    [request setHTTPMethod:@"POST"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (jsonData) {
        
        [request setHTTPBody:jsonData];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        (void)[[NSURLConnection alloc] initWithRequest:request delegate:self];
    } else {
        NSLog(@"Unable to serialize the data %@: %@", dictionary, error);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    NSLog(@"Something was returned");
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableLeaves error:nil];
    
    [self returnedDict:dict];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

#pragma mark - Other default view stuff

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
