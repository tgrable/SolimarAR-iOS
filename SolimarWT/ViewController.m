//
//  ViewController.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/7/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "Menu.h"

@interface ViewController () <MenuProtocol> {
    BOOL navWindowIsOpen;
    NSInteger mainVCtag;
    int count;
}

@property (weak, nonatomic) IBOutlet UIButton   *goButton;
@property (strong, nonatomic) Menu              *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int y = 65;
    if (![(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            y = 45;
        }
    }
    
    navWindowIsOpen = false;
    
    [self setButtonAttributes];
    [self buildMenu:y];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Handle device rotation
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

- (void)dealloc {
    /* Remove this view controller from the default Notification Center so that it can be released properly */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buildMenu:(int)atYLocation {
    float bsHeight = self.view.bounds.size.height;
    
    if ([(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        if (count > 0) {
            if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
                bsHeight = 1024;
            }
            else {
                bsHeight = 768;
            }
            
        }
    }
    
    int xLocaion = self.view.bounds.size.width * -1;
    if (navWindowIsOpen == YES) {
        xLocaion = 0;
    }
    
    float width = self.view.bounds.size.width;
    if ([(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        width = self.view.bounds.size.width / 2;
    }
    
    _menu = [[Menu alloc] initWithFrame:CGRectMake(xLocaion, atYLocation, width, bsHeight)];
    _menu.delegate = self;
    [self.view addSubview:_menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - View Rotation
- (void)orientationChanged:(NSNotification *)note {
    count++;
    
    UIDevice *device = note.object;
    switch(device.orientation) {
    case UIDeviceOrientationPortrait:
        [self updateViews:UIDeviceOrientationPortrait];
        break;
    case UIDeviceOrientationLandscapeLeft:
        [self updateViews:UIDeviceOrientationLandscapeLeft];
        break;
    case UIDeviceOrientationLandscapeRight:
        [self updateViews:UIDeviceOrientationLandscapeRight];
        break;
    default:
        break;
    };
}

- (void)updateViews:(int)orientation {
    int y = 65;
    if (![(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            y = 45;
        }
    }
    
    [_menu removeFromSuperview];
    [self buildMenu:y];
}

- (void)setButtonAttributes {
    _goButton.tag = 0;
    [_goButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [_goButton.layer setBorderWidth:1.0];
}

- (IBAction)navigateToMainView:(UIButton *)sender {
    [self showHideNavigation];
}

#pragma mark -
#pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if (mainVCtag != 0) {
         MainViewController *mainVC = segue.destinationViewController;
         mainVC.tag = mainVCtag;
         mainVC.isComingFromARView = NO;
     }
     
 }

- (void)showHideNavigation {
    
    navWindowIsOpen = (navWindowIsOpen) ? NO : YES;
    
    float y = 65;
    if (![(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            y = 45;
        }
    }

    float w = self.view.bounds.size.width;
    
    //Set x location off the screen on the left side
    int x = self.view.bounds.size.width * -1;
    
    //if navigation view is not currently visible set x location
    //to 0 so the menu view is visible
    if (_menu.frame.origin.x != 0) {
        x = 0;
    }
    
    //Animate the view in and out of view
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [_menu setFrame:CGRectMake(x, y, w, self.view.bounds.size.height)];
    } completion:nil];
}

- (void)menuClosed {
    [self showHideNavigation];
}
- (IBAction)goToARView:(UIButton *)sender {
    mainVCtag = 0;
    [self performSegueWithIdentifier:@"showDownloadView" sender:self];
}

- (void)menuItemPressed:(NSInteger)tag {
    [self showHideNavigation];
    mainVCtag = tag;
    
    if (tag == 0) {
        [self performSegueWithIdentifier:@"showDownloadView" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"showMainContent" sender:self];
    }
}


@end
