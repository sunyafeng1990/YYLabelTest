//
//  ViewController.m
//  YYKit_labelTest
//
//  Created by 孙亚锋 on 2017/6/29.
//  Copyright © 2017年 LeiMo. All rights reserved.
////获取屏幕宽度
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
//获取屏幕高度
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import <YYKit/YYKit.h>
@interface ViewController ()
{
    NSMutableArray * _datas;
    NSString * _pinChuan;
    NSString *_pinChuan2;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dic1 = @{@"type":@"0",@"content":@"您好"};
    NSDictionary *dic2 = @{@"type":@"2",@"content":@"订单加好友@你"};
    NSDictionary *dic3 = @{@"type":@"0",@"content":@"已成功付款，您的订单进入"};
    NSDictionary *dic4 = @{@"type":@"3",@"content":@"待反馈"};
    NSDictionary *dic5 = @{@"type":@"0",@"content":@"。点击查看可"};
    NSDictionary *dic6 = @{@"type":@"6",@"content":@"添加好友！"};
    
    NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic5,dic6 ,nil];
    
    NSMutableArray *strArr =[NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in array) {
        [strArr addObject:dic[@"content"]];
    }
    _pinChuan = [strArr componentsJoinedByString:@""];
    
    
    
    
    // 1. Create an attributed string.
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:_pinChuan];
    
    // 2. Set attributes to text, you can use almost all CoreText attributes.
    text.font = [UIFont boldSystemFontOfSize:16.0f];
    text.color = [UIColor blueColor];
    
    text.lineSpacing = 5;
    
    for (NSDictionary * dic in array ) {
        //        NSLog(@"dic----%@",dic);
        if ([dic[@"type"]integerValue] != 0) {
            
            NSString * content = dic[@"content"];
            NSRange range = [_pinChuan rangeOfString:content];
            
            [text setTextHighlightRange:range color:[UIColor orangeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                
                NSLog(@"xxx 被点击了-  %@",dic);
            }];
        }
    }
    
    
    
    
    // 3. Set to YYLabel or YYTextView.
    YYLabel *label = [YYLabel new];
    CGFloat Height  = [self getterSpaceLabelHeight:_pinChuan withLineSpacing:5 withFont:[UIFont systemFontOfSize:16.0f] withWidth:KScreenWidth - 40];
    NSLog(@" string1 --->%@  height1  %f",_pinChuan,Height);
    label.frame = CGRectMake(20, 100,KScreenWidth  - 40, Height);
    label.attributedText = text;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:16.0f];
    label.backgroundColor = [UIColor lightGrayColor];
    [label sizeToFit];
    [self.view addSubview:label];
    
    //    ================================22222=======================
    
    [self tet2];

}
-(void)tet2{
    NSDictionary *dic1 = @{@"type":@"0",@"content":@"您好"};
    NSDictionary *dic2 = @{@"type":@"2",@"content":@"订单加好友@你"};
    NSDictionary *dic5 = @{@"type":@"0",@"content":@"。点击查看可"};
    NSDictionary *dic6 = @{@"type":@"6",@"content":@"添加好友！"};
    
    NSMutableArray * array2 = [[NSMutableArray alloc]initWithObjects:dic1,dic2,dic5,dic6 ,nil];
    
    NSMutableArray *strArr2 =[NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in array2) {
        [strArr2 addObject:dict[@"content"]];
    }
    _pinChuan2 = [strArr2 componentsJoinedByString:@""];
    
    // 1. Create an attributed string.
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc] initWithString:_pinChuan2];
    
    // 2. Set attributes to text, you can use almost all CoreText attributes.
    text2.font = [UIFont boldSystemFontOfSize:16.0f];
    text2.color = [UIColor blueColor];
    
    text2.lineSpacing = 0;
    __weak typeof(self) weakSelf = self;
    for (NSDictionary * dict2 in array2 ) {
        //        NSLog(@"dic----%@",dic2);
        if ([dict2[@"type"]integerValue] != 0) {
            
            NSString * content2 = dict2[@"content"];
            NSRange range2 = [_pinChuan2 rangeOfString:content2];
            
            [text2 setTextHighlightRange:range2 color:[UIColor orangeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                
                [weakSelf didSelectedDic:dict2];
            }];
        }
    }
    // 3. Set to YYLabel or YYTextView.
    YYLabel *label2 = [YYLabel new];
    CGFloat Height2  = [self getterSpaceLabelHeight:_pinChuan2 withLineSpacing:0 withFont:[UIFont systemFontOfSize:16.0f] withWidth:KScreenWidth - 40];
    NSLog(@"string2---->%@  height2---> %f",_pinChuan2,Height2);
    label2.frame = CGRectMake(20, 200,KScreenWidth  - 40, Height2);
    label2.attributedText = text2;
    label2.numberOfLines = 1;
    label2.font = [UIFont systemFontOfSize:16.0f];
    label2.backgroundColor = [UIColor lightGrayColor];
    [label2 sizeToFit];
    [self.view addSubview:label2];
    
    
    
    
}
- (CGFloat)getterSpaceLabelHeight:(NSString*)string withLineSpacing:(CGFloat)lineSpacing withFont:(UIFont*)font withWidth:(CGFloat)width{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@1.0f
                         };
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
    
    
}

-(void)didSelectedDic:(NSDictionary *)dic{
    NSLog(@"type---%@    content-----%@",dic[@"type"],dic[@"content"]);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
