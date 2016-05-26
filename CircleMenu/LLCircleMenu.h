//
//  LLCircleMenu.h
//  LLCircleMenu
//
//  Created by Xiupeng Chen on 16/4/20.
//  Copyright (c) 2016 linglu_studio. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CIRCLEMENU_BUTTONS_MAX_COUNT 9

@class LLCircleMenu;

/*!
 * @brief The protocol of LLCircleMenu class.
 */
@protocol LLCircleMenuProtocol <NSObject>

/*!
 * @discussion When the circlemenu's button is clicked, this protocol method will be called.
 * @param circlemenu Specify the CircleMenu class.
 * @param index Specify the index of buttons in the CircleMenu.
 */
- (void)circlemenu:(LLCircleMenu *)circlemenu didSelectRowAtIndex:(NSInteger)index;

@end

/*!
 * @brief The custom circle menu class. You can customize the number of buttons with image and title between 1 and 9.
 */
@interface LLCircleMenu : UIControl

/*!
 * @brief The LLCircleMenu delegate.
 */
@property id<LLCircleMenuProtocol> delegate;

/*!
 * @brief The top level contain of custom view.
 */
@property UIView *container;

/*!
 * @brief The origin transform of the contain at the beginning.
 */
@property CGAffineTransform origTransform;

/*!
 * @brief The array of cloves' data structure.
 */
@property NSMutableArray *arrayClove;

/*!
 * @brief The array of cloves' view.
 */
@property NSMutableArray *arrayCloveView;

/*!
 * @discussion Initialization of CircleMenu with frame and delegate.
 * @param frame An CGRect frame to be used as the CircleMenu's frame.
 * @param delegate An delegate to be used as the CircleMenu's delegate.
 * @return An instance of the CircleMenu class.
 */
- (id)initWithFrame:(CGRect)frame andDelegate:(id)delegate;

/*!
 * @discussion Set the view with the button information including the button's title and the button's image.
 * @param info An NSArray class, each element contains the button's title and the button's image.
 */
- (void)setViewWithInfo:(NSArray *)info;

@end
