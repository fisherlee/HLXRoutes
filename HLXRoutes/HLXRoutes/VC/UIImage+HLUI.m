//
//  UIImage+HLUI.m
//  HLXRoutes
//
//  Created by lee on 2019/5/20.
//  Copyright © 2019 lee. All rights reserved.
//

#import "UIImage+HLUI.h"

#define ScreenScale ([[UIScreen mainScreen] scale])

@implementation UIImage (HLUI)


/**
 *  创建一个纯色的UIImage，支持为四个角设置不同的圆角
 *  @param  color               图片的颜色
 *  @param  size                图片的大小
 *  @param  cornerRadius   四个角的圆角值的数组，长度必须为4，顺序分别为[左上角、左下角、右下角、右上角]
 */
+ (UIImage *)hlui_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadiusArray:(NSArray<NSNumber *> *)cornerRadius {
	size = CGSizeFlatted(size);
	color = color ? color : [UIColor whiteColor];
	return [UIImage hlui_imageWithSize:size opaque:NO scale:0 actions:^(CGContextRef contextRef) {
		
		CGContextSetFillColorWithColor(contextRef, color.CGColor);
		
		UIBezierPath *path = [UIImage hlui_bezierPathWithRoundedRect:CGRectMakeWithSize(size) cornerRadiusArray:cornerRadius lineWidth:0];
		[path addClip];
		[path fill];
	}];
}


+ (UIImage *)hlui_imageWithSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale actions:(void (^)(CGContextRef contextRef))actionBlock {
	if (!actionBlock || CGSizeIsEmpty(size)) {
		return nil;
	}
	UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	actionBlock(context);
	UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return imageOut;
}


+ (UIBezierPath *)hlui_bezierPathWithRoundedRect:(CGRect)rect cornerRadiusArray:(NSArray<NSNumber *> *)cornerRadius lineWidth:(CGFloat)lineWidth {
	CGFloat topLeftCornerRadius = cornerRadius[0].floatValue;
	CGFloat bottomLeftCornerRadius = cornerRadius[1].floatValue;
	CGFloat bottomRightCornerRadius = cornerRadius[2].floatValue;
	CGFloat topRightCornerRadius = cornerRadius[3].floatValue;
	CGFloat lineCenter = lineWidth / 2.0;
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(topLeftCornerRadius, lineCenter)];
	[path addArcWithCenter:CGPointMake(topLeftCornerRadius, topLeftCornerRadius) radius:topLeftCornerRadius - lineCenter startAngle:M_PI * 1.5 endAngle:M_PI clockwise:NO];
	[path addLineToPoint:CGPointMake(lineCenter, CGRectGetHeight(rect) - bottomLeftCornerRadius)];
	[path addArcWithCenter:CGPointMake(bottomLeftCornerRadius, CGRectGetHeight(rect) - bottomLeftCornerRadius) radius:bottomLeftCornerRadius - lineCenter startAngle:M_PI endAngle:M_PI * 0.5 clockwise:NO];
	[path addLineToPoint:CGPointMake(CGRectGetWidth(rect) - bottomRightCornerRadius, CGRectGetHeight(rect) - lineCenter)];
	[path addArcWithCenter:CGPointMake(CGRectGetWidth(rect) - bottomRightCornerRadius, CGRectGetHeight(rect) - bottomRightCornerRadius) radius:bottomRightCornerRadius - lineCenter startAngle:M_PI * 0.5 endAngle:0.0 clockwise:NO];
	[path addLineToPoint:CGPointMake(CGRectGetWidth(rect) - lineCenter, topRightCornerRadius)];
	[path addArcWithCenter:CGPointMake(CGRectGetWidth(rect) - topRightCornerRadius, topRightCornerRadius) radius:topRightCornerRadius - lineCenter startAngle:0.0 endAngle:M_PI * 1.5 clockwise:NO];
	[path closePath];
	
	return path;
}

/// 传入size，返回一个x/y为0的CGRect
CG_INLINE CGRect
CGRectMakeWithSize(CGSize size) {
	return CGRectMake(0, 0, size.width, size.height);
}

/// 判断一个 CGSize 是否为空（宽或高为0）
CG_INLINE BOOL
CGSizeIsEmpty(CGSize size) {
	return size.width <= 0 || size.height <= 0;
}

/// 将一个 CGSize 像素对齐
CG_INLINE CGSize
CGSizeFlatted(CGSize size) {
	return CGSizeMake(flat(size.width), flat(size.height));
}


/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CG_INLINE CGFloat
flat(CGFloat floatValue) {
	return flatSpecificScale(floatValue, 0);
}

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE CGFloat
flatSpecificScale(CGFloat floatValue, CGFloat scale) {
	floatValue = removeFloatMin(floatValue);
	scale = scale ?: ScreenScale;
	CGFloat flattedValue = ceil(floatValue * scale) / scale;
	return flattedValue;
}


/**
 *  某些地方可能会将 CGFLOAT_MIN 作为一个数值参与计算（但其实 CGFLOAT_MIN 更应该被视为一个标志位而不是数值），可能导致一些精度问题，所以提供这个方法快速将 CGFLOAT_MIN 转换为 0
 *  issue: https://github.com/Tencent/QMUI_iOS/issues/203
 */
CG_INLINE CGFloat
removeFloatMin(CGFloat floatValue) {
	return floatValue == CGFLOAT_MIN ? 0 : floatValue;
}

@end
