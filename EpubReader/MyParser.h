//
//  MyParser.h
//  EpubRead
//
//  Created by T.Furuyama on 11/07/20.
//  Copyright 2011 TF 技術研究所. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Ncx;
/**
 * @brief XMLパーサークラス
 */
@interface MyParser : NSObject <NSXMLParserDelegate> {
 @private
    NSString *opfFilePath_;
    NSString *ncxFilePath_;
    Ncx *ncx_;
    NSMutableArray *srcArray_;
}
@property (nonatomic, retain)NSString *opfFilePath;
@property (nonatomic, retain)NSString *ncxFilePath;
@property (nonatomic, retain)Ncx *ncx;
@property (nonatomic, retain)NSMutableArray *srcArray;

/**
 * @brief パーサー
 * @param in:
 */
- (void)parse:(NSString*)output parseError:(NSError**)error;
/**
 * 簡易コンストラクタ
 */
- (id)initWithFile:(NSString*)path;
@end
