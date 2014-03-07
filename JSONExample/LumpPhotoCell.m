//
//  LumpPhotoCell.m
//  JSONExample
//
//  Created by Eblin Lopez on 3/6/14.
//  Copyright (c) 2014 Eblin Lopez. All rights reserved.
//

#import "LumpPhotoCell.h"

@implementation LumpPhotoCell

- (UIImage *) getImage:(NSString *)url {
    NSError *error;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]
                                              options:0
                                                error:&error];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}
- (void) setLump:(NSDictionary *)lump {
    if(_lump != lump){
        _lump = lump;
    }
    
    NSString *imgurl = _lump[@"pic"][@"cdn_url"];
    NSString *imgtitle = _lump[@"title"];
    self.imgTitle.text = imgtitle;
    self.imgView.image = [self getImage:imgurl];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
