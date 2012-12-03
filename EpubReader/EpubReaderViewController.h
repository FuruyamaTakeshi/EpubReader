//
//  EpubReaderViewController.h
//  EpubReader
//
//  Created by T.Furuyama on 11/07/20.
//  Copyright 2011 TF 技術研究所. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyParser;
/**
 * @brief epub表示画面
 */
@interface EpubReaderViewController : UIViewController {
    NSXMLParser *ncxparser_;
    UIWebView *webview_;
    MyParser *navMapparser_;
    NSString *path_;
}

@end
