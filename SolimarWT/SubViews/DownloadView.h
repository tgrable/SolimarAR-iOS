//
//  DownloadView.h
//  SolimarWT
//
//  Created by Timothy C Grable on 12/8/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DownloadProtocol;

@protocol DownloadProtocol <NSObject>

@required
- (void)shareMarkerImages:(UIImage *)image;
- (void)shareMarkerFile:(NSURL *)urlToFile;
- (void)playVideo:(int)tag;
@end

@interface DownloadView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *markerImageCells;
@property (strong, nonatomic) NSArray *cellIcons;
@property (strong, nonatomic) NSArray *bodyText;
@property (strong, nonatomic) NSArray *aboutText;



@property (weak, nonatomic) id <DownloadProtocol> delegate;

@end
