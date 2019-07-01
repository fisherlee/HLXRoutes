//
//  UIImageView+HLUI.m
//  HLXRoutes
//
//  Created by lee on 2019/5/20.
//  Copyright © 2019 lee. All rights reserved.
//

#import "UIImageView+HLUI.h"

@implementation UIImageView (HLUI)

/** 右侧和下面显示阴影 */
- (void)hlui_drawShadow
{
	CGFloat shadowWidth = 4;
	
	self.layer.shadowOpacity = 0.8;
	self.layer.shadowRadius = shadowWidth;
	self.layer.shadowOffset = CGSizeMake(0, 0);
	self.layer.shadowColor = [[UIColor purpleColor] CGColor];
	self.layer.masksToBounds = NO;
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(CGRectGetWidth(self.frame), shadowWidth)];
	[path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
	[path addLineToPoint:CGPointMake(shadowWidth, CGRectGetHeight(self.frame))];
	[path closePath];
	self.layer.shadowPath = path.CGPath;
}

@end
