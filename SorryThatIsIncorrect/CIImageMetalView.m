//
//  CIImageMetalView.m
//  YouSirAreAnIdiot
//
//  Created by Jon Gilkison on 7/17/18.
//  Copyright © 2018 Jon Gilkison. All rights reserved.
//

#import "CIImageMetalView.h"
#import "GeometryShiz.h"

@import Metal;

@interface CIImageMetalView() {
    CAMetalLayer *metalLayer;
    id<MTLDevice> device;
    id<MTLCommandQueue> commandQueue;
    CIContext *ciContext;
    
     CGColorSpaceRef csref;
}
@end

@implementation CIImageMetalView

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self=[super initWithCoder:aDecoder])) {
        [self setup];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        [self setup];
    }
    
    return self;
}

-(void)setup {
    csref = CGColorSpaceCreateDeviceRGB();
    
    device = MTLCreateSystemDefaultDevice();
    commandQueue = [device newCommandQueue];
    
    ciContext = [CIContext contextWithMTLDevice:device];
    
    metalLayer = [CAMetalLayer layer];
    metalLayer.device = device;
    metalLayer.framebufferOnly = NO;
    metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
    metalLayer.backgroundColor = UIColor.blackColor.CGColor;
    metalLayer.frame = self.bounds;
    [self.layer addSublayer:metalLayer];
}

-(void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    metalLayer.frame = self.bounds;
    
    [self drawImage];
}

-(void)setImage:(CIImage *)image {
    _image = image;
    
    [self drawImage];
}

-(void)drawImage {
    if (!_image) {
        return;
    }
    
    metalLayer.drawableSize = self.bounds.size;
    
    id<MTLCommandBuffer> buffer = [commandQueue commandBuffer];
    id<CAMetalDrawable> drawable = metalLayer.nextDrawable;
    id<MTLTexture> texture = drawable.texture;

    CGRect targetRect = centerAndFitSizeInRect(_image.extent.size, self.bounds);
    CGAffineTransform t = CGAffineTransformFromRectToRect(_image.extent, targetRect);
    
    CIImage *outputImage = [[_image imageByApplyingTransform:t] imageByCroppingToRect:self.bounds];
    
    [ciContext render:outputImage toMTLTexture:texture commandBuffer:buffer bounds:self.bounds colorSpace:csref];
    
    [buffer presentDrawable:drawable];
    [buffer commit];
    [buffer waitUntilCompleted];
}


@end
