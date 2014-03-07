//
//  LumpPhotoCell.h
//  JSONExample
//
//  Created by Eblin Lopez on 3/6/14.
//  Copyright (c) 2014 Eblin Lopez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LumpPhotoCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *imgTitle;
//    @property (nonatomic, strong) IBOutlet UIImage *imgView;
    @property (nonatomic, strong) NSDictionary *lump;
@end
