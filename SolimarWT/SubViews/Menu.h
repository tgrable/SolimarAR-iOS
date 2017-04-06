//
//  Menu.h
//  SolimarWT
//
//  Created by Timothy C Grable on 12/9/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuProtocol;

@protocol MenuProtocol <NSObject>

@required
- (void)menuClosed;
- (void)menuItemPressed:(NSInteger)tag;
@end

@interface Menu : UIView

@property (weak, nonatomic) id <MenuProtocol> delegate;

@end
