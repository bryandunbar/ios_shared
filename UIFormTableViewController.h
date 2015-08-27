//
//  UIFormTableViewController.h
//
//  Created by Bryan Dunbar on 4/12/12.
//

#import <UIKit/UIKit.h>
#import "UIDefaultAccessoryInputView.h"

@interface UIFormTableViewController : UITableViewController <UITextFieldDelegate, UIDefaultAccessoryInputViewDelegate>
-(IBAction)go;
-(void)hideKeyboard;
-(UIView*)findFirstResponder:(UIView*)view;

@property (nonatomic) BOOL showsDoneButton;
@end
