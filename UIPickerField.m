//
//  UIPickerFIeld.m
//
//  Created by Bryan Dunbar on 3/19/14.
//

#import "UIPickerField.h"

@interface UIPickerField () <UIPickerViewDataSource, UIPickerViewDelegate>

-(NSString*)displayValueForRow:(NSUInteger)row;

@end

@implementation UIPickerField

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
    self.inputView = self.picker;
    self.displayProperty = @"description";
}


-(UIPickerView*)picker {
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _picker.showsSelectionIndicator = YES;
        _picker.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}


-(void)setSelectedChoice:(id)selectedChoice {
    
    if (_selectedChoice != selectedChoice) {
        _selectedChoice = selectedChoice;
        NSString *newChoiceDisplayValue = [self displayValueForChoice:selectedChoice];
        for (int i = 0; i < self.choices.count; i++) {
            NSString *choiceDisplayValue = [self displayValueForChoice:self.choices[i]];
            if ([choiceDisplayValue isEqualToString:newChoiceDisplayValue]) {
                [self setSelectedRow:i inComponent:0 animated:NO];
                return;
            }
        }
    }
    
}
-(void)setSelectedRow:(NSUInteger)row inComponent:(NSUInteger)component animated:(BOOL)animated {
    [self.picker selectRow:row inComponent:component animated:animated];
    self.text = [self displayValueForRow:row];
}


#pragma mark - UIPickerViewDelegate and Datasource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.choices.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self displayValueForRow:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedChoice = self.choices[row];
    self.text = [self displayValueForRow:row];
}

-(NSString*)displayValueForRow:(NSUInteger)row {
    return [self displayValueForChoice:self.choices[row]];
}

-(NSString*)displayValueForChoice:(id)choice {
    id candidateTitle = choice;
    if ([candidateTitle isKindOfClass:[NSString class]]) {
        return candidateTitle;
    } else {
        return [candidateTitle valueForKey:self.displayProperty];
    }
    
}

-(void)pickerChanged:(id)sender {
//    self.text = [NSDateFormatter localizedStringFromDate:self.picker.date dateStyle:self.dateStyle timeStyle:self.timeStyle];
//    
//    if ([self.dateFieldDelegate respondsToSelector:@selector(dateChanged:)]) {
//        [self.dateFieldDelegate dateChanged:self.picker.date];
//    }
}
@end
