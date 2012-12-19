//
//  VTASwipeView.h
//
//  Created by Simon Fairbairn on 18/12/2012.
//  Copyright (c) 2012 Simon Fairbairn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTATankerView : UIView


@property BOOL shouldDarkenScreen;
@property BOOL shouldRespondToSwipe;
@property BOOL tapToHide;
@property (nonatomic) BOOL shouldStretchContent;

// Ask the view if it's currently on screen
@property (readonly) BOOL containerViewActive;
@property (nonatomic, weak) UIView *content;


+(VTATankerView *)newTanker;

-(void) show;
-(void) hide;

@end
