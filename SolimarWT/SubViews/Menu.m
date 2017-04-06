//
//  Menu.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/9/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import "Menu.h"

@implementation Menu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 1;
	
        float width = frame.size.width;
        if (frame.size.width > frame.size.height) {
            width = frame.size.width / 2;
        }

//        self.backgroundColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
        
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(respondToSwipeGesture:)];
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipe];
        
        UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollview.showsVerticalScrollIndicator = YES;
        scrollview.scrollEnabled = YES;
        scrollview.userInteractionEnabled = YES;
        [scrollview setBackgroundColor: [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1]];
        [self addSubview:scrollview];
        
        int y = 25;
        
        UIButton *arBrowserButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [arBrowserButton setFrame:CGRectMake(0, y, width, 28)];
        arBrowserButton.backgroundColor = [UIColor clearColor];
        arBrowserButton.showsTouchWhenHighlighted = YES;
        arBrowserButton.titleLabel.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:22.0f];
        [arBrowserButton setTitle:NSLocalizedString(@"menu_ar", "menu_ar") forState:normal];
        [arBrowserButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [arBrowserButton addTarget:self action:@selector(menuItem:)forControlEvents:UIControlEventTouchUpInside];
        arBrowserButton.tag = 0;
        arBrowserButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [scrollview addSubview:arBrowserButton];
        
        y = y + 34;
  
        UIView *arDivider = [[UIView alloc] initWithFrame:CGRectMake(20, y, width - 40, 2)];
        arDivider.backgroundColor = [UIColor whiteColor];
        [scrollview addSubview:arDivider];
        
        y = y + 7;
        
        UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadButton setFrame:CGRectMake(0, y, width, 28)];
        downloadButton.backgroundColor = [UIColor clearColor];
        downloadButton.showsTouchWhenHighlighted = YES;
        downloadButton.titleLabel.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:22.0f];
        [downloadButton setTitle:NSLocalizedString(@"menu_download", "menu_download") forState:normal];
        [downloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [downloadButton addTarget:self action:@selector(menuItem:)forControlEvents:UIControlEventTouchUpInside];
        downloadButton.tag = 1;
        downloadButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [scrollview addSubview:downloadButton];
        
        y = y + 35;
        
        UIView *dlDivider = [[UIView alloc] initWithFrame:CGRectMake(20, y, width - 40, 2)];
        dlDivider.backgroundColor = [UIColor whiteColor];
        [scrollview addSubview:dlDivider];
        
        y = y + 7;
        
        UIButton *whitePaperButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [whitePaperButton setFrame:CGRectMake(0, y, width, 28)];
        whitePaperButton.backgroundColor = [UIColor clearColor];
        whitePaperButton.showsTouchWhenHighlighted = YES;
        whitePaperButton.titleLabel.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:22.0f];
        [whitePaperButton setTitle:NSLocalizedString(@"menu_white_paper", "menu_white_paper") forState:normal];
        [whitePaperButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [whitePaperButton addTarget:self action:@selector(menuItem:)forControlEvents:UIControlEventTouchUpInside];
        whitePaperButton.tag = 2;
        whitePaperButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [scrollview addSubview:whitePaperButton];
        
        y = y + 35;
        
        UIView *wpDivider = [[UIView alloc] initWithFrame:CGRectMake(20, y, width - 40, 2)];
        wpDivider.backgroundColor = [UIColor whiteColor];
        [scrollview addSubview:wpDivider];
        
        y = y + 7;
        
        UIButton *messagingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [messagingButton setFrame:CGRectMake(0, y, width, 28)];
        messagingButton.backgroundColor = [UIColor clearColor];
        messagingButton.showsTouchWhenHighlighted = YES;
        messagingButton.titleLabel.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:22.0f];
        [messagingButton setTitle:NSLocalizedString(@"menu_messaging", "menu_messaging") forState:normal];
        [messagingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [messagingButton addTarget:self action:@selector(menuItem:)forControlEvents:UIControlEventTouchUpInside];
        messagingButton.tag = 3;
        messagingButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [scrollview addSubview:messagingButton];
        
        y = y + 35;
        
        UIView *msDivider = [[UIView alloc] initWithFrame:CGRectMake(20, y, width - 40, 2)];
        msDivider.backgroundColor = [UIColor whiteColor];
        [scrollview addSubview:msDivider];
        
        y = y + 7;
        
        UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aboutButton setFrame:CGRectMake(0, y, width, 28)];
        aboutButton.backgroundColor = [UIColor clearColor];
        aboutButton.showsTouchWhenHighlighted = YES;
        aboutButton.titleLabel.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:22.0f];
        [aboutButton setTitle:NSLocalizedString(@"menu_about", "menu_about") forState:normal];
        [aboutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [aboutButton addTarget:self action:@selector(menuItem:)forControlEvents:UIControlEventTouchUpInside];
        aboutButton.tag = 4;
        aboutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [scrollview addSubview:aboutButton];
        
        y = y + 35;
        
        UIView *abDivider = [[UIView alloc] initWithFrame:CGRectMake(20, y, width - 40, 2)];
        abDivider.backgroundColor = [UIColor whiteColor];
        [scrollview addSubview:abDivider];
        
        y = y + 7;
        
        UIButton *contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [contactButton setFrame:CGRectMake(0, y, width, 28)];
        contactButton.backgroundColor = [UIColor clearColor];
        contactButton.showsTouchWhenHighlighted = YES;
        contactButton.titleLabel.font = [UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:22.0f];
        [contactButton setTitle:NSLocalizedString(@"menu_contact", "menu_contact") forState:normal];
        [contactButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [contactButton addTarget:self action:@selector(menuItem:)forControlEvents:UIControlEventTouchUpInside];
        contactButton.tag = 5;
        contactButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [scrollview addSubview:contactButton];
        
        y = y + 35;
        float arLogoXLocation = (frame.size.width - 250) / 2;
        float solimarLogoXLocation = (self.frame.size.width - 254) / 2;
        
        if (![(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
            if (frame.size.width > frame.size.height) {
                arLogoXLocation = frame.size.width / 2;
                solimarLogoXLocation = frame.size.width / 2;
                y = 25;
            }
        }
        
        UIImage *arLogo = [UIImage imageNamed:NSLocalizedString(@"menu_logo", "menu_logo")];
        UIImageView *arLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(arLogoXLocation, y, 250, 250)];
        arLogoView.image = arLogo;
        arLogoView.backgroundColor = [UIColor clearColor];
        arLogoView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollview addSubview:arLogoView];
        
        y = y + 275;
        
        UIImage *solimarLogo = [UIImage imageNamed:NSLocalizedString(@"menu_solimar_logo", "menu_solimar_logo")];
        UIImageView *solimarLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(solimarLogoXLocation, y, 255, 60)];
        solimarLogoView.image = solimarLogo;
        solimarLogoView.backgroundColor = [UIColor clearColor];
        solimarLogoView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollview addSubview:solimarLogoView];
        
        y = y + 65;
        
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, frame.size.width, 15)];
        bottomLabel.text = NSLocalizedString(@"menu_footer", "menu_footer");
        [bottomLabel setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:12.0f]];
        bottomLabel.textColor = [UIColor whiteColor];
        bottomLabel.backgroundColor = [UIColor clearColor];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        [scrollview addSubview:bottomLabel];

        y = y + 45;
        
        scrollview.contentSize = CGSizeMake(frame.size.width, y + 50);
    }
    
    return self;
}

#pragma mark -
#pragma mark - MenuProtocol Delegates
- (void)menuItem:(UIButton *)sender {
    [_delegate menuItemPressed:sender.tag];
}

- (void)respondToSwipeGesture:(UIGestureRecognizer *)gesture {
    [_delegate menuClosed];
}

@end
