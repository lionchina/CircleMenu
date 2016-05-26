//
//  LLCircleMenu.m
//  LLCircleMenu
//
//  Created by Xiupeng Chen on 16/4/20.
//  Copyright (c) 2016 linglu_studio. All rights reserved.
//

#import "LLCircleMenu.h"
#import <QuartzCore/QuartzCore.h>
#import "LLClove.h"

/*!
 * @brief the angle of the touch.
 */
static float deltaAngle;

@implementation LLCircleMenu

/*!
 * @discussion Initialization of CircleMenu with frame and delegate.
 * @param frame An CGRect frame to be used as the CircleMenu's frame.
 * @param delegate An delegate to be used as the CircleMenu's delegate.
 * @return An instance of the CircleMenu class.
 */
- (id)initWithFrame:(CGRect)frame andDelegate:(id)delegate {
    if ((self = [super initWithFrame:frame])) {
        // Initial the delegate.
        self.delegate = delegate;
        
        // draw the custom view.
        [self drawWheel];
    }
    return self;
}

/*!
 * @discussion Set the view with the button information including the button's title and the button's image.
 * @param info An NSArray class, each element contains the button's title and the button's image.
 */
- (void)setViewWithInfo:(NSArray *)info {
    // Traverse the array of buttons.
    for (int i = 0; i < CIRCLEMENU_BUTTONS_MAX_COUNT; i++) {
        // Get the imageview
        UIImageView *im = [_arrayCloveView objectAtIndex:(CIRCLEMENU_BUTTONS_MAX_COUNT - 1 - i)];
        
        if (i < info.count) {
            // If the information is given.
            
            // Set the image.
            UIImageView *cloveImage = [[[[im subviews] firstObject] subviews] firstObject];
            cloveImage.image = [UIImage imageNamed:[[info objectAtIndex:i] objectForKey:@"image"]];
            
            // Set the title.
            UILabel *cloveLabel = [[[[im subviews] firstObject] subviews] lastObject];
            cloveLabel.text = [[info objectAtIndex:i] objectForKey:@"title"];
            
            // Show the imageview.
            [im setHidden:NO];
        } else {
            // If the information is not given, hide the imageview.
            [im setHidden:YES];
        }
    }
}

/*!
 * @brief The method is used to draw the custom view.
 */
- (void) drawWheel {
    // Initial the container.
    _container = [[UIView alloc] initWithFrame:self.frame];
    
    // Calculate the angle of each clove.
    CGFloat angleSize = 2.0 * M_PI / (CIRCLEMENU_BUTTONS_MAX_COUNT + 1);
    
    // Initial the array of cloves' view.
    _arrayCloveView = [[NSMutableArray alloc] init];
    
    // Traverse the array of cloves' view.
    for (int i = 0; i < CIRCLEMENU_BUTTONS_MAX_COUNT; i++) {
        
        // Create a imageview with the correct frame, anchorPoint, position, transform and tag.
        UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _container.bounds.size.width / 2.0, 50.0f)];
        im.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
        im.layer.position = CGPointMake(_container.bounds.size.width / 2.0, _container.bounds.size.height / 2.0);
        im.transform = CGAffineTransformMakeRotation(- angleSize * i - angleSize / 2.0);
        im.tag = i;
        
        // Create a view with the correct frame and transform.
        UIView *cloveView = [[UIView alloc] initWithFrame:CGRectMake(_container.bounds.size.width / 2.0 - 60, 5, 40, 40)];
        cloveView.transform = CGAffineTransformMakeRotation(angleSize * i + angleSize / 2.0);
        [im addSubview:cloveView];
        
        // Create a imageview with the correct frame and image.
        UIImageView *cloveImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        cloveImage.image = [UIImage imageNamed:@"item_bg.png"];
        [cloveView addSubview:cloveImage];
        
        // Create a label with the correct frame, text, color, alignment and font.
        UILabel *cloveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 30, 10)];
        cloveLabel.text = [NSString stringWithFormat:@"%d", i];
        cloveLabel.textColor = [UIColor whiteColor];
        cloveLabel.textAlignment = NSTextAlignmentCenter;
        cloveLabel.font = [UIFont systemFontOfSize:11.0f];
        [cloveView addSubview:cloveLabel];
        
        // Add all views into the container.
        [_container addSubview:im];
        
        // Hide all views firstly.
        [im setHidden:YES];
        
        // Initial the array of cloves' view.
        [_arrayCloveView addObject:im];
        
        // Create a line view with the correct frame, color, anchorPoint and transform.
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _container.bounds.size.width / 2.0 - 20, 1.0f)];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
        lineView.layer.position = CGPointMake(_container.bounds.size.width / 2.0, _container.bounds.size.height / 2.0);
        lineView.transform = CGAffineTransformMakeRotation(- angleSize * i - angleSize);
        [_container addSubview:lineView];
    }
    
    // Create the "Add" button just like above Setup, the only difference is the image, title and tag.
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _container.bounds.size.width / 2.0, 50.0f)];
    im.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
    im.layer.position = CGPointMake(_container.bounds.size.width / 2.0, _container.bounds.size.height / 2.0);
    im.transform = CGAffineTransformMakeRotation(- angleSize * 9 - angleSize / 2.0);
    im.tag = 9;
    UIImageView *cloveImage = [[UIImageView alloc] initWithFrame:CGRectMake(_container.bounds.size.width / 2.0 - 50, 15.0, 20, 20)];
    cloveImage.image = [UIImage imageNamed:@"item_add.png"];
    cloveImage.transform = CGAffineTransformMakeRotation(angleSize * 9 + angleSize / 2.0);
    [im addSubview:cloveImage];
    [_container addSubview:im];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _container.bounds.size.width / 2.0 - 20, 1.0f)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
    lineView.layer.position = CGPointMake(_container.bounds.size.width / 2.0, _container.bounds.size.height / 2.0);
    lineView.transform = CGAffineTransformMakeRotation(- angleSize * 9 - angleSize);
    [_container addSubview:lineView];
    
    // Disable the interaction.
    _container.userInteractionEnabled = NO;
    
    // Add the container into the view.
    [self addSubview:_container];
    
    // Initial the array of the cloves' data structure with the capacity.
    _arrayClove = [NSMutableArray arrayWithCapacity:(CIRCLEMENU_BUTTONS_MAX_COUNT + 1)];
    
    // Create the center imageview.
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
    bg.image = [UIImage imageNamed:@"center_bg.png"];
    [self addSubview:bg];
    
    // Create the mask view.
    UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 104, 104)];
    mask.image =[UIImage imageNamed:@"center.png"] ;
    mask.center = self.center;
    [self addSubview:mask];
    
    // Calculate the data of cloves.
    [self buildCloves];
}

/*!
 * @brief Calculate the data of cloves.
 */
- (void) buildCloves {
    // Initial the values.
    CGFloat fanWidth = M_PI * 2.0 / (CIRCLEMENU_BUTTONS_MAX_COUNT + 1);
    CGFloat min = 0;
    
    // Traverse the array of cloves' data structure.
    for (int i = 0; i < 10; i++) {
        LLClove *clove = [[LLClove alloc] init];
        
        // Set minValue.
        clove.minValue = min;
        
        // Set midValue.
        clove.midValue = min + fanWidth/2;
        
        // Set maxValue.
        clove.maxValue = min + fanWidth;
        
        // Set value.
        clove.value = i;
        
        // Update min.
        min += fanWidth;
        
        // Add the element into the array.
        [_arrayClove addObject:clove];
    }
}


/*!
 * @brief Calculate the distance from center.
 * @param point The CGPoint of the pointer.
 * @return The distance between point to the center.
 */
- (float) calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

/*!
 * @discussion Sent to the control when a touch related to the given event enters the control’s bounds. 
 * YES if the receiver is set to respond continuously or set to respond when a touch is dragged; otherwise NO.
 * @param touch A UITouch object that represents a touch on the receiving control during tracking.
 * @param event An event object encapsulating the information specific to the user event.
 * @return YES if the receiver is set to respond continuously or set to respond when a touch is dragged; otherwise NO.
 */
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // Get the touch point.
    CGPoint touchPoint = [touch locationInView:self];
    
    // Calculate the distance between the touch point and the center.
    float dist = [self calculateDistanceFromCenter:touchPoint];
    
    // Force a tap to be on the ferrule.
    if (dist < 40 || dist > 100) {
        return NO;
    }
    
    // Calculate the angle.
    float dx = touchPoint.x - _container.center.x;
    float dy = touchPoint.y - _container.center.y;
    deltaAngle = atan2(dy,dx);
    
    // Log the origin transform.
    _origTransform = _container.transform;
    
    return YES;
}

/*!
 * @discussion Sent continuously to the control as it tracks a touch related to the given event within the control’s bounds.
 * YES if touch tracking should continue; otherwise NO.
 */
- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event {
    // Get the touch point.
    CGPoint pt = [touch locationInView:self];
    
    // Calculate the distance between the touch point and the center.
    float dist = [self calculateDistanceFromCenter:pt];
    
    // a drag path too close to the center
    if (dist < 40 || dist > 100) {
        // here you might want to implement your solution when the drag is too close to the center
        // You might go back to the clove previously selected or you might calculate the clove corresponding to the "exit point" of the drag.
    }
    
    // Calculate the angle.
    float dx = pt.x - _container.center.x;
    float dy = pt.y - _container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = deltaAngle - ang;
    
    // Change the container's transform.
    _container.transform = CGAffineTransformRotate(_origTransform, -angleDifference);
    
    // Change the cloves' transform.
    for (UIImageView *im in [_container subviews]) {
        UIImageView *cloveImage = [[im subviews] firstObject];
        cloveImage.transform = CGAffineTransformMakeRotation(-atan2f(_container.transform.b, _container.transform.a)-atan2f(im.transform.b, im.transform.a));
    }
    
    return YES;
}


/*!
 * @brief Sent to the control when the last touch for the given event completely ends, telling it to stop tracking.
 */
- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event {
    // Get the touch point.
    CGPoint touchPoint = [touch locationInView:self];
    
    // Calculate the radians of the touch point's angle.
    CGFloat touchRadians = atan2f(- (touchPoint.y - _container.center.y), (touchPoint.x - _container.center.x));
    if (touchRadians < 0) {
        touchRadians = touchRadians + 2 * M_PI;
    }
    
    // Calculate the radians of the container's angle.
    CGFloat radians = atan2f(_container.transform.b, _container.transform.a);
    if (radians < 0) {
        radians = radians + 2 * M_PI;
    }
    
    // Add the radians.
    CGFloat intervalRadians = touchRadians + radians;
    if (intervalRadians > 2 * M_PI) {
        intervalRadians = intervalRadians - 2 * M_PI;
    }
    CGFloat newVal = 0.0;
    int currentValue = 0;
    for (LLClove *c in _arrayClove) {
        if (intervalRadians > c.minValue && intervalRadians < c.maxValue) {
            currentValue = c.value;
        }
    }

    CGFloat startTransformRadians = atan2f(_origTransform.b, _origTransform.a);
    if (startTransformRadians < 0) {
        startTransformRadians = startTransformRadians + 2 * M_PI;
    }
    
    // Call the method of circlemenu:didSelectRowAtIndex
    if (fabs(startTransformRadians - radians) < 0.1 && ((8 - currentValue) < _arrayClove.count || (8 - currentValue) == -1)) {
        [self.delegate circlemenu:self didSelectRowAtIndex:(8 - currentValue)];
    }
    
    // Play the animation and change the transform.
    newVal = 0.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    CGAffineTransform t = CGAffineTransformRotate(_container.transform, -newVal);
    _container.transform = t;
    for (UIImageView *im in [_container subviews]) {
        UIImageView *cloveImage = [[im subviews] firstObject];
        cloveImage.transform = CGAffineTransformMakeRotation(-atan2f(_container.transform.b, _container.transform.a)-atan2f(im.transform.b, im.transform.a));
    }
    [UIView commitAnimations];
}

@end
