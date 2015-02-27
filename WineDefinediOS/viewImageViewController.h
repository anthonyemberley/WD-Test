//
//  viewImageViewController.h
//  WineDefinediOS
//
//  Created by Anthony Emberley on 1/8/15.
//  Copyright (c) 2015 Anthony Emberley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface viewImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *leftImageImage;
@property (strong,nonatomic) UIImage *rightImageImage;
@property NSInteger switchInt;

@end
