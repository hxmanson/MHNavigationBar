//
//  MHItemTitleBGView.m
//  MHTestCustomNavBar
//
//  Created by Manson Hu on 16/9/19.
//  Copyright © 2016年 MHX. All rights reserved.
//

#import "MHDefaultItemTitleBGView.h"
#import "UILabel+MHLabelUtil.h"
#import "MHDefines.h"

@interface MHDefaultItemTitleBGView()
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTitleImgViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTitleLabelWidth;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImgView;
@end

@implementation MHDefaultItemTitleBGView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _titleLabel.shouldAutoAdjustLabelWidth = YES;
}

-(void)reloadNavItem
{
    _titleLabel.textColor = self.navBarItemModel.textColor;
    _titleLabel.font = self.navBarItemModel.textFont;
    
    [self setTitle];
    [self setTitleImage];
}

-(void)layoutSubviews
{
    if (!kIOS_VERSION_11_OR_ABOVE)
    {
        self.frame = self.adjustFrame;
        
        if (_constraintTitleLabelWidth.constant > self.frame.size.width)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                _constraintTitleLabelWidth.constant = self.frame.size.width;
            });
        }
    }
    [self.superview sendSubviewToBack:self];
}

-(void)setTitle
{
    NSString *title = self.navBarItemModel.itemText;
    _titleLabel.text = title?title:@"";
}

-(void)setTitleImage
{
    UIImage *titleImage = self.navBarItemModel.itemImg;
    _titleImgView.image = titleImage;
}

@end
