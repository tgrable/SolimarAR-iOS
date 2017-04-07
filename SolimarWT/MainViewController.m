
//
//  MainViewController.m
//  SolimarWT
//
//  Created by Timothy C Grable on 12/7/16.
//  Copyright © 2016 Trekk Design. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

#import "MainViewController.h"
#import "AboutView.h"
#import "DynamicMessagingView.h"
#import "WhitepaperFactory.h"
#import "ContactView.h"
#import "DownloadView.h"
#import "SplashView.h"
#import "Menu.h"
#import "DownloadViewController.h"


@interface MainViewController () <ContactProtocol, MenuProtocol, MenuProtocolPartDeux, DownloadProtocol, MFMailComposeViewControllerDelegate, UIPopoverPresentationControllerDelegate> {
    BOOL navWindowIsOpen;
    int count;
    long currentOrientation;
}

@property (weak, nonatomic) IBOutlet UIView *mainContent;
@property (strong, nonatomic) AboutView *aboutView;
@property (strong, nonatomic) DynamicMessagingView *dynamicMessagingView;
@property (strong, nonatomic) WhitepaperFactory *whitepaperFactory;
@property (strong, nonatomic) ContactView *contactView;
@property (strong, nonatomic) DownloadView *downloadView;
@property (strong, nonatomic) SplashView *splashView;
@property (strong, nonatomic) Menu *menu;
@property (weak, nonatomic) IBOutlet UIView *arBrowserView;

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerViewController *avPlayerView;

@end

@implementation MainViewController

#pragma mark -
#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self buildArBrowser];
    
    int y = 65;
    _tag = 0;
    //    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
    //        y = 45;
    //    }
    
    [self setContent:y];
    [self buildMenu:y];
    
    navWindowIsOpen = false;
    
    count = 0;
    _avPlayerView = [[AVPlayerViewController alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    //Handle device rotation
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];

}

- (void)viewDidAppear:(BOOL)animated {
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    NSLog(@"interfaceOrientation: %ld", (long)interfaceOrientation);
    currentOrientation = interfaceOrientation;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    if (_tag == 0) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            /* Standard WTArchitectView rendering suspension when the application resignes active */
//            [self stopWikitudeSDKRendering];
//        });
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"didReceiveMemoryWarning");
}

- (void)dealloc {
    /* Remove this view controller from the default Notification Center so that it can be released properly */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark - View Rotation
- (void)orientationChanged:(NSNotification *)note {
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (interfaceOrientation != currentOrientation) {
        count++;
        currentOrientation = interfaceOrientation;
        
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
}

- (void)updateViews:(int)orientation {
    int y = 65;
    if (![(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            y = 45;
        }
    }
    
    [self removeEverything:_mainContent];
    _whitepaperFactory = nil;
    _dynamicMessagingView = nil;
    _aboutView = nil;
    _contactView = nil;
    [self setContent:y];
    
    [_menu removeFromSuperview];
    [self buildMenu:y];
}

#pragma mark -
#pragma mark - Build Views
- (void)setContent:(int)atYLocation {
    //    [_mainContent setFrame:CGRectMake(0, atYLocation, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    float bsWidth = self.view.bounds.size.width;
    float bsHeight = self.view.bounds.size.height;
    
    if ([(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        if (count > 0) {
            if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
                bsWidth = 768;
                bsHeight = 1024;
            }
            else {
                bsWidth = 1024;
                bsHeight = 768;
            }
        }
    }
    
    switch (_tag) {
        case 0:
//            _mainContent.hidden = YES;
//            [self startWikitudeSDKRendering];
            _mainContent.hidden = NO;
            _splashView = [[SplashView alloc] initWithFrame:CGRectMake(0, 0, bsWidth, bsHeight)];
            _splashView.delegate = self; 
            [_mainContent addSubview:_splashView];
            break;
        case 1:
            _mainContent.hidden = NO;
//            _updatedDownloadView = [[UpdatedDownloadView alloc] initWithFrame:CGRectMake(0, 0, bsWidth, bsHeight)];
//            _updatedDownloadView.delegate = self;
//            [_mainContent addSubview:_updatedDownloadView];
            
            _downloadView = [[DownloadView alloc] initWithFrame:CGRectMake(0, 0, bsWidth, bsHeight)];
            _downloadView.delegate = self;
            [_mainContent addSubview:_downloadView];
            break;
        case 2:
            _mainContent.hidden = NO;
            _whitepaperFactory = [[WhitepaperFactory alloc] initWithFrame:CGRectMake(0, 0, bsWidth, bsHeight)];
            [_mainContent addSubview:_whitepaperFactory];
            break;
        case 3:
            _mainContent.hidden = NO;
            _dynamicMessagingView = [[DynamicMessagingView alloc] initWithFrame:CGRectMake(0, 0, bsWidth, bsHeight)];
            [_mainContent addSubview:_dynamicMessagingView];
            break;
        case 4:
            _mainContent.hidden = NO;
            _aboutView = [[AboutView alloc] initWithFrame:CGRectMake(0, 0, bsWidth, bsHeight)];
            [_mainContent addSubview:_aboutView];
            break;
        case 5:
            _mainContent.hidden = NO;
            _contactView = [[ContactView alloc] initWithFrame:CGRectMake(0, 0, bsWidth, bsHeight)];
            _contactView.delegate = self;
            [_mainContent addSubview:_contactView];
            break;
        default:
            break;
    }
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

#pragma mark -
#pragma mark - ContactProtocol Delegates
- (void)sendEmail:(NSString *)fName lastName:(NSString *)lName company:(NSString *)company email:(NSString *)email phone:(NSString *)phone comments:(NSString *)comments {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        
        [mail setToRecipients:@[NSLocalizedString(@"mail_to", "mail_to")]];
        [mail setSubject:NSLocalizedString(@"mail_subject", "mail_subject")];
        
        NSMutableString *bodyString = [NSMutableString stringWithString:NSLocalizedString(@"mail_starting_body_string", "mail_starting_body_string")];
        [bodyString appendString:[NSString stringWithFormat:@"First Name: %@ \n", fName]];
        [bodyString appendString:[NSString stringWithFormat:@"Last Name: %@ \n", lName]];
        [bodyString appendString:[NSString stringWithFormat:@"Company: %@ \n", company]];
        [bodyString appendString:[NSString stringWithFormat:@"Email:: %@ \n", email]];
        [bodyString appendString:[NSString stringWithFormat:@"Phone (optional): %@ \n", phone]];
        [bodyString appendString:[NSString stringWithFormat:@"Comment: %@ \n", comments]];
        [bodyString appendString:@" -- End of submission -- \n"];
        
        [mail setMessageBody:bodyString isHTML:NO];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else {
        [self displayAlert:NSLocalizedString(@"alert_header", "alert_header") andMessage:NSLocalizedString(@"mail_device_cannot_send", "mail_device_cannot_send")];
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

#pragma mark -
#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    switch (result) {
        case MFMailComposeResultSent:
            [self displayAlert:NSLocalizedString(@"alert_header", "alert_header") andMessage:NSLocalizedString(@"mail_result_sent", "mail_result_sent")];
            break;
        case MFMailComposeResultSaved:
            [self displayAlert:NSLocalizedString(@"alert_header", "alert_header") andMessage:NSLocalizedString(@"mail_result_saved", "mail_result_saved")];
            break;
        case MFMailComposeResultCancelled:
            [self displayAlert:NSLocalizedString(@"alert_header", "alert_header") andMessage:NSLocalizedString(@"mail_result_cancelled", "mail_result_cancelled")];
            break;
        case MFMailComposeResultFailed:
            [self displayAlert:NSLocalizedString(@"alert_header", "alert_header") andMessage:NSLocalizedString(@"mail_result_failed", "mail_result_failed")];
            break;
        default:
            [self displayAlert:NSLocalizedString(@"alert_header", "alert_header") andMessage:NSLocalizedString(@"mail_result_failed", "mail_result_failed")];
            break;
    }
}

#pragma mark -
#pragma mark - Navigation
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

- (IBAction)menuButtonPressed:(UIButton *)sender {
    [self showHideNavigation];
}


#pragma mark -
#pragma mark - MenuProtocol Delegate
- (void)menuClosed {
    [self showHideNavigation];
}

- (void)menuItemPressed:(NSInteger)tag {
    _tag = tag;
    if (tag != 0) {
        [self removeEverything:_mainContent];
        [self setContent:65];
        [self showHideNavigation];
    }
    else {
        [self performSegueWithIdentifier:@"showDownloadView" sender:self];
    }
    
    //    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
    //        [self setContent:65];
    //    }
    //    else {
    //        [self setContent:45];
    //    }
}

#pragma mark -
#pragma mark - DownloadProtocol Delegate
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

- (void)playVideo:(int)tag {
    // remote file from server:
    
    NSLog(@"TimGrable tag: %d", tag);
    
    NSString *path = @"";
    switch (tag) {
        case 9:
            path = [[NSBundle mainBundle] pathForResource:@"Solibank_SD" ofType:@"mp4"];
            break;
        case 10:
            path = [[NSBundle mainBundle] pathForResource:@"cats_sd" ofType:@"mp4"];
            break;
        case 11:
            path = [[NSBundle mainBundle] pathForResource:@"Monkey-SD" ofType:@"mp4"];
            break;
        case 12:
            path = [[NSBundle mainBundle] pathForResource:@"Elephant-SD" ofType:@"mp4"];
            break;
//        case 14:
//            path = [[NSBundle mainBundle] pathForResource:@"Solibank_SD" ofType:@"mp4"];
//            break;
        case 16:
            path = [[NSBundle mainBundle] pathForResource:@"variable_video_1" ofType:@"mp4"];
            break;
        default:
            path = [[NSBundle mainBundle] pathForResource:@"Solibank_SD" ofType:@"mp4"];
            break;
    }
    
//    [self stopWikitudeSDKRendering];
    // create a player view controller
    NSURL *videoURL = [[NSURL alloc] initFileURLWithPath:path];
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    [self presentViewController:_avPlayerView animated:YES completion:nil];
    _avPlayerView.player = player;
    [player play];
}

#pragma mark -
#pragma mark - Memory Management
- (void)removeEverything:(UIView *)view {
    for (UIView *v in [view subviews]) {
        if (![view isKindOfClass:[UIRefreshControl class]]) {
            [v removeFromSuperview];
        }
    }
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //     Get the new view controller using [segue destinationViewController].
    //     Pass the selected object to the new view controller.
    DownloadViewController *dvc = segue.destinationViewController;
    dvc.tag = _tag;
}

@end
