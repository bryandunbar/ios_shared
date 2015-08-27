//
//  UIDateField.h
//
//  Created by Bryan Dunbar on 3/5/13.
//

#import <UIKit/UIKit.h>
@protocol UIDateFieldDelegate <NSObject>

-(void)dateChanged:(NSDate*)newDate;

@end

@interface UIDateField : UITextField

@property (nonatomic,readonly) UIDatePicker *picker;
@property (nonatomic,assign) UIDatePickerMode dateMode;
@property (nonatomic) NSDateFormatterStyle dateStyle;
@property (nonatomic) NSDateFormatterStyle timeStyle;
@property (nonatomic) NSString *dateFormat;
@property (nonatomic) BOOL hideOnSelection;
@property (nonatomic,weak) id<UIDateFieldDelegate> dateFieldDelegate;
@property  (nonatomic,strong) NSDate *selectedDate;
-(void)initialize;

@end
