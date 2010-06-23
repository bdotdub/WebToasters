//
//  WebToastersView.h
//  WebToasters
//
//  Created by Benny Wong on 6/22/10.
//  Copyright (c) 2010, __MyCompanyName__. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>


@interface WebToastersView : ScreenSaverView 
{
    IBOutlet id configSheet;
    IBOutlet id webpageUrl;
}

- (IBAction)cancelClick:(id)sender;
- (IBAction)okClick:(id)sender;

@end
