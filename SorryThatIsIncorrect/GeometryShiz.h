//
//  GeometryShiz.h
//  YouSirAreAnIdiot
//
//  Created by Jon Gilkison on 7/17/18.
//  Copyright © 2018 Jon Gilkison. All rights reserved.
//

@import CoreGraphics;

#if __cplusplus
extern "C" {
#endif
    
    CGSize sizeToFitSize(CGSize innerSize, CGSize outerSize);
    CGRect alignInRectWithAnchor(CGRect innerRect, CGRect outerRect, CGPoint anchor);
    CGRect centerInRect(CGRect innerRect, CGRect outerRect);
    CGRect centerAndFitSizeInRect(CGSize size, CGRect outerRect);
    CGAffineTransform CGAffineTransformFromRectToRect(CGRect fromRect, CGRect toRect);
    
#if __cplusplus
} //Extern C
#endif
