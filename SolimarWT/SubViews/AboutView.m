//
//  AboutView.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/7/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import "AboutView.h"

@implementation AboutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 1;
        
        UIImage *headerLogoImage = [UIImage imageNamed:@"solimar-logo-white"];
        UIImageView *headerLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 110, 253, 60)];
        headerLogoImageView.image = headerLogoImage;
        [headerLogoImageView setBackgroundColor:[UIColor clearColor]];
        [super.scrollview addSubview:headerLogoImageView];
        
        int y = 210;
        
        UILabel *aboutText = [[UILabel alloc] initWithFrame:CGRectMake(25, y, super.scrollview.bounds.size.width - 40, 50)];
        aboutText.text = NSLocalizedString(@"about_header", "about_header");
        [aboutText setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:self.frame.size.width/15]];
        aboutText.textColor = [UIColor colorWithRed:241.0/255.0 green:100.0/255.0 blue:18.0/255.0 alpha:1];
        aboutText.backgroundColor = [UIColor whiteColor];
        aboutText.textAlignment = NSTextAlignmentLeft;
        aboutText.minimumScaleFactor = 0.5;
        [aboutText sizeToFit];
        [super.scrollview addSubview:aboutText];
        
        y = y + 60;
        
        UILabel *bodyText = [[UILabel alloc] initWithFrame:CGRectMake(25, y, super.scrollview.bounds.size.width - 40, 0)];
        bodyText.text = NSLocalizedString(@"about_body", "about_body");
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
        [learnMoreButton setTitle:NSLocalizedString(@"white_paper_button", "white_paper_button") forState:normal];
        [learnMoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [learnMoreButton addTarget:self action:@selector(openSafari)forControlEvents:UIControlEventTouchUpInside];
        learnMoreButton.tag = 2;
        [super.scrollview addSubview:learnMoreButton];
        
        NSLog(@"super.scrollview.contentSize.height before: %f", super.scrollview.contentSize.height);
        super.scrollview.contentSize = CGSizeMake(frame.size.width, y + 125);
        NSLog(@"super.scrollview.contentSize.height after: %f", super.scrollview.contentSize.height);
    }
    
    
    
    return self;
}

- (void)openSafari {
    UIApplication *mySafari = [UIApplication sharedApplication];
    NSURL *myURL = [[NSURL alloc] initWithString:@"http://www.http://realityblu.com"];
    [mySafari openURL:myURL];
}


@end
