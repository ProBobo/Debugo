//
//  DGWindow.m
//  Debugo
//
//  GitHub https://github.com/ripperhe/Debugo
//  Created by ripper on 2018/9/1.
//  Copyright © 2018年 ripper. All rights reserved.
//


#import "DGWindow.h"
#import "DebugoEnable.h"

#define BoolString(boolValue) (boolValue?@"YES":@"NO")

@implementation DGWindow

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 防止旋转时四周有黑边
        self.clipsToBounds = YES;
        // 暂时关闭暗黑模式
        if (@available(iOS 13.0, *)) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        }
    }
    return self;
}

- (void)destroy {
    self.hidden = YES;
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    self.rootViewController = nil;
}

- (NSString *)description {
    NSString *description = [super description];
    NSString *newDescription = [NSString stringWithFormat:@"%@; name = %@; level = %.0f; hidden = %@; isKey = %@>",
                                [description substringToIndex:description.length - 1],
                                self.name,
                                self.windowLevel,
                                BoolString(self.isHidden),
                                BoolString(self.isKeyWindow)];
    return newDescription;
}

#pragma mark - private api
#if DebugoCanBeEnabled
// Prevent influence status bar
- (bool)_canAffectStatusBarAppearance {
    return self.dg_canAffectStatusBarAppearance;
}

// Prevent becoming keywindow
- (bool)_canBecomeKeyWindow {
    return self.dg_canBecomeKeyWindow;
}

// Prevent the system add self to [UIApplication sharedApplication].windows
- (bool)isInternalWindow {
    return self.dg_isInternalWindow;
}
#endif

@end
