//
//  ViewController.h
//  trainspotting
//
//  Created by Kevin McNamee on 8/7/15.
//  Copyright (c) 2015 Frothy Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIView *flashView;

@property (strong, nonatomic) UITextView *clockView;
@property (strong, nonatomic) UITextView *dayView;
@property (strong, nonatomic) UITextView *expirationView;
@property (strong, nonatomic) NSTimer *timer;

@property (nonatomic, strong) UIButton *selectTicketButton;

@property (nonatomic)  int *currSeconds;


@end

