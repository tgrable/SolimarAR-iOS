//
//  BaseView.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/7/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollview.showsVerticalScrollIndicator = YES;
        _scrollview.scrollEnabled = YES;
        _scrollview.userInteractionEnabled = YES;
        [_scrollview setBackgroundColor: [UIColor whiteColor]];
        [self addSubview:_scrollview];
        
        UIImage *headerImage = [UIImage imageNamed:@"bkgrd-hdr"];
        UIImageView *companyHeaderImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 200)];
        companyHeaderImage.image = headerImage;
        [companyHeaderImage setBackgroundColor:[UIColor clearColor]];
        [_scrollview addSubview:companyHeaderImage];
    }
    
    return self;
}

@end
