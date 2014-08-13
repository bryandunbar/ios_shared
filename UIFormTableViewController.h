//
//  UIFormTableViewController.h
//
//  Created by Bryan Dunbar on 4/12/12.
//

#import <UIKit/UIKit.h>
#import "UIDefaultAccessoryInputView.h"

@interface UIFormTableViewController : UITableViewController <UITextFieldDelegate, UIDefaultAccessoryInputViewDelegate>
-(void)go;
-(void)hideKeyboard;

@property (nonatomic) BOOL showsDoneButton;
@end
