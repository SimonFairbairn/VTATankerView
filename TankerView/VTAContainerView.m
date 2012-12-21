//
//  VTAContainerView.m
//  TankerView
//
//  Created by Simon Fairbairn on 20/12/2012.
//  Copyright (c) 2012 Simon Fairbairn. All rights reserved.
//

#import "VTAContainerView.h"
#import "VTATankerView.h"

@interface VTAContainerView()

@property float difference;
@property float full;
@property float empty;

@end

@implementation VTAContainerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.difference = self.superview.superview.bounds.size.height - self.bounds.size.height;
    self.full = self.superview.superview.bounds.size.height - self.difference;
    self.empty = self.superview.superview.bounds.size.height - self.difference;
	
    

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self.superview];

    if ( [(VTATankerView *)self.superview shouldRespondToSwipe] == NO ) {
        return;
    }


    
    if ( touchPoint.y >= self.superview.superview.bounds.size.height - self.frame.size.height && touchPoint.y <= self.superview.superview.bounds.size.height - 20 ) {
        self.frame = CGRectMake(self.frame.origin.x,  touchPoint.y, self.frame.size.width, self.frame.size.height);
        


        if ( [(VTATankerView *)self.superview shouldDarkenScreen] == YES ) {
                self.superview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:(1 - (touchPoint.y - self.difference )/ self.empty  ) * 0.8];
        }
    } else if ( touchPoint.y <= self.superview.superview.bounds.size.height - self.frame.size.height  ) {
         if ( [(VTATankerView *)self.superview shouldDarkenScreen] == YES ) {
             self.superview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
         }

        self.frame = CGRectMake(self.frame.origin.x, self.superview.superview.bounds.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.superview];
    
    if ( ( 1 - ( touchPoint.y - self.difference ) / self.bounds.size.height) > 0.5 ) {
        [(VTATankerView *)self.superview show];
    } else {
        [(VTATankerView *)self.superview hide];
    }

}



@end
