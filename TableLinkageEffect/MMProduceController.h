//
//  MMProduceController.h
//  TableLinkageEffect
//
//  Created by Mortimey on 16/6/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MMProduceControllerDelegate;



@interface MMProduceController : UIViewController




/**
 *  当MMCategoryController滚动时,MMProduceController跟随滚动至指定section
 *
 *  @param section
 */
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath;


@property(nonatomic, weak) id <MMProduceControllerDelegate> delegate;

@end



@protocol MMProduceControllerDelegate <NSObject>

- (void)willDisplayHeaderView:(NSInteger)section;
- (void)didEndDisplayingHeaderView:(NSInteger)section;

@end