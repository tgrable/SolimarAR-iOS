//
//  SplashView.h
//  SolimarWT
//
//  Created by Timothy C Grable on 2/2/17.
//  Copyright © 2017 Trekk Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuProtocolPartDeux;

@protocol MenuProtocolPartDeux <NSObject>

@required
- (void)menuClosed;
- (void)menuItemPressed:(NSInteger)tag;
@end

@interface SplashView : UIView

@property (weak, nonatomic) id <MenuProtocolPartDeux> delegate;

@end
