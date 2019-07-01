//
//  HomeFlowView.m
//  HLXRoutes
//
//  Created by lee on 2019/5/21.
//  Copyright © 2019 lee. All rights reserved.
//

#import "HomeFlowView.h"
#import "Masonry.h"

@interface HomeFlowView ()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation HomeFlowView

- (id)init
{
	self = [super init];
	if (self) {
		[self commitInit];
	}
	return self;
}

- (void)commitInit
{
	[self addSubview:self.leftView];
	[self addSubview:self.rightView];
	
	CGFloat width = [UIScreen mainScreen].bounds.size.width;
	[self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, width/2));
	}];
	[self. rightView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(0, width/2, 0, 0));
	}];
}

#pragma mark - set

- (UIView *)leftView
{
	if (!_leftView) {
		_leftView = [UIView new];
	}
	_leftView.backgroundColor = [UIColor redColor];
	return _leftView;
}

- (UIView *)rightView
{
	if (!_rightView) {
		_rightView = [UIView new];
	}
	_rightView.backgroundColor = [UIColor blueColor];
	return _rightView;
}

@end

