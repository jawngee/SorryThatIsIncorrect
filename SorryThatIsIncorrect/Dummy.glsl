kernel vec4 Dummy(sampler image) {
    vec4 pixel=sample(image, samplerCoord(image));
    return vec4(1.0 - pixel.rgb, 1.0);
}
