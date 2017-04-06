//
//  ContactView.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/7/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import "ContactView.h"

@implementation ContactView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 1;
        _inFocusTextField = 10;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAway:)];
        [self addGestureRecognizer:tapGesture];
        
        UIImage *headerLogoImage = [UIImage imageNamed:@"solimar-logo-white"];
        UIImageView *headerLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 110, 253, 60)];
        headerLogoImageView.image = headerLogoImage;
        [headerLogoImageView setBackgroundColor:[UIColor clearColor]];
        [super.scrollview addSubview:headerLogoImageView];
        
        int y = 210;

        UILabel *aboutText = [[UILabel alloc] initWithFrame:CGRectMake(25, y, super.scrollview.bounds.size.width - 40, 50)];
        aboutText.text = NSLocalizedString(@"contact_header", "contact_header");
        [aboutText setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:24.0f]];
        aboutText.textColor = [UIColor colorWithRed:241.0/255.0 green:100.0/255.0 blue:18.0/255.0 alpha:1];
        aboutText.backgroundColor = [UIColor whiteColor];
        aboutText.textAlignment = NSTextAlignmentLeft;
        [super.scrollview addSubview:aboutText];
        
        y = y + 60;
        
        UILabel *bodyText = [[UILabel alloc] initWithFrame:CGRectMake(25, y, super.scrollview.bounds.size.width - 40, 0)];
        bodyText.text = NSLocalizedString(@"contact_body", "contact_body");
        [bodyText setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:18.0f]];
        bodyText.backgroundColor = [UIColor whiteColor];
        bodyText.textAlignment = NSTextAlignmentLeft;
        bodyText.numberOfLines = 0;
        [bodyText sizeToFit];
        [super.scrollview addSubview:bodyText];
        
        y = y + bodyText.bounds.size.height + 15;
        
        UIView *fNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _fName = [[UITextField alloc] initWithFrame:CGRectMake(25, y, frame.size.width - 50, 50)];
        _fName.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:18.0];
        _fName.enablesReturnKeyAutomatically = YES;
        _fName.autocapitalizationType = UITextAutocapitalizationTypeWords;
        _fName.delegate = self;
        _fName.tag = 0;
        _fName.textColor = [UIColor blackColor];
        _fName.placeholder = NSLocalizedString(@"contact_first_name", "contact_first_name");
        _fName.leftView = fNamePaddingView;
        _fName.leftViewMode = UITextFieldViewModeAlways;
        _fName.layer.cornerRadius = 0;
        _fName.layer.borderWidth = 1.0f;
        _fName.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [_fName setBackgroundColor:[UIColor whiteColor]];
        [_fName setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_fName setKeyboardType:UIKeyboardTypeAlphabet];
        [_fName setReturnKeyType:UIReturnKeyNext];
        [super.scrollview addSubview:_fName];
        [_textFields addObject:_fName];
        
        y = y + 65;

        UIView *lNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _lName = [[UITextField alloc] initWithFrame:CGRectMake(25, y, frame.size.width - 50, 50)];
        _lName.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:18.0];
        _lName.enablesReturnKeyAutomatically = YES;
        _lName.autocapitalizationType = UITextAutocapitalizationTypeWords;
        _lName.delegate = self;
        _lName.tag = 1;
        _lName.textColor = [UIColor blackColor];
        _lName.placeholder = NSLocalizedString(@"contact_last_name", "contact_last_name");
        _lName.leftView = lNamePaddingView;
        _lName.leftViewMode = UITextFieldViewModeAlways;
        _lName.layer.cornerRadius = 0;
        _lName.layer.borderWidth = 1.0f;
        _lName.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [_lName setBackgroundColor:[UIColor whiteColor]];
        [_lName setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_lName setKeyboardType:UIKeyboardTypeAlphabet];
        [_lName setReturnKeyType:UIReturnKeyNext];
        [super.scrollview addSubview:_lName];
        [_textFields addObject:_lName];
        
        y = y + 65;
        
        UIView *companyPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _company = [[UITextField alloc] initWithFrame:CGRectMake(25, y, frame.size.width - 50, 50)];
        _company.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:18.0];
        _company.enablesReturnKeyAutomatically = YES;
        _company.autocapitalizationType = UITextAutocapitalizationTypeWords;
        _company.delegate = self;
        _company.tag = 2;
        _company.textColor = [UIColor blackColor];
        _company.placeholder = NSLocalizedString(@"contact_company", "contact_company");
        _company.leftView = companyPaddingView;
        _company.leftViewMode = UITextFieldViewModeAlways;
        _company.layer.cornerRadius = 0;
        _company.layer.borderWidth = 1.0f;
        _company.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [_company setBackgroundColor:[UIColor whiteColor]];
        [_company setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_company setKeyboardType:UIKeyboardTypeAlphabet];
        [_company setReturnKeyType:UIReturnKeyNext];
        [super.scrollview addSubview:_company];
        [_textFields addObject:_company];
        
        y = y + 65;
        
        UIView *emailPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _email = [[UITextField alloc] initWithFrame:CGRectMake(25, y, frame.size.width - 50, 50)];
        _email.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:18.0];
        _email.enablesReturnKeyAutomatically = YES;
        _email.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _email.delegate = self;
        _email.tag = 3;
        _email.textColor = [UIColor blackColor];
        _email.placeholder = NSLocalizedString(@"contact_email", "contact_email");
        _email.leftView = emailPaddingView;
        _email.leftViewMode = UITextFieldViewModeAlways;
        _email.layer.cornerRadius = 0;
        _email.layer.borderWidth = 1.0f;
        _email.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [_email setBackgroundColor:[UIColor whiteColor]];
        [_email setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_email setKeyboardType:UIKeyboardTypeEmailAddress];
        [_email setReturnKeyType:UIReturnKeyNext];
        [super.scrollview addSubview:_email];
        [_textFields addObject:_email];
        
        y = y + 65;
        
        UIView *phonePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _phone = [[UITextField alloc] initWithFrame:CGRectMake(25, y, frame.size.width - 50, 50)];
        _phone.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:18.0];
        _phone.enablesReturnKeyAutomatically = YES;
        _phone.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _phone.delegate = self;
        _phone.tag = 4;
        _phone.textColor = [UIColor blackColor];
        _phone.placeholder = NSLocalizedString(@"contact_phone", "contact_phone");
        _phone.leftView = phonePaddingView;
        _phone.leftViewMode = UITextFieldViewModeAlways;
        _phone.layer.cornerRadius = 0;
        _phone.layer.borderWidth = 1.0f;
        _phone.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [_phone setBackgroundColor:[UIColor whiteColor]];
        [_phone setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_phone setKeyboardType:UIKeyboardTypePhonePad];
        [_phone setReturnKeyType:UIReturnKeyNext];
        [super.scrollview addSubview:_phone];
        [_textFields addObject:_phone];
        
        y = y + 65;
        
        _comments = [[UITextView alloc] initWithFrame:CGRectMake(25, y, frame.size.width - 50, 150)];
        _comments.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:18.0];
        _comments.enablesReturnKeyAutomatically = YES;
        _comments.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        _comments.delegate = self;
        _comments.tag = 5;
        _comments.textColor = [UIColor blackColor];
        _comments.text = NSLocalizedString(@"contact_comments", "contact_comments");
        _comments.textColor = [UIColor lightGrayColor];
        _comments.layer.cornerRadius = 0;
        _comments.layer.borderWidth = 1.0f;
        _comments.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [_comments setBackgroundColor:[UIColor whiteColor]];
        [_comments setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_comments setKeyboardType:UIKeyboardTypeDefault];
        [_comments setReturnKeyType:UIReturnKeyNext];
        [super.scrollview addSubview:_comments];
        
        y = y + 160;
        
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setFrame:CGRectMake(25, y, frame.size.width - 50, 50)];
        _submitButton.backgroundColor = SOLIMARBLUE;
        _submitButton.showsTouchWhenHighlighted = YES;
        [_submitButton setTitle:NSLocalizedString(@"contact_submit", "contact_submit") forState:normal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(sendContactRequest:)forControlEvents:UIControlEventTouchUpInside];
        _submitButton.tag = 2;
        [super.scrollview addSubview:_submitButton];
        
        super.scrollview.contentSize = CGSizeMake(frame.size.width, y + 150);
    }
    
    return self;
}

#pragma mark -
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _inFocusTextField = textField.tag;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _inFocusTextField = 10;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _inFocusTextField = textField.tag;
    
    if (_inFocusTextField == 0) {
        // First Name
        [super.scrollview setContentOffset:CGPointMake(0, 200) animated:YES];
    } else if (_inFocusTextField == 1) {
        // Last Name
        [super.scrollview setContentOffset:CGPointMake(0, 280) animated:YES];
    } else if (_inFocusTextField == 2) {
        // Company
        [super.scrollview setContentOffset:CGPointMake(0, 360) animated:YES];
    } else if (_inFocusTextField == 3) {
        // Email
        [super.scrollview setContentOffset:CGPointMake(0, 420) animated:YES];
    } else if (_inFocusTextField == 4) {
        // Phone
        [super.scrollview setContentOffset:CGPointMake(0, 480) animated:YES];
    } else if (_inFocusTextField == 5) {
        // Comments
        [super.scrollview setContentOffset:CGPointMake(0, 650) animated:YES];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger nextTag = textField.tag + 1;
    
    // Try to find next responder
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder != nil) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard
        [textField resignFirstResponder];
    }
    
    return NO; // We do not want UITextField to insert line-breaks.
}

#pragma mark -
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    // Combine the textView text and the replacement text to
    // create the updated text string
    NSString *currentText = textView.text;
    NSString *updatedText = [currentText stringByReplacingOccurrencesOfString:text withString:currentText options:nil range:range];
    
    // If updated text view will be empty, add the placeholder
    // and set the cursor to the beginning of the text view
    if ([updatedText length] == 0) {
        
        textView.text = NSLocalizedString(@"contact_comments", "contact_comments");
        textView.textColor = [UIColor lightGrayColor];
        textView.selectedTextRange = [textView textRangeFromPosition:textView.beginningOfDocument toPosition:textView.beginningOfDocument];
        
        return NO;
    }
    // Else if the text view's placeholder is showing and the
    // length of the replacement string is greater than 0, clear
    // the text view and set its color to black to prepare for
    // the user's entry
    else if (textView.textColor == [UIColor lightGrayColor] && [textView.text length] != 0) {
        textView.text = nil;
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [super.scrollview setContentOffset:CGPointMake(0, 650) animated:YES];
    
    if ([textView.text isEqualToString:NSLocalizedString(@"contact_comments", "contact_comments")]) {
        textView.text = @"";
    }
    
    _inFocusTextField = textView.tag;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text length] == 0) {
        textView.text = NSLocalizedString(@"contact_comments", "contact_comments");
    }
    
    _inFocusTextField = 10;
}

#pragma mark -
#pragma mark - Learn More Callback
- (void)sendContactRequest:(UIButton *)sender {
    // Required text validation
    if ([_fName.text length] == 0 || [_lName.text length] == 0 || [_company.text length] == 0 || [_email.text length] == 0) {
        [_delegate displayAlert:NSLocalizedString(@"alert_header", "alert_header") andMessage:NSLocalizedString(@"alert_validation", "alert_validation")];
        [super.scrollview setContentOffset:CGPointMake(0, 200) animated:YES];
    }
    
    if (![self isValidEmail:_email.text]) {
        [_delegate displayAlert:NSLocalizedString(@"alert_header", "alert_header") andMessage:NSLocalizedString(@"alert_email_validation", "alert_email_validation")];
        [super.scrollview setContentOffset:CGPointMake(0, 420) animated:YES];
        [_email becomeFirstResponder];
    }
    
//    NSString *comments = @"";
//    if ([_comments.text isEqualToString:NSLocalizedString(@"contact_comments", "contact_comments")] || [_comments.text length] < 9) {
//        [_delegate displayAlert:NSLocalizedString(@"alert_header", "alert_header") andMessage:NSLocalizedString(@"alert_comment_validation", "alert_comment_validation")];
//        [super.scrollview setContentOffset:CGPointMake(0, 650) animated:YES];
//    }
//    else {
//        if (![_comments.text isEqualToString:@""]) {
//            comments = _comments.text;
//        }
//    }
    
    NSString *phone = @"";
    if (![_phone.text isEqualToString:@""]) {
        if ([_phone.text length] > 9) {
            phone = _phone.text;
        }
    }
    
    [_delegate sendEmail:_fName.text lastName:_lName.text company:_company.text email:_email.text phone:_phone.text comments:_comments.text];
    [self resetTextFields];
}

#pragma mark -
#pragma mark - Gesture Recognizer
- (void)tapAway:(UITapGestureRecognizer *)gesture {
    if (_inFocusTextField != 10) {
        UITextField *textField = _textFields[_inFocusTextField];
        [textField resignFirstResponder];
        _inFocusTextField = 10;
        [self endEditing:YES];
    }
    else if (_inFocusTextField == 5) {
        [_comments resignFirstResponder];
        [self endEditing:YES];
    }
}

#pragma mark -
#pragma mark - Utility Methods
- (BOOL)isValidEmail:(NSString *)email {
    
    NSString *emailRegexp = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegexp];
    
    return [emailTest evaluateWithObject: email];
}

- (void)resetTextFields {
    _fName.text = @"";
    _lName.text = @"";
    _company.text = @"";
    _email.text = @"";
    _phone.text = @"";
    _comments.text = @"";
}

@end
