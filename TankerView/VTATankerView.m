//
//  VTASwipeView.m
//  Swipy
//
//  Created by Simon Fairbairn on 18/12/2012.
//  Copyright (c) 2012 Simon Fairbairn. All rights reserved.
//

#import "VTATankerView.h"

@interface VTATankerView()

@property (nonatomic, strong) UIView *contentContainer;
@property BOOL containerViewActive;


-(void)dismiss;
-(CGRect)calculateShowBounds;
-(CGRect)calculateHideBounds;

@end


@implementation VTATankerView


+(VTATankerView *)newTanker {
    
    VTATankerView *newView = [[VTATankerView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    return newView;
}

#pragma mark - Initialisation

- (void)baseInit {
    
    // Set container view
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tapGesture];
    
    
    // Set defaults
    self.shouldDarkenScreen = YES;
    self.shouldRespondToSwipe = YES;
    self.tapToHide = YES;
    self.containerViewActive = NO;
    self.shouldStretchContent = YES;
    
    // Create subviews
    self.contentContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 200)];
    self.contentContainer.backgroundColor = [UIColor blackColor];
    self.contentContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:self.contentContainer];
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}


#pragma mark - Properties

-(void)setContent:(UIView *)content {
    _content = content;
    
    
    
    self.contentContainer.frame =  [self calculateHideBounds];
    [self.contentContainer addSubview:content];
    
    
    

    
}



#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    if ( self.shouldStretchContent == YES ) {
        self.content.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    } else {
        self.content.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    if ( self.containerViewActive == YES ) {
        self.contentContainer.frame = [self calculateShowBounds];
        
    } else {
        self.contentContainer.frame = [self calculateHideBounds];
    }
    
    
}

#pragma mark - User Interaction

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews) {
        if (!view.hidden && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
    }
    if ( self.containerViewActive == YES ) {
        if (!self.hidden && self.userInteractionEnabled)
            return YES;
    }
    return NO;
    
}

-(void)didMoveToSuperview {

    
    self.frame = CGRectMake(0, self.superview.bounds.origin.y, self.superview.bounds.size.width, self.superview.bounds.size.height + self.contentContainer.frame.size.height);


    self.contentContainer.frame =  [self calculateHideBounds];

}

-(void)show {
    
    [UIView animateWithDuration:0.2 animations:^{
        if ( self.shouldDarkenScreen == YES ) {
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];            
        }

        self.contentContainer.frame = [self calculateShowBounds];
        self.containerViewActive = YES;
    }];


}

-(void) hide {
    [UIView animateWithDuration:0.2 animations:^{
        if ( self.shouldDarkenScreen == YES ) {
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        }
        self.contentContainer.frame = [self calculateHideBounds];
        self.containerViewActive = NO;
    }];
}

-(void)dismiss {
    
    if ( self.tapToHide ) {
        [self hide];
    }
}

-(CGRect)calculateShowBounds {
    return CGRectMake(0, self.superview.bounds.size.height - self.content.bounds.size.height - self.content.frame.origin.y, self.superview.bounds.size.width, self.content.bounds.size.height + self.content.frame.origin.y);
}
-(CGRect)calculateHideBounds {

    
    return CGRectMake(self.bounds.origin.x, self.superview.bounds.size.height, self.superview.bounds.size.width, self.content.bounds.size.height + self.content.frame.origin.y);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
