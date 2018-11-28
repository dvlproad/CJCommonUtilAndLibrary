//
//  STDemoTextFieldFactory.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/10/12.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CJBaseUIKit/CJTextField.h>
#import <CJBaseUIKit/UIColor+CJHex.h>

@interface STDemoTextFieldFactory : NSObject

///含左侧图片的textField，并支持通过leftButtonSelected属性切换图片变化 (使用场景：登录等)
+ (CJTextField *)textFieldWithNormalImage:(UIImage *)normalImage
                            selectedImage:(UIImage *)selectedImage;

///含 左侧label 的textField(使用场景：忘记密码、修改密码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText;


///含 左侧label 和 右侧button 的textField(使用场景：获取验证码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText rightButton:(UIButton *)rightButton;

@end
