//
//  UIImage+HLUI.h
//  HLXRoutes
//
//  Created by lee on 2019/5/20.
//  Copyright © 2019 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HLUI)

/**
 *  创建一个纯色的UIImage，支持为四个角设置不同的圆角
 *  @param  color               图片的颜色
 *  @param  size                图片的大小
 *  @param  cornerRadius   四个角的圆角值的数组，长度必须为4，顺序分别为[左上角、左下角、右下角、右上角]
 */
+ (UIImage *)hlui_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadiusArray:(NSArray<NSNumber *> *)cornerRadius;

@end

NS_ASSUME_NONNULL_END
