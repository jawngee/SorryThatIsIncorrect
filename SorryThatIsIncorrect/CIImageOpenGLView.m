//
//  CIImageView.m
//  YouSirAreAnIdiot
//
//  Created by Jon Gilkison on 7/16/18.
//  Copyright © 2018 Jon Gilkison. All rights reserved.
//

#import "CIImageOpenGLView.h"
#import "GeometryShiz.h"

@import OpenGLES;
@import GLKit;

@interface CIImageOpenGLView()<GLKViewDelegate> {
    EAGLContext *eaglContext;
    CIContext *ciContext;
    GLKView *glView;
}
@end

@implementation CIImageOpenGLView



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
    eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    eaglContext.multiThreaded = YES;
    
    ciContext = [CIContext contextWithEAGLContext:eaglContext options: @{kCIContextUseSoftwareRenderer: @NO} ];
    
    glView = [[GLKView alloc] initWithFrame:self.bounds];
    glView.context = eaglContext;
    glView.enableSetNeedsDisplay = YES;
    glView.delegate = self;
    glView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [self addSubview:glView];
    
    [EAGLContext setCurrentContext:eaglContext];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    glView.frame = self.bounds;
    
    [glView setNeedsDisplay];
}

#pragma mark - Properties

-(void)setImage:(CIImage *)image {
    _image = image;
    
    [glView setNeedsDisplay];
}

#pragma mark - GLKViewDelegate

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [glView bindDrawable];
    
    [EAGLContext setCurrentContext:eaglContext];
    
    glClearColor(0., 0., 0., 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    if (_image != nil) {
        CGRect drawRect = CGRectMake(0, 0, glView.drawableWidth, glView.drawableHeight);

        glEnable(GL_BLEND);
        glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        
        drawRect = centerAndFitSizeInRect(_image.extent.size, drawRect);

        [ciContext drawImage:_image inRect:drawRect fromRect:_image.extent];
    }
}

@end
