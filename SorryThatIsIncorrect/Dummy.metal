//
//  Dummy.metal
//  YouSirAreAnIdiot
//
//  Created by Jon Gilkison on 7/17/18.
//  Copyright © 2018 Jon Gilkison. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h>


extern "C" { namespace coreimage {
    /**
     @function Dummy
     @title Dummy
    */
    float4 Dummy(sampler image) {
    	float4 pixel = image.sample(image.coord());
        return float4(1.0 - pixel.rgb, 1.);
    }
}}
