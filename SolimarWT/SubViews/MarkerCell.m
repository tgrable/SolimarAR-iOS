//
//  MarkerCell.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/8/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import "MarkerCell.h"

@implementation MarkerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
//        _backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, frame.size.width - 2, frame.size.height - 4)];
//        _backgroundImage.contentMode = UIViewContentModeScaleAspectFit;
//        _backgroundImage.clipsToBounds = YES;
//        [self addSubview:_backgroundImage];
        
        // FIXME: These positions are temporary, fixy comes later.
        
        
        self.backgroundColor = [UIColor clearColor];
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20,0, 75,150)];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_iconView];
        
//        _bodyText = [[UILabel alloc] initWithFrame:CGRectMake(_iconView.frame.origin.x + _iconView.frame.size.width + 20 , 20, frame.size.width - 60, 34)];
        _bodyText = [[UILabel alloc] initWithFrame:CGRectMake(_iconView.frame.origin.x + _iconView.frame.size.width + 20, 25, CGRectGetWidth(frame) - 160, 34)];
        [_bodyText setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:18.0f]];
        _bodyText.textColor = [UIColor colorWithRed:241.0/255.0 green:100.0/255.0 blue:18.0/255.0 alpha:1];
        _bodyText.backgroundColor = [UIColor clearColor];
        _bodyText.textAlignment = NSTextAlignmentLeft;
        _bodyText.numberOfLines = 0;
        _bodyText.adjustsFontSizeToFitWidth = true;
        _bodyText.text = @"Test Text";
//        [_bodyText sizeToFit];.
        [self addSubview:_bodyText];
        
        _downloadText = [[UILabel alloc] initWithFrame:CGRectMake(_iconView.frame.origin.x + _iconView.frame.size.width + 20, 50, frame.size.width - 60, 34)];
        [_downloadText setFont:[UIFont fontWithName:NSLocalizedString(@"font_name", "font_name") size:14.0f]];
        _downloadText.textColor = [UIColor colorWithRed:241.0/255.0 green:100.0/255.0 blue:18.0/255.0 alpha:1];
        _downloadText.backgroundColor = [UIColor clearColor];
        _downloadText.textAlignment = NSTextAlignmentLeft;
        _downloadText.numberOfLines = 0;
//        _downloadText.text = @"Download";
//        [_downloadText sizeToFit];
        [self addSubview:_downloadText];
        
//        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, frame.size.width/8, frame.size.height/4)];
//        _iconView.contentMode = UIViewContentModeScaleAspectFit;
//        
//        [self addSubview:_iconView];
        
        
//        if (_downloadButtonsNeeded){
            float usButtonLocation = 215;
            float euButtonLocation = 285;
            
            if (self.frame.size.width == 320) {
                usButtonLocation = 195;
                euButtonLocation = 245;
            }
            
            UIImage *btnImageUs = [UIImage imageNamed:@"US-Icon"];
            _overlayButtonUs = [UIButton buttonWithType:UIButtonTypeCustom];
            [_overlayButtonUs setFrame:CGRectMake(usButtonLocation, _downloadText.frame.origin.y + 5, 45, 30)];
            [_overlayButtonUs setImage:btnImageUs forState:UIControlStateNormal];
//            overlayButtonUs.tag = 0;
//            [overlayButtonUs addTarget:self action:@selector(showMarkerSheet:)forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_overlayButtonUs];
            
            
            UIImage *btnImageEu = [UIImage imageNamed:@"EU-Icon"];
            _overlayButtonEu = [UIButton buttonWithType:UIButtonTypeCustom];
            [_overlayButtonEu setFrame:CGRectMake(euButtonLocation, _downloadText.frame.origin.y + 5, 45, 30)];
            [_overlayButtonEu setImage:btnImageEu forState:UIControlStateNormal];
            _overlayButtonEu.backgroundColor = [UIColor clearColor];
//            overlayButtonEu.tag = 1;
//            [overlayButtonEu addTarget:self action:@selector(showMarkerSheet:)forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_overlayButtonEu];
//        }
        
        

        
        
    }
    
    return self;
}

@end
