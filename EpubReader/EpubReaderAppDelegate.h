//
//  EpubReaderAppDelegate.h
//  EpubReader
//
//  Created by T.Furuyama on 11/07/20.
//  Copyright 2011 TF 技術研究所. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EpubReaderViewController;

@interface EpubReaderAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EpubReaderViewController *viewController;

@end
