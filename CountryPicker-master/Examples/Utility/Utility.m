//
//  Utility.m
//  CountryPickerDemo
//
//  Created by Asif Noor on 6/7/14.
//
//

#import "Utility.h"

@implementation Utility

+(void)showAlertWithTitle:(NSString*)title message:(NSString*)message{
    
    UIAlertView* alert =  [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK" , nil) otherButtonTitles:nil];
    
    [alert show];
}
@end
