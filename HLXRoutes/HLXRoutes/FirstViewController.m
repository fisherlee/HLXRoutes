//
//  FirstViewController.m
//  HLXRoutes
//
//  Created by lee on 2019/5/14.
//  Copyright © 2019 lee. All rights reserved.
//

#import "FirstViewController.h"
#import "UIImageView+HLUI.h"
#import "UIImage+HLUI.h"
#import "HomeFlowView.h"
#import "Masonry.h"

#define ScreenScale ([[UIScreen mainScreen] scale])


@interface FirstViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *bgImageView;
@property (nonatomic, weak) IBOutlet UIImageView *bottomImageView;

@property (nonatomic, weak) IBOutlet UIView *conView;

@property (nonatomic, strong) HomeFlowView *flowView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_bgImageView.backgroundColor = [UIColor lightGrayColor];
	_bgImageView.layer.cornerRadius = 11;
	_bgImageView.layer.masksToBounds = NO;
	[_bgImageView hlui_drawShadow];

	
	_bottomImageView.image = [UIImage hlui_imageWithColor:[UIColor orangeColor] size:_bottomImageView.bounds.size cornerRadiusArray:@[@0,@11,@11,@0]];
	
	[_conView addSubview:self.flowView];
	[self.flowView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
}


- (HomeFlowView *)flowView
{
	if (!_flowView) {
		_flowView = [[HomeFlowView alloc] init];
	}
	_flowView.backgroundColor = [UIColor orangeColor];
	return _flowView;
}

@end
