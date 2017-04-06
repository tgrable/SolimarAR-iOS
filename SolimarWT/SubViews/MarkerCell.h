//
//  MarkerCell.h
//  SolimarWT
//
//  Created by Timothy C Grable on 12/8/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkerCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *backgroundImage;
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *bodyText;
@property (strong, nonatomic) UILabel *downloadText;
@property (strong, nonatomic) UIImageView *domesticDownloadImage;
@property (strong, nonatomic) UIImageView *euroDownloadImage;
@property (strong, nonatomic) UIButton *overlayButtonUs;
@property (strong, nonatomic) UIButton *overlayButtonEu;
//@property (nonatomic, assign) BOOL *downloadButtonsNeeded;


@end
