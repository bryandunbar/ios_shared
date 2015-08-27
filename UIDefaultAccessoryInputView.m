//
//  UIDefaultAccessoryInputView.m

//  Created by Bryan Dunbar on 2/4/13.
//

#import "UIDefaultAccessoryInputView.h"

@interface UIDefaultAccessoryInputView ()

-(void)configureButtons;

@end
@implementation UIDefaultAccessoryInputView
@synthesize nextPrevSegment=_nextPrevSegment;
@synthesize accessoryInputViewDelegate=_accessoryInputViewDelegate;
@synthesize extraButtons=_extraButtons;
@synthesize showsDoneButton=_showsDoneButton;
@synthesize showsNextPrev=_showsNextPrev;
-(void)setShowsDoneButton:(BOOL)showsDoneButton {
    if (_showsDoneButton != showsDoneButton) {
        _showsDoneButton = showsDoneButton;
        [self configureButtons];
    }
}
-(void)setShowsNextPrev:(BOOL)showsNextPrev {
    if (_showsNextPrev != showsNextPrev) {
        _showsNextPrev = showsNextPrev;
        [self configureButtons];
    }
}
-(UISegmentedControl*)nextPrevSegment {
    if (!_nextPrevSegment) {
        _nextPrevSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]];
        //_nextPrevSegment.segmentedControlStyle = UISegmentedControlStyleBar;
        [_nextPrevSegment addTarget:self action:@selector(nextPrevTapped:) forControlEvents:UIControlEventValueChanged];
        _nextPrevSegment.momentary = YES;
    }
    return _nextPrevSegment;
}

-(id)init {
    return [self initWithHostView:nil];
}


-(id)initWithHostView:(UIView *)hostView {
    return [self initWithHostView:hostView andExtraButtons:nil];
}

-(id)initWithHostView:(UIView *)hostView andExtraButtons:(NSArray *)extraButtons {
    if (self = [super init]) {
        self.hostView = hostView;
        _extraButtons = extraButtons;
        //self.barStyle = UIBarStyleBlack;
        //self.barStyle = UIBarStyleBlackTranslucent;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self sizeToFit];
        _showsDoneButton = YES;
        CGRect frame = self.frame;
        frame.size.height = 44.0f;
        self.frame = frame;
        [self configureButtons];
    }
    
    return self;
}

-(void)configureButtons {
    
    NSDictionary* textAttributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:16]
                                     };

    UIBarButtonItem *nextPrevBtn = nil;
    if (self.showsNextPrev) {
        nextPrevBtn = [[UIBarButtonItem alloc] initWithCustomView:self.nextPrevSegment];
        [nextPrevBtn setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpaceright = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //[doneBtn setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    
    NSMutableArray *array = [NSMutableArray array];
    if (nextPrevBtn) {
        [array addObjectsFromArray:@[nextPrevBtn, flexibleSpaceLeft]];
    }
    [array addObject:flexibleSpaceright];
    
    
    if (self.showsDoneButton) {
        UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        [array addObject:doneBtn];
    } else {
        // Have to have something here to stop the flexible space
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = 1;
        [array addObject:space];
    }
    
    // Add any extra buttons
    for (int i = self.extraButtons.count - 1; i >= 0; i--) {
        
        UIBarButtonItem *extraButton = [self.extraButtons objectAtIndex:i];
        [extraButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
        
        [array insertObject:extraButton atIndex:1]; // After the segment control
    }
    
    self.items = nil;
    [self setItems:array];
    [self setNeedsDisplay];

}

-(void)setExtraButtons:(NSArray *)extraButtons {
    _extraButtons = extraButtons;
    [self configureButtons];
}

-(void)nextPrevTapped:(UISegmentedControl *)sender {
    if ([self.accessoryInputViewDelegate respondsToSelector:@selector(nextPrevTapped:)]) {
        [self.accessoryInputViewDelegate nextPrevTapped:self.nextPrevSegment];
    }
}

-(void)done:(id)sender {
    if ([self.accessoryInputViewDelegate respondsToSelector:@selector(doneTapped:)]) {
        [self.accessoryInputViewDelegate doneTapped:self];
    }

    // Resign the responder as we are done with it
    [self.hostView resignFirstResponder];

}

@end
