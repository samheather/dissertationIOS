//
//  ViewController.h
//  Dissertation
//
//  Created by Samuel B Heather on 09/04/2015.
//  Copyright (c) 2015 Samuel B Heather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UITextField *numberField;
    IBOutlet UITextField *questionField;
    IBOutlet UITextView *responseField;
}

-(IBAction)sendQuery:(id)sender;

@end

