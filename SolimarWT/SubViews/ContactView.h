//
//  ContactView.h
//  SolimarWT
//
//  Created by Timothy C Grable on 12/7/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@protocol ContactProtocol;

@protocol ContactProtocol <NSObject>

@required
- (void)sendEmail:(NSString *)fName lastName:(NSString *)lName company:(NSString *)company email:(NSString *)email phone:(NSString *)phone comments:(NSString *)comments;
- (void)displayAlert:(NSString *)title andMessage:(NSString *)message;
@end


@interface ContactView : BaseView <UITextFieldDelegate, UITextViewDelegate>

@property NSInteger inFocusTextField;
@property (strong, nonatomic) UITextField *fName;
@property (strong, nonatomic) UITextField *lName;
@property (strong, nonatomic) UITextField *company;
@property (strong, nonatomic) UITextField *email;
@property (strong, nonatomic) UITextField *phone;
@property (strong, nonatomic) UITextView *comments;
@property (strong, nonatomic) UIButton *submitButton;

@property (strong, nonatomic) NSMutableArray *textFields;

@property (weak, nonatomic) id <ContactProtocol> delegate;

@end
