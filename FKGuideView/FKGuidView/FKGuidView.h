//
//  FKGuidView.h
//  FKGuideView
//
//  Created by Faker on 16/7/21.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FKGuideViewFinishBlock)();

@interface FKGuidView : UIView

@property (nonatomic, copy)FKGuideViewFinishBlock finishBlock;

+ (instancetype)fkGuideViewImgaeArray:(NSArray *)imgArray finish:(FKGuideViewFinishBlock)finishBlock;
@end
