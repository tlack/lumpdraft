//
//  ViewController.m
//  JSONExample
//
//  Created by Eblin Lopez on 3/6/14.
//  Copyright (c) 2014 Eblin Lopez. All rights reserved.
//

#import "ViewController.h"
#import "LumpPhotoCell.h"
#import "NHLinearPartition.h"
#import "NHBalancedFlowLayout.h"

static NSString *const BaseURLSring = @"http://lump.co/";

@interface ViewController () <NHBalancedFlowLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (weak, nonatomic) IBOutlet UITextView *jsonText;
@property (strong, nonatomic) NSArray *json;
@end

@implementation ViewController

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(NHBalancedFlowLayout *)collectionViewLayout preferredSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *lump = [self.json objectAtIndex:indexPath.item];
    CGSize thumbSize = CGSizeFromString([NSString stringWithFormat:@"{%@, %@}", lump[@"pic"][@"thumbnail_width"], lump[@"pic"][@"thumbnail_height"]]);
    return thumbSize;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.json count];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *lump = [self.json objectAtIndex:indexPath.row];
    LumpPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LumpCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
    cell.lump = lump;
    
    
    
    //shadow
    /*cell.layer.masksToBounds = NO;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 3.0f;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.50f;
    cell.layer.shadowRadius = 3.0f;
    cell.layer.shadowOffset = CGSizeZero;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.shouldRasterize = YES;*/

    
    return cell;
}

- (IBAction)getJson:(id)sender {
    // setup url/request
    NSString *indexUrl = [NSString stringWithFormat:@"%@index.json", BaseURLSring];
    NSURL *url = [NSURL URLWithString:indexUrl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    //get json with AFNetworking
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    //server returns text/html instead of application/json
//    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *json = (NSDictionary *)responseObject;
//        NSDictionary *json = responseObject;
        self.json = (NSArray *)responseObject;
        
        [self.collectionView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //show error alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"okie dokie" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    [operation start];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    //todo
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //todo
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *lump = [self.json objectAtIndex:indexPath.row];
//    CGSize thumbSize = CGSizeFromString([NSString stringWithFormat:@"{%@, %@}", lump[@"pic"][@"thumbnail_width"], lump[@"pic"][@"thumbnail_height"]]);
//    CGSize retval = thumbSize.width > 0 ? thumbSize : CGSizeMake(100, 100);
////    retval.height += 35; retval.width += 35;
//    return retval;
//    
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"lumpCell"];

    
//    NHBalancedFlowLayout *layout = (NHBalancedFlowLayout *)self.collectionViewLayout;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
