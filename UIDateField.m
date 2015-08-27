//
//  UIDateField.m
//
//  Created by Bryan Dunbar on 3/5/13.
//

#import "UIDateField.h"

@interface UIDateField ()

-(void)datePickerChanged:(id)sender;
@end

@implementation UIDateField
@synthesize picker=_picker;
@synthesize dateMode=_dateMode;


-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

-(void)initialize {
    self.dateStyle = NSDateFormatterShortStyle;
    self.timeStyle = NSDateFormatterShortStyle;
    self.inputView = self.picker;
    self.hideOnSelection = NO;
}

-(NSDate*)selectedDate {
    return self.picker.date;
}
-(void)setSelectedDate:(NSDate *)date {
    self.picker.date = date;
    [self updateTextField];
    
}
-(UIDatePicker*)picker {
    if (!_picker) {
        _picker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        [_picker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _picker;
}

-(void)setDateMode:(UIDatePickerMode)dateMode {
    _dateMode = dateMode;
    self.picker.datePickerMode = _dateMode;
}

-(void)datePickerChanged:(id)sender {
    [self updateTextField];
    
    if (self.hideOnSelection)
        [self resignFirstResponder];
    
    if ([self.dateFieldDelegate respondsToSelector:@selector(dateChanged:)]) {
        [self.dateFieldDelegate dateChanged:self.picker.date];
    }
}

-(void)updateTextField {
    if (self.dateFormat) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = self.dateFormat;
        self.text = [formatter stringFromDate:self.picker.date];
    } else {
        self.text = [NSDateFormatter localizedStringFromDate:self.picker.date dateStyle:self.dateStyle timeStyle:self.timeStyle];
    }

}
@end