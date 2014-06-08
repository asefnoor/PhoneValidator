//
//  ViewController.m
//  CountryPickerDemo
//
//  Created by Nick Lockwood on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "NBPhoneMetaDataGenerator.h"
#import "NBPhoneNumberUtil.h"
#import "Utility.h"
@implementation ViewController

- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code {
	_nameLabel.text = name;
	_regionCode = code;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSString *trimmedPhone = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	BOOL isValid = [self isValidNumber:trimmedPhone];
	[self showValidationLabel:isValid];
	[self.phoneTxtField resignFirstResponder];
	return TRUE;
}

- (void)showValidationLabel:(BOOL)isValid {
	self.validationMessageLabel.hidden = false;
	if (isValid) {
		self.validationMessageLabel.text = @"Valid";
		self.validationMessageLabel.textColor = [UIColor greenColor];
	}
	else {
		self.validationMessageLabel.text = @"In Valid";
		self.validationMessageLabel.textColor = [UIColor redColor];
	}
}

- (BOOL)isValidNumber:(NSString *)numberStr {
	NBPhoneMetaDataGenerator *generator = [[NBPhoneMetaDataGenerator alloc] init];
	[generator generateMetadataClasses];
	NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];
	NSError *error = nil;
	NBPhoneNumber *phoneNumberUS = [phoneUtil parse:numberStr defaultRegion:_regionCode error:&error];
	if (error) {
		[Utility showAlertWithTitle:@"Error" message:[error localizedDescription]];
	}
	NSLog(@"- isValidNumber [%@]", [phoneUtil isValidNumber:phoneNumberUS] ? @"YES" : @"NO");
	//NSLog(@"- isPossibleNumber [%@]", [phoneUtil isPossibleNumber:phoneNumberUS error:&error] ? @"YES" : @"NO");
	//NSLog(@"- getRegionCodeForNumber [%@]", [phoneUtil getRegionCodeForNumber:phoneNumberUS]);
	return [phoneUtil isValidNumber:phoneNumberUS];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.phoneTxtField.returnKeyType = UIReturnKeyDone;
	NSArray *countryNames = [CountryPicker countryNames];
	if ([countryNames count] > 0) {
		[self.countryPicker setSelectedCountryName:[countryNames objectAtIndex:0] animated:YES];
	}
}

@end
