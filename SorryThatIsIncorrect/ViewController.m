//
//  ViewController.m
//  SorryThatIsIncorrect
//
//  Created by Jon Gilkison on 7/17/18.
//  Copyright © 2018 Jon Gilkison. All rights reserved.
//

#import "ViewController.h"
#import "CIImageOpenGLView.h"
#import "CIImageMetalView.h"

@interface ViewController () {
    CIImage *image;
    
    __weak IBOutlet UISegmentedControl *kernelSelector;
    __weak IBOutlet UISegmentedControl *backendSelector;
    __weak IBOutlet CIImageOpenGLView *openGLView;
    __weak IBOutlet CIImageMetalView *metalView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    image = [CIImage imageWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"download-6-38" withExtension:@"jpg"]];
}

-(void)configureViews {
    CIImage *outputImage = image;
    CIKernel *kernel = nil;
    if (kernelSelector.selectedSegmentIndex == 0) {
        NSData *data = [NSData dataWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"Dummy-ios" withExtension:@"metallib"]];
        kernel = [CIKernel kernelWithFunctionName:@"Dummy" fromMetalLibraryData:data error:nil];
    } else {
        kernel = [CIKernel kernelWithString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"Dummy" withExtension:@"glsl"] encoding:NSUTF8StringEncoding error:nil]];
    }
    
    if (kernel != nil) {
        outputImage = [kernel applyWithExtent:image.extent roiCallback:^CGRect(int index, CGRect destRect) { return destRect; } arguments:@[image]];
    }
    
    metalView.hidden = (backendSelector.selectedSegmentIndex == 1);
    openGLView.hidden = (backendSelector.selectedSegmentIndex == 0);
    
    if (backendSelector.selectedSegmentIndex == 0) {
        metalView.image = outputImage;
    } else {
        openGLView.image = outputImage;
    }
}

- (IBAction)selectorChanged:(id)sender {
    [self configureViews];
}

@end
