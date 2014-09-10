//
//  UIPickerFIeld.h
//
//  Created by Bryan Dunbar on 3/19/14.
//  Copyright (c) 2014 bdun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIPickerField;

@protocol UIPickerFieldDelegate <UITextFieldDelegate>

-(void)pickerField:(UIPickerField*)pickerField didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end

@interface UIPickerField : UITextField

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, strong) NSString *displayProperty;
@property (nonatomic, strong) id selectedChoice;
@property (nonatomic,weak) id<UIPickerFieldDelegate> delegate;

-(void)setSelectedRow:(NSUInteger)row inComponent:(NSUInteger)component animated:(BOOL)animated;
-(NSString*)displayValueForSelectedChoice;
@end
