//
//  main.m
//  EpubReader
//
//  Created by T.Furuyama on 11/07/20.
//  Copyright 2011 TF 技術研究所. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EpubReaderAppDelegate.h"

int main(int argc, char *argv[])
{
    int retVal = 0;
    @autoreleasepool {
        retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([EpubReaderAppDelegate class]));
    }
    return retVal;
}
