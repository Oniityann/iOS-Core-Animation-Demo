//
//  CPMatchingView.m
//  Gailvlun
//
//  Created by Oniityann on 2018/4/18.
//  Copyright © 2018年 JianxunCultural. All rights reserved.
//

#import "CPMatchingView.h"

@interface CPMatchingView ()

@property (strong, nonatomic) CAShapeLayer *bigLayer;
@property (strong, nonatomic) CAShapeLayer *dynamicBallLayer;
@property (strong, nonatomic) CAShapeLayer *dynamicContentLayer;
@property (strong, nonatomic) CAShapeLayer *staticBallLayer;
@property (strong, nonatomic) CAShapeLayer *staticContentLayer;
@property (strong, nonatomic) CAShapeLayer *dashCircleLayer;
@property (strong, nonatomic) CAShapeLayer *dynamicCircleLayer;

@end

#define Color(color) [UIColor color]

@implementation CPMatchingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *textLabel = [UILabel new];
        textLabel.text = @"正在匹配中";
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.frame = self.bounds;
        [self addSubview:textLabel];
        [self configureSublayers];
    }
    return self;
}

- (void)configureSublayers {
    [self configureContentLayer];
    [self makeLayersAnimated];
}



- (void)configureContentLayer {
    
    CGFloat bigLayerWidth = self.bounds.size.width;
    CGFloat bigLayerHeight = self.bounds.size.height;
    
    CGPoint position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    UIBezierPath *bigLayerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, bigLayerWidth, bigLayerHeight)];
    
    _bigLayer = [CAShapeLayer layer];
    _bigLayer.frame = CGRectMake(0, 0, bigLayerWidth, bigLayerHeight);
    _bigLayer.path = bigLayerPath.CGPath;
    _bigLayer.lineWidth = 1.f;
    _bigLayer.strokeColor = Color(whiteColor).CGColor;
    _bigLayer.fillColor = Color(clearColor).CGColor;
    _bigLayer.position = position;
    [self.layer addSublayer:_bigLayer];
    
    CGFloat contentLayerWidth = bigLayerWidth - 32;
    CGFloat contentLayerHeight = bigLayerHeight - 32;
    CGRect contentLayerRect = CGRectMake(0, 0, contentLayerWidth, contentLayerHeight);
    
    UIBezierPath *centralCirclePath = [UIBezierPath bezierPathWithOvalInRect:contentLayerRect];
    
    _dashCircleLayer = [CAShapeLayer layer];
    _dashCircleLayer.bounds = contentLayerRect;
    _dashCircleLayer.path = centralCirclePath.CGPath;
    _dashCircleLayer.fillColor = Color(clearColor).CGColor;
    _dashCircleLayer.strokeColor =Color(whiteColor).CGColor;
    _dashCircleLayer.lineDashPattern = @[@1, @1];
    _dashCircleLayer.lineWidth = 0.5f;
    _dashCircleLayer.position = position;
    [self.layer addSublayer:_dashCircleLayer];
    
    _dynamicCircleLayer = [CAShapeLayer layer];
    _dynamicCircleLayer.bounds = contentLayerRect;
    _dynamicCircleLayer.path = centralCirclePath.CGPath;
    _dynamicCircleLayer.fillColor = Color(clearColor).CGColor;
    _dynamicCircleLayer.lineWidth = 1.0f;
    _dynamicCircleLayer.strokeColor = Color(whiteColor).CGColor;
    _dynamicCircleLayer.strokeStart = 0;
    _dynamicCircleLayer.strokeEnd = 1;
    _dynamicCircleLayer.affineTransform = CGAffineTransformMakeRotation(M_PI + M_PI_2);
    _dynamicCircleLayer.position = position;
    [self.layer addSublayer:_dynamicCircleLayer];

    
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:contentLayerRect];
    _dynamicContentLayer = [CAShapeLayer layer];
    _dynamicContentLayer.bounds = contentLayerRect;
    _dynamicContentLayer.path = rectPath.CGPath;
    _dynamicContentLayer.fillColor = Color(clearColor).CGColor;
    _dynamicContentLayer.strokeColor= Color(redColor).CGColor;
    _dynamicContentLayer.position = position;

    [self.layer addSublayer:_dynamicContentLayer];

    CGFloat ballLayerRadius = 4;

    _dynamicBallLayer = [CAShapeLayer layer];
    _dynamicBallLayer.frame = CGRectMake(0, 0, 2 * ballLayerRadius, 2 * ballLayerRadius);
    _dynamicBallLayer.cornerRadius = ballLayerRadius;
    _dynamicBallLayer.backgroundColor = Color(whiteColor).CGColor;
    _dynamicBallLayer.position = CGPointMake(contentLayerWidth / 2.0, 0);
    [_dynamicContentLayer addSublayer:_dynamicBallLayer];

    _staticContentLayer = [CAShapeLayer layer];
    _staticContentLayer.bounds = contentLayerRect;
    _staticContentLayer.fillColor = Color(clearColor).CGColor;
    _staticContentLayer.strokeColor= Color(whiteColor).CGColor;
    _staticContentLayer.position = position;


    [self.layer addSublayer:_staticContentLayer];

    _staticBallLayer = [CAShapeLayer layer];
    _staticBallLayer.frame = CGRectMake(0, 0, 2 * ballLayerRadius, 2 * ballLayerRadius);
    _staticBallLayer.cornerRadius = ballLayerRadius;
    _staticBallLayer.backgroundColor = Color(whiteColor).CGColor;
    _staticBallLayer.position = CGPointMake(contentLayerWidth / 2.0, 0);
    [_staticContentLayer addSublayer:_staticBallLayer];
}

- (void)makeLayersAnimated {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0f;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.00f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = INFINITY;
    [_dynamicCircleLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 3.0f;
    animation.repeatCount = INFINITY;
    animation.byValue = @(M_PI * 2);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
    [_dynamicContentLayer addAnimation:animation forKey:animation.keyPath];
}

@end
