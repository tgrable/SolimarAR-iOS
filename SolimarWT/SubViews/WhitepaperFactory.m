//
//  WhitepaperFactory.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/7/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import "WhitepaperFactory.h"

@implementation WhitepaperFactory

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 1;
        
        UIImage *headerLogoImage = [UIImage imageNamed:NSLocalizedString(@"chemistry_logo", "chemistry_logo")];
        UIImageView *headerLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50, 120, 120)];
        headerLogoImageView.image = headerLogoImage;
        [headerLogoImageView setBackgroundColor:[UIColor clearColor]];
        [super.scrollview addSubview:headerLogoImageView];
        
        int y = 210;
        
        UILabel *headerText = [[UILabel alloc] initWithFrame:CGRectMake(25, y, super.scrollview.bounds.size.width - 40, 50)];
        headerText.text = NSLocalizedString(@"white_paper_header", "white_paper_header");
        [headerText setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:24.0f]];
        headerText.textColor = [UIColor colorWithRed:241.0/255.0 green:100.0/255.0 blue:18.0/255.0 alpha:1];
        headerText.backgroundColor = [UIColor whiteColor];
        headerText.textAlignment = NSTextAlignmentLeft;
        [super.scrollview addSubview:headerText];
        
        y = y + headerText.bounds.size.height + 10;
        
        UILabel *bodyText = [[UILabel alloc] initWithFrame:CGRectMake(25, y, super.scrollview.bounds.size.width - 40, 0)];
        bodyText.text = NSLocalizedString(@"white_paper_body", "white_paper_body");
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
        
        super.scrollview.contentSize = CGSizeMake(frame.size.width, y + learnMoreButton.bounds.size.height + 100);
    }
    
    return self;
}

- (void)openSafari {
    UIApplication *mySafari = [UIApplication sharedApplication];
    NSURL *myURL = [[NSURL alloc] initWithString:@"http://content.solimarsystems.com/pdf/Chemistry-CCM-Platform.pdf"];
    [mySafari openURL:myURL];
}

@end
