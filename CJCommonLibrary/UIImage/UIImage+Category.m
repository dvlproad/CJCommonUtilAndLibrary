//
//  UIImage+Category.m
//  Lee
//
//  Created by lichq on 14-12-26.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

//1.UIImage转成base64
- (NSString *)imageTobase64{
    NSData *_data = UIImageJPEGRepresentation(self, 1.0f);
    
    NSString *_encodedImageStr = [_data base64Encoding];
    
    //NSLog(@"===Encoded image:\n%@", _encodedImageStr);
    return _encodedImageStr;
}


@end
