//
//  OPF.h
//  EpubReader
//
//  Created by T.Furuyama on 11/09/01.
//  Copyright (c) 2011 TF 技術研究所. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * @brief 
 */
@interface OPF : NSObject {
 @private
    NSDictionary *metadata_;
    NSDictionary *manifest_;
    NSArray *spine_;
}

@end
