//
//  CIImageMetalView.h
//  YouSirAreAnIdiot
//
//  Created by Jon Gilkison on 7/17/18.
//  Copyright © 2018 Jon Gilkison. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreImage;

@interface CIImageMetalView : UIView

@property (nullable, strong, nonatomic) CIImage *image;

@end
