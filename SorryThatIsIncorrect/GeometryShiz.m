//
//  GeometryShiz.m
//  YouSirAreAnIdiot
//
//  Created by Jon Gilkison on 7/17/18.
//  Copyright © 2018 Jon Gilkison. All rights reserved.
//

#import "GeometryShiz.h"

CGSize sizeToFitSize(CGSize innerSize, CGSize outerSize) {
    if (innerSize.width <= 0 || innerSize.height <= 0) {
        return outerSize;
    }
    
    CGSize finalSize = outerSize;
    CGFloat ratioW = outerSize.width / innerSize.width;
    CGFloat ratioH = outerSize.height / innerSize.height;
    
    if (ratioW < ratioH) {
        finalSize.height = (innerSize.height * ratioW);
    } else {
        finalSize.width = (innerSize.width * ratioH);
    }
    
    return finalSize;
}

CGRect alignInRectWithAnchor(CGRect innerRect, CGRect outerRect, CGPoint anchor) {
    CGRect alignedRect = innerRect;
    alignedRect.origin.x = outerRect.origin.x + (anchor.x * (outerRect.size.width - innerRect.size.width));
    alignedRect.origin.y = outerRect.origin.y + (anchor.y * (outerRect.size.height - innerRect.size.height));
    return alignedRect;
}

CGRect centerInRect(CGRect innerRect, CGRect outerRect) {
    return alignInRectWithAnchor(innerRect, outerRect, CGPointMake(0.5f, 0.5f));
}

CGRect centerAndFitSizeInRect(CGSize size, CGRect outerRect) {
    CGSize sz = sizeToFitSize(size, outerRect.size);
    return centerInRect(CGRectMake(0, 0, sz.width, sz.height), outerRect);
}

CGAffineTransform CGAffineTransformFromRectToRect(CGRect fromRect, CGRect toRect) {
    CGAffineTransform trans1 = CGAffineTransformMakeTranslation(-fromRect.origin.x, -fromRect.origin.y);
    CGAffineTransform scale = CGAffineTransformMakeScale(toRect.size.width/fromRect.size.width, toRect.size.height/fromRect.size.height);
    CGAffineTransform trans2 = CGAffineTransformMakeTranslation(toRect.origin.x, toRect.origin.y);
    return CGAffineTransformConcat(CGAffineTransformConcat(trans1, scale), trans2);
}
