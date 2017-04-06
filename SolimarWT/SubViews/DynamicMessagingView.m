//
//  DynamicMessagingView.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/7/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import "DynamicMessagingView.h"

@implementation DynamicMessagingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 1;
        
        UIImage *headerLogoImage = [UIImage imageNamed:NSLocalizedString(@"ar_trekk_logo", "ar_trekk_logo")];
        UIImageView *headerLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50, 120, 120)];
        headerLogoImageView.image = headerLogoImage;
        [headerLogoImageView setBackgroundColor:[UIColor clearColor]];
        [super.scrollview addSubview:headerLogoImageView];

        int y = 210;
        
        UILabel *headerText = [[UILabel alloc] initWithFrame:CGRectMake(25, y, super.scrollview.bounds.size.width - 40, 50)];
        headerText.text = NSLocalizedString(@"dynamic_messaging_header", "dynamic_messaging_header");
        [headerText setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:self.frame.size.width/16]];
        headerText.textColor = [UIColor colorWithRed:241.0/255.0 green:100.0/255.0 blue:18.0/255.0 alpha:1];
        [headerText sizeToFit];
        headerText.backgroundColor = [UIColor whiteColor];
        headerText.textAlignment = NSTextAlignmentLeft;
        [super.scrollview addSubview:headerText];
        
        y = y + headerText.bounds.size.height + 10;
        
        UILabel *bodyText = [[UILabel alloc] initWithFrame:CGRectMake(25, y, super.scrollview.bounds.size.width - 40, 0)];
        bodyText.text = NSLocalizedString(@"dynamic_messaging_body", "dynamic_messaging_body");
        [bodyText setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:18.0f]];
        bodyText.backgroundColor = [UIColor whiteColor];
        bodyText.textAlignment = NSTextAlignmentLeft;
        bodyText.numberOfLines = 0;
        [bodyText sizeToFit];
        [super.scrollview addSubview:bodyText];
        
        y = y + bodyText.bounds.size.height + 10;
        
        UIButton *learnMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [learnMoreButton setFrame:CGRectMake(25, y, frame.size.width - 50, 50)];
        learnMoreButton.backgroundColor = SOLIMARBLUE;
        learnMoreButton.showsTouchWhenHighlighted = YES;
        [learnMoreButton setTitle:NSLocalizedString(@"dynamic_messaging_button", "dynamic_messaging_button") forState:normal];
        [learnMoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [learnMoreButton addTarget:self action:@selector(openSafari)forControlEvents:UIControlEventTouchUpInside];
        learnMoreButton.tag = 2;
        [super.scrollview addSubview:learnMoreButton];
        
        NSLog(@"%f", y + learnMoreButton.bounds.size.height + 100);
        NSLog(@"super.scrollview.bounds.size.height before: %f", super.scrollview.bounds.size.height);
        super.scrollview.contentSize = CGSizeMake(frame.size.width, y + learnMoreButton.bounds.size.height + 100);
        NSLog(@"super.scrollview.bounds.size.height after: %f", super.scrollview.bounds.size.height);
    }
    
    return self;
}

- (void)openSafari {
    UIApplication *mySafari = [UIApplication sharedApplication];
    NSURL *myURL = [[NSURL alloc] initWithString:@"http://offers.trekk.com/personalized-augmented-reality-ebook?__hstc=93664770.d5be86bcc2190653f90c499fb53aabc2.1423763508113.1476711225511.1476716711379.327&__hssc=93664770.1.1476720707684&__hsfp=3410703928&hsCtaTracking=fd460e68-a1e1-4ccc-a618-8d5e8b309dce%7C051751eb-d003-4199-973d-a7bf4989db79"];
    [mySafari openURL:myURL];
}


@end
