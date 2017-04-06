//
//  DownloadViewController.m
//  SolimarWT
//
//  Created by Timothy C Grable on 2/2/17.
//  Copyright © 2017 Trekk Design. All rights reserved.
//

#import "AppDelegate.h"
#import "DownloadViewController.h"
#import "Menu.h"
#import "MainViewController.h"
#import <WikitudeSDK/WikitudeSDK.h>
#import <WikitudeSDK/WTArchitectView.h>
#import <WikitudeSDK/WTArchitectViewDebugDelegate.h>
#import "Reachability.h"

@interface DownloadViewController () <WTArchitectViewDelegate, WTArchitectViewDebugDelegate>{
    BOOL navWindowIsOpen;
    int count;
    int menuItemPressed;
}

@property (weak, nonatomic) IBOutlet UIView *viewHolder;
@property (nonatomic, strong) WTArchitectView *architectView;
@property (nonatomic, weak) WTNavigation *architectWorldNavigation;
@property (strong, nonatomic) Menu              *menu;

@end

@implementation DownloadViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"TimGrable Reachbility: %ld", (long)[[Reachability reachabilityForInternetConnection] currentReachabilityStatus]);
    
    int y = 65;
    if (![(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            y = 45;
        }
    }
    
    navWindowIsOpen = false;
    
    NSError *deviceNotSupportedError = nil;
    CGRect newFrame = CGRectMake(0.0, 0.0, _viewHolder.bounds.size.width, _viewHolder.bounds.size.height);
    
    if ( [WTArchitectView isDeviceSupportedForRequiredFeatures:WTFeature_Geo | WTFeature_ImageTracking error:&deviceNotSupportedError] ) {
        self.architectView = [[WTArchitectView alloc] initWithFrame:newFrame motionManager:nil];
        self.architectView.delegate = self;
        [self.architectView setLicenseKey:NSLocalizedString(@"production_key_6", "production_key_6")];
        
        /* The Architect World can be loaded independently from the WTArchitectView rendering.
         
         NOTE: The architectWorldNavigation property is assigned at this point. The navigation object is valid until another Architect World is loaded.
         */
        
        //TODO: This is for offline use. Make sure to change for production versions
//        self.architectWorldNavigation = [self.architectView loadArchitectWorldFromURL:[[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:@"assets"] withRequiredFeatures:WTFeature_2DTracking];
        
        NSURL *url = [NSURL URLWithString:@"http://ea446c1ef68180add20e-aba1a2077e7f12669f9354e359b7de31.r89.cf2.rackcdn.com/index.html"];
        self.architectWorldNavigation = [self.architectView loadArchitectWorldFromURL:url withRequiredFeatures:WTFeature_ImageTracking];
        
        /* Because the WTArchitectView does some OpenGL rendering, frame updates have to be suspended and resumend when the application changes it's active state.
         Here, UIApplication notifications are used to respond to the active state changes.
         
         NOTE: Since the application will resign active even when an UIAlert is shown, some special handling is implemented in the UIApplicationDidBecomeActiveNotification.
         */
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            
            /* When the application starts for the first time, several UIAlert's might be shown to ask the user for camera and/or GPS access.
             Because the WTArchitectView is paused when the application resigns active (See line 86), also Architect JavaScript evaluation is interrupted.
             To resume properly from the inactive state, the Architect World has to be reloaded if and only if an active Architect World load request was active at the time the application resigned active.
             This loading state/interruption can be detected using the navigation object that was returned from the -loadArchitectWorldFromURL:withRequiredFeatures method.
             */
            if (self.architectWorldNavigation.wasInterrupted) {
                [self.architectView reloadArchitectWorld];
            }
            
            /* Standard WTArchitectView rendering resuming after the application becomes active again */
            [self startWikitudeSDKRendering];
        }];
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            
            /* Standard WTArchitectView rendering suspension when the application resignes active */
            [self stopWikitudeSDKRendering];
        }];
        [_viewHolder addSubview:self.architectView];
    } else {
        NSLog(@"device is not supported - reason: %@", [deviceNotSupportedError localizedDescription]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /* WTArchitectView rendering is started once the view controllers view will appear */
    [self startWikitudeSDKRendering];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        /* Standard WTArchitectView rendering suspension when the application resignes active */
        [self stopWikitudeSDKRendering];
    });
}

- (void)dealloc {
    /* Remove this view controller from the default Notification Center so that it can be released properly */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    /* When the device orientation changes, specify if the WTArchitectView object should rotate as well */
    [self.architectView setShouldRotate:YES toInterfaceOrientation:toInterfaceOrientation];
}

#pragma mark -
#pragma mark - Private Methods
/* Convenience methods to manage WTArchitectView rendering. */
- (void)startWikitudeSDKRendering{
    
    /* To check if the WTArchitectView is currently rendering, the isRunning property can be used */
    if ( ![self.architectView isRunning] ) {
        
        /* To start WTArchitectView rendering and control the startup phase, the -start:completion method can be used */
        [self.architectView start:^(WTStartupConfiguration *configuration) {
            
            /* Use the configuration object to take control about the WTArchitectView startup phase */
            /* You can e.g. start with an active front camera instead of the default back camera */
            
            // configuration.captureDevicePosition = AVCaptureDevicePositionFront;
            
        } completion:^(BOOL isRunning, NSError *error) {
            
            /* The completion block is called right after the internal start method returns.
             
             NOTE: In case some requirements are not given, the WTArchitectView might not be started and returns NO for isRunning.
             To determine what caused the problem, the localized error description can be used.
             */
            if ( !isRunning ) {
                NSLog(@"WTArchitectView could not be started. Reason: %@", [error localizedDescription]);
            }
        }];
    }
}

- (void)stopWikitudeSDKRendering {
    /* The stop method is blocking until the rendering and camera access is stopped */
    if ( [self.architectView isRunning] ) {
        [self.architectView stop];
    }
}

/* The WTArchitectView provides two delegates to interact with. */
#pragma mark -
#pragma mark - Delegation
/* The standard delegate can be used to get information about:
 * The Architect World loading progress
 * architectsdk:// protocol invocations using document.location inside JavaScript
 * Managing view capturing
 * Customizing view controller presentation that is triggered from the WTArchitectView
 */

#pragma mark -
#pragma mark - WTArchitectViewDelegate
- (void)architectView:(WTArchitectView *)architectView didFinishLoadArchitectWorldNavigation:(WTNavigation *)navigation {
    /* Architect World did finish loading */
}

- (void)architectView:(WTArchitectView *)architectView didFailToLoadArchitectWorldNavigation:(WTNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"Architect World from URL '%@' could not be loaded. Reason: %@", navigation.originalURL, [error localizedDescription]);
}

/* The debug delegate can be used to respond to internal issues, e.g. the user declined camera or GPS access.
 
 NOTE: The debug delegate method -architectView:didEncounterInternalWarning is currently not used.
 */
#pragma mark -
#pragma mark - WTArchitectViewDebugDelegate
- (void)architectView:(WTArchitectView *)architectView didEncounterInternalWarning:(WTWarning *)warning {
    /* Intentionally Left Blank */
    NSLog(@"TimGrable architectView didEncounterInternalWarning");
}

- (void)architectView:(WTArchitectView *)architectView didEncounterInternalError:(NSError *)error {
    
    NSLog(@"WTArchitectView encountered an internal error '%@'", [error localizedDescription]);
}

#pragma mark -
#pragma mark - Notifications
/* UIApplication specific notifications are used to pause/resume the architect view rendering */
- (void)didReceiveApplicationWillResignActiveNotification:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        /* Standard WTArchitectView rendering suspension when the application resignes active */
        [self stopWikitudeSDKRendering];
    });
}

- (void)didReceiveApplicationDidBecomeActiveNotification:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        /* When the application starts for the first time, several UIAlert's might be shown to ask the user for camera and/or GPS access.
         Because the WTArchitectView is paused when the application resigns active (See line 86), also Architect JavaScript evaluation is interrupted.
         To resume properly from the inactive state, the Architect World has to be reloaded if and only if an active Architect World load request was active at the time the application resigned active.
         This loading state/interruption can be detected using the navigation object that was returned from the -loadArchitectWorldFromURL:withRequiredFeatures method.
         */
        if ( self.architectWorldNavigation.wasInterrupted )
        {
            [self.architectView reloadArchitectWorld];
        }
        
        /* Standard WTArchitectView rendering resuming after the application becomes active again */
        [self startWikitudeSDKRendering];
    });
}

#pragma mark -
#pragma mark - invokedURL
/* invokedURL is used for navigation elements invoked inside of the HTML layer */
- (void)architectView:(WTArchitectView *)architectView invokedURL:(NSURL *)URL {
    UIApplication *mySafari = [UIApplication sharedApplication];
    NSURL *myURL = [[NSURL alloc] init];
    
    if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"callNow"].location != NSNotFound) {
        myURL = [NSURL URLWithString:@"tel://12025550189"];
        [mySafari openURL:myURL];
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"payOnlineSean"].location != NSNotFound) {
        [self openUrl:@"http://solibank.solimarsystems.com/pay.html?agent=sc"];
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"payOnlineDaniel"].location != NSNotFound) {
        [self openUrl:@"http://solibank.solimarsystems.com/pay.html?agent=dc"];
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"payOnlinePierce"].location != NSNotFound) {
        [self openUrl:@"http://solibank.solimarsystems.com/pay.html?agent=pb"];;
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"payOnlineTim"].location != NSNotFound) {
        [self openUrl:@"http://solibank.solimarsystems.com/pay.html?agent=td"];
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"purchaseTicketsCatsImg"].location != NSNotFound) {
        [self openUrl:@"https://9014864196768820fd6d-15bdba93daeed65e73394e3bb30e73c3.ssl.cf2.rackcdn.com/john/index.html"];
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"purchaseTicketsMonkeyImg"].location != NSNotFound) {
        [self openUrl:@"https://9014864196768820fd6d-15bdba93daeed65e73394e3bb30e73c3.ssl.cf2.rackcdn.com/mary/index.html"];
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"purchaseTicketsElephantImg"].location != NSNotFound) {
        [self openUrl:@"https://9014864196768820fd6d-15bdba93daeed65e73394e3bb30e73c3.ssl.cf2.rackcdn.com/carrie/index.html"];
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"javaJoesImg"].location != NSNotFound) {
        UIImage *javajoeImg = [UIImage imageNamed:@"javajoescoupon"];
        [self shareMarkerImages:javajoeImg];
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"acmeautocoupon"].location != NSNotFound) {
        UIImage *acmeImg = [UIImage imageNamed:@"acmeautocoupon"];
        [self shareMarkerImages:acmeImg];
    }
    else if ([[NSString stringWithFormat:@"%@", URL] rangeOfString:@"carawaycoutreMarkerImg"].location != NSNotFound) {
        UIImage *carawayImg = [UIImage imageNamed:@"carawaycoupon"];
        [self shareMarkerImages:carawayImg];
    }
    else {
        
    }
}

- (void)shareMarkerImages:(UIImage *)image {
    
    NSMutableArray *itemsToShare = [NSMutableArray array];
    [itemsToShare addObject:image];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList]; //or whichever you don't need
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    else {
        // present the controller
        // on iPad, this will be a Popover
        // on iPhone, this will be an action sheet
        activityVC.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:activityVC animated:YES completion:nil];
        
        // configure the Popover presentation controller
        UIPopoverPresentationController *popController = [activityVC popoverPresentationController];
        popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
        popController.delegate = self;
        
        // in case we don't have a bar button as reference
        popController.sourceView = self.view;
        popController.sourceRect = CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 5, self.view.bounds.size.width - 50, self.view.bounds.size.height - 50);
    }
}

- (void)shareMarkerFile:(NSURL *)urlToFile {
    
    NSMutableArray *itemsToShare = [NSMutableArray array];
    [itemsToShare addObject:urlToFile];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList]; //or whichever you don't need
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    else {
        // present the controller
        // on iPad, this will be a Popover
        // on iPhone, this will be an action sheet
        activityVC.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:activityVC animated:YES completion:nil];
        
        // configure the Popover presentation controller
        UIPopoverPresentationController *popController = [activityVC popoverPresentationController];
        popController.permittedArrowDirections = UIPopoverArrowDirectionDown;
        popController.delegate = self;
        
        // in case we don't have a bar button as reference
        popController.sourceView = self.view;
        popController.sourceRect = CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 5, self.view.bounds.size.width - 50, self.view.bounds.size.height - 50);
    }
}

- (IBAction)returnToMainView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - View Rotation
- (void)orientationChanged:(NSNotification *)note {
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
}

#pragma mark -
#pragma mark - Utility Methods
- (void)openUrl:(NSString *)url {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        [self displayAlert:@"Solimar" andMessage:@"You must have an internet connection to use this feature."];
    }
    else {
        UIApplication *mySafari = [UIApplication sharedApplication];
        NSURL *myURL = [[NSURL alloc] init];
        myURL = [NSURL URLWithString:url];
        [mySafari openURL:myURL];
    }
}

- (void)displayAlert:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *closeButton = [UIAlertAction
                                  actionWithTitle:@"Close"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action) {
                                      //Handle your yes please button action here
                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                  }];
    
    [alert addAction:closeButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
