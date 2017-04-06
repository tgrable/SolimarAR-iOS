//
//  DownloadView.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/8/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import "DownloadView.h"
#import "MarkerCell.h"

@implementation DownloadView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 1;
        self.frame = frame;
        
        _markerImageCells = [[NSArray alloc] initWithObjects:@"front1", @"front2", @"front3", /*@"front4",*/ @"front5", nil];
        _cellIcons = [[NSArray alloc] initWithObjects:@"Solibank-icon", @"Solibank_Videoicon", @"zoobrewmarker", /*@"ZooBrew_VideoIcon",*/ @"TREKK_verticalicon" , nil];
        _bodyText = [[NSArray alloc] initWithObjects:@"Download", nil];
        _aboutText = [[NSArray alloc] initWithObjects:@"SOLibank AR Statements", @"Watch Variable AR Video", @"Zoo Brew AR Mailers", /*@"Watch Variable AR Video",*/ @"View AR Platform Video",nil];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumLineSpacing = 30;
        layout.itemSize = CGSizeMake(frame.size.width, 150);
       
        CGRect newFrame = CGRectMake(0, 0.0, frame.size.width, CGRectGetHeight(frame) - 35);
        _collectionView = [[UICollectionView alloc] initWithFrame:newFrame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
//        _collectionView.backgroundColor = [UIColor redColor];
        [_collectionView registerClass:MarkerCell.self forCellWithReuseIdentifier:@"Cell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        [self addSubview:_collectionView];
        

    }
    
    return self;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _markerImageCells.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MarkerCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    long row = [indexPath row];
    
//    UIImage *image = [UIImage imageNamed:_markerImageCells[row]];
//    myCell.backgroundImage.image = image;
    
    UIImage *icon = [UIImage imageNamed:_cellIcons[row]];
    myCell.iconView.image = icon;
    
    NSString *aboutText = [[NSString alloc]initWithString:_aboutText[row]];
    myCell.bodyText.text = aboutText;
    
    if (row == 0 || row == 2){
        myCell.downloadText.text = @"Download:";
        myCell.overlayButtonEu.hidden = false;
        myCell.overlayButtonUs.hidden = false;
        myCell.overlayButtonUs.tag = 0;
        myCell.overlayButtonEu.tag = 1;
        [myCell.overlayButtonUs addTarget:self action:@selector(showMarkerSheet:)forControlEvents:UIControlEventTouchUpInside];
        [myCell.overlayButtonEu addTarget:self action:@selector(showMarkerSheet:)forControlEvents:UIControlEventTouchUpInside];
        
        
        if (row == 2){
            myCell.overlayButtonUs.tag = 3;
            myCell.overlayButtonUs.hidden = false;
            myCell.overlayButtonEu.hidden = true;
        }
    }else {
        myCell.downloadText.text = @"";
        myCell.overlayButtonEu.hidden = true;
        myCell.overlayButtonUs.hidden = true;
        [myCell.overlayButtonUs addTarget:self action:@selector(showMarkerSheet:)forControlEvents:UIControlEventTouchUpInside];
    }
    

    
    
    return myCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self printMarkerImage:indexPath.row];
    NSLog(@"%li", (long)indexPath.row);
    if (indexPath.row == 1){
        [_delegate playVideo:16];
    }
    
    if (indexPath.row == 3){
        [_delegate playVideo:9];
    }
    
//    if (indexPath.row == 4){ // wtf was this doing here?
//        [_delegate playVideo:16];
//    }
    
}

- (void)printMarkerImage:(NSInteger)markerImage {
    UIImage *image = [UIImage imageNamed:_markerImageCells[markerImage]];
    [_delegate shareMarkerImages:image];
}

- (void)showMarkerSheet:(UIButton *)sender {
    NSLog(@"sender.tag: %ld", (long)sender.tag);
    NSString *path = @"";
    switch (sender.tag) {
        case 0:
            path = [[NSBundle mainBundle] pathForResource:@"SolibankStatements" ofType:@"pdf"];
        case 1:
            path = [[NSBundle mainBundle] pathForResource:@"SolibankStatementsEU" ofType:@"pdf"];
            break;
        case 3:
            path = [[NSBundle mainBundle] pathForResource:@"Xerox_zoobrewMarkersComplete" ofType:@"pdf"];
            break;
        case 4:
            //            path = [[NSBundle mainBundle] pathForResource:@"Xerox_zoobrewMarkersComplete" ofType:@"pdf"];
            NSLog(@"Need EU Versions");
            break;
            
        default:
            path = [[NSBundle mainBundle] pathForResource:@"SolibankStatements" ofType:@"pdf"];
            break;
    }
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    [_delegate shareMarkerFile:fileURL];
}

- (void)playLocalVideo:(UIButton *)sender {
    int videoTag;
    switch (sender.tag) {
        case 1:
            videoTag = 16;
            break;
        case 3:
            videoTag = 10;
            break;
        case 6:
            videoTag = 9;
            break;
        default:
            videoTag = 11;
            break;
    }
    [_delegate playVideo:videoTag];
}

@end
