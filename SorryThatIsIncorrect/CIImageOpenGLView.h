//
//  CIImageView.h
//  YouSirAreAnIdiot
//
//  Created by Jon Gilkison on 7/16/18.
//  Copyright © 2018 Jon Gilkison. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreImage;

@interface CIImageOpenGLView : UIView

@property (nullable, strong, nonatomic) CIImage *image;

@end
