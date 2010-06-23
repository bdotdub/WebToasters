//
//  WebToastersView.m
//  WebToasters
//
//  Created by Benny Wong on 6/22/10.
//  Copyright (c) 2010, Seedless Media. All rights reserved.
//

#import <WebKit/WebView.h>
#import <WebKit/WebFrame.h>
#import <WebKit/WebFrameView.h>
#import "WebToastersView.h"

static NSString * const WebToastersModuleName = @"net.bwong.WebToasters";
static NSString * const DefaultWebToaster = @"http://www.twistori.com/";

@implementation WebToastersView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        ScreenSaverDefaults *defaults;
        
        defaults = [ScreenSaverDefaults defaultsForModuleWithName:WebToastersModuleName];
        [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:DefaultWebToaster, @"WebToaster", nil]];
        
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    WebView *webView;
    webView = [[WebView alloc] initWithFrame:[self frame]
                                   frameName:nil groupName: nil];
    
    ScreenSaverDefaults *defaults = [ScreenSaverDefaults defaultsForModuleWithName:WebToastersModuleName];
    WebFrame *webFrame = [webView mainFrame];
    WebFrameView *webFrameView = [webFrame frameView];
    [webFrameView setAllowsScrolling:NO];
    
    [webFrame loadRequest:[NSURLRequest
                           requestWithURL:[NSURL URLWithString:[defaults stringForKey:@"WebToaster"]]]];
    
    [self addSubview:webView];
    [self stopAnimation];
    return;
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    if (!configSheet) {
        if (![NSBundle loadNibNamed:@"ConfigureSheet" owner:self]) {
            NSLog(@"Failed to load configure sheet");
            NSBeep(); // Just to be annoying
        }
    }
    
    ScreenSaverDefaults *defaults = [ScreenSaverDefaults defaultsForModuleWithName:WebToastersModuleName];
    [webpageUrl setStringValue:[defaults stringForKey:@"WebToaster"]];
    
    return configSheet;
}

#pragma mark -
#pragma mark ConfigureSheet buttons delegate

- (IBAction)cancelClick:(id)sender {
    [[NSApplication sharedApplication] endSheet:configSheet];
}

- (IBAction)okClick:(id)sender {
    ScreenSaverDefaults *defaults;
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:WebToastersModuleName];
    
    [defaults setObject:[webpageUrl stringValue] forKey:@"WebToaster"];
    [defaults synchronize];
    
    [[NSApplication sharedApplication] endSheet:configSheet];
}

@end
