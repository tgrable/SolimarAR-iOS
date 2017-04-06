//
//  SplashView.m
//  SolimarWT
//
//  Created by Timothy C Grable on 2/2/17.
//  Copyright © 2017 Trekk Design. All rights reserved.
//

#import "SplashView.h"

@implementation SplashView

#define SOLIMARBLUE [UIColor colorWithRed:0/256.0 green:131/256.0 blue:117/256.0 alpha:1.0]

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect screen = [[UIScreen mainScreen] bounds];
        CGFloat width = CGRectGetWidth(screen);
        
        UIImage *backgroundImage = [UIImage imageNamed:@"bkgrd-fullscreen"];
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, frame.size.height)];
        backgroundImageView.image = backgroundImage;
        [backgroundImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:backgroundImageView];
        
        UIImage *solimarLogoImage = [UIImage imageNamed:@"solimar-logo-white"];
        UIImageView *solimarLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((width / 2) - 125, 55, 250, 60)];
//         UIImageView *solimarLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((width / 2), 55, 250, 60)];
        solimarLogoImageView.image = solimarLogoImage;
        [solimarLogoImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:solimarLogoImageView];
        
        UILabel *aboutText = [[UILabel alloc] initWithFrame:CGRectMake(25, 150, width - 35, 0)];
        aboutText.text = @"Explore all of the ways Solimar delivers future-ready solutions to businesses across industries.  Look for the Solimar AR icon.";
        [aboutText setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:16.0f]];
        
        aboutText.textColor = [UIColor whiteColor];
//        aboutText.adjustsFontSizeToFitWidth = true;

//        [aboutText setCenter:]
//        aboutText.center.x = frame.size.width/2;
        aboutText.backgroundColor = [UIColor clearColor];
        aboutText.textAlignment = NSTextAlignmentCenter;
        aboutText.numberOfLines = 0;
        [aboutText sizeToFit];
        [self addSubview:aboutText];
        
        UIButton *goButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [goButton setFrame:CGRectMake((frame.size.width / 2) - 75, aboutText.frame.size.height + (aboutText.frame.size.height * 1.65) , 150, 50)];
        [goButton setFrame:CGRectMake((frame.size.width / 2) - 75, frame.size.height - (frame.size.height * 0.35) , 150, 50)];
        goButton.backgroundColor = SOLIMARBLUE;
        goButton.titleLabel.textColor = [UIColor whiteColor];
        goButton.tag = 1; 
        [goButton setTitle:@"GO" forState:UIControlStateNormal];
        [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [goButton addTarget:self action:@selector(menuItem:)forControlEvents:UIControlEventTouchUpInside];
        [[goButton layer] setBorderWidth:2.0f];
        [[goButton layer] setBorderColor:[UIColor whiteColor].CGColor];
        goButton.tag = 0;
        [self addSubview:goButton];
        
       
    }
    
    return self;
}

- (void)menuItem:(UIButton *)sender {
    NSLog(@"GO BUTTON TAPPED"); 
    [_delegate menuItemPressed:sender.tag];
}

@end
