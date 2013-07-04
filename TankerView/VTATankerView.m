/*
    VTATankerView
 
    Created by Simon Fairbairn on 18/12/2012.
    Copyright (c) 2012 Simon Fairbairn. All rights reserved.
 
    Permission is hereby granted, free of charge, to any person obtaining a copy of this software
    and associated documentation files (the "Software"), to deal in the Software without restriction,
    including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:
 
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
    OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "VTATankerView.h"
#import "VTAContainerView.h"

@interface VTATankerView()

@property (nonatomic, weak) UIView *contentContainer;
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
    self.shouldRespondToSwipe = NO;
    self.tapToHide = YES;
    self.containerViewActive = NO;
    self.shouldStretchContent = YES;
    
    // Create subviews
    VTAContainerView *container = [[VTAContainerView alloc] initWithFrame:CGRectMake(0, 0, 50, 200)];
    self.contentContainer = container;
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
    
    if ( self.shouldRespondToSwipe == YES ) {
        UIImageView *grabber = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grabber.png"]];
        grabber.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        grabber.frame = CGRectMake((self.contentContainer.frame.size.width / 2) - (grabber.bounds.size.width / 2 ), 0, grabber.bounds.size.width, grabber.bounds.size.height);
        
        
        [self.contentContainer addSubview:grabber];
        
        
        _content.frame = CGRectMake(_content.frame.origin.x, _content.frame.origin.y + 20, _content.frame.size.width , _content.frame.size.height);
        
        
    }
    
    [self.contentContainer addSubview:content];
    
}

-(void)setShouldRespondToSwipe:(BOOL)shouldRespondToSwipe {
    _shouldRespondToSwipe = shouldRespondToSwipe;
    self.contentContainer.backgroundColor = [UIColor clearColor];
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
    self.hidden = YES;
    if ( self.superview ) {
        self.frame = CGRectMake(0, self.superview.bounds.origin.y, self.superview.bounds.size.width, self.superview.bounds.size.height + self.contentContainer.frame.size.height);
        
        
        self.contentContainer.frame =  [self calculateHideBounds];
        
        
    }

}

-(void)show {
    self.hidden = NO;
    
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
    } completion:^(BOOL finished) {
            self.hidden = YES;
    }];
    [self.delegate VTATankerViewDidDisappear:self];
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

    
    
    if ( self.shouldRespondToSwipe == YES ) {

        return CGRectMake(self.bounds.origin.x, self.superview.bounds.size.height - 20, self.superview.bounds.size.width, self.content.bounds.size.height + self.content.frame.origin.y);

    } else {
        return CGRectMake(self.bounds.origin.x, self.superview.bounds.size.height, self.superview.bounds.size.width, self.content.bounds.size.height + self.content.frame.origin.y);
    }
    

    
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
