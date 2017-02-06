//
//  QRCodeReader.m
//  TinyPlus
//
//  Created by 小鱼儿 on 15/11/9.
//  Copyright © 2015年 Sunline. All rights reserved.
//

#import "TPQRCode.h"

@interface TPQRCode()
@property (strong, nonatomic) QRCodeViewController *qrCV;
@end

@implementation TPQRCode
@synthesize success;
@synthesize error;
@synthesize bottomTitle;

-(id)init
{
    if(self = [super init]) {
        _qrCV = [[QRCodeViewController alloc]init];
        _qrCV.delegate = self;
    }
    return self;
}

-(void)startReading
{
    UIViewController *window = [UIApplication sharedApplication].keyWindow.rootViewController;

    _qrCV.bottomTitle = self.bottomTitle;
    [window presentViewController:_qrCV animated:YES completion:nil];
}

#pragma mark  回调得到二维码扫描结果
-(void)scanData:(NSString *)data
{
    if (data!=nil) {
        [self.success callWithArguments:@[data]];
    }
    else
    {
        [self.error callWithArguments:@[@"失败"]];
    }
    error = nil;
    success = nil;
}

-(void)close:(NSInteger)type
{
    if(type == 100) {
        [self.error callWithArguments:@[[NSNumber numberWithInt:100]]];
    } else {
        error = nil;
        success = nil;
    }
}


@end
