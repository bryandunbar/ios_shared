//
//  UIDefaultAccessoryInputView.h
//
//  Created by Bryan Dunbar on 2/4/13.

#import <UIKit/UIKit.h>
@class UIDefaultAccessoryInputView;

@protocol UIDefaultAccessoryInputViewDelegate <NSObject>
-(void)nextPrevTapped:(UISegmentedControl*)sender;
-(void)doneTapped:(UIDefaultAccessoryInputView*)sender;
@end

@interface UIDefaultAccessoryInputView : UIToolbar

@property (nonatomic,strong) UIView *hostView;
@property (nonatomic,strong) UISegmentedControl *nextPrevSegment;
@property (nonatomic,weak) id<UIDefaultAccessoryInputViewDelegate> accessoryInputViewDelegate;
@property (nonatomic) BOOL showsDoneButton;
@property (nonatomic) BOOL showsNextPrev;
@property (nonatomic,strong) NSArray *extraButtons;

-(id)initWithHostView:(UIView*)hostView;
-(id)initWithHostView:(UIView*)hostView andExtraButtons:(NSArray*)extraButtons;


@end
