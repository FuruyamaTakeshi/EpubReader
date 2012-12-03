//
//  Ncx.h
//  EpubReader
//
//  Created by T.Furuyama on 11/09/01.
//  Copyright (c) 2011 TF 技術研究所. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * @brief ePub要素を抽象化したクラス
 */
@interface Ncx : NSObject {
    NSURL *url_;
    NSString *docTitle_;
    NSArray *navMap_;
}
@property (nonatomic, retain)NSURL *url;
@property (nonatomic, retain)NSString *docTitle;
@property (nonatomic, retain)NSArray *navMap;
@end
