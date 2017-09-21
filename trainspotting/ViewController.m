//
//  ViewController.m
//  trainspotting
//
//  Created by Kevin McNamee on 8/7/15.
//  Copyright (c) 2015 Frothy Labs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int secondsLeft;

- (void)viewDidLoad {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [super viewDidLoad];
    
    secondsLeft = 60;
    // Do any additional setup after loading the view, typically from a nib.
    self.selectTicketButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 100, 30)];
    [self.selectTicketButton addTarget:self
                                   action:@selector(selectPhoto:)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectTicketButton];
    [self.selectTicketButton sizeToFit];
    self.selectTicketButton.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = chosenImage;
    
    [self.view addSubview:self.imageView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.7f target:self selector:@selector(onTimerEvent:) userInfo:nil repeats:YES];
    self.flashView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 65, self.view.frame.size.width, 30)];
    self.flashView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.flashView];
    
    [self animateFlashView];
    [self showClock];
    [self showExpiration];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)showExpiration {
    self.expirationView = [[UITextView alloc] initWithFrame:CGRectMake(67, self.view.frame.size.height - 42, self.view.frame.size.width - 120, 40)];
    self.expirationView.backgroundColor = [UIColor whiteColor];
    self.expirationView.textAlignment = NSTextAlignmentCenter;
    [self.expirationView setFont:[UIFont systemFontOfSize:16.0f weight:UIFontWeightBold]];
    
    self.expirationView.text = @"Expires in 00:02:34:52";
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
    
    [self.view addSubview:self.expirationView];
}

- (void)updateCounter:(NSTimer *)theTimer {
    if(secondsLeft > 0 ){
        secondsLeft -- ;
        self.expirationView.text = [NSString stringWithFormat:@"Expires in 00:02:34:%02d", secondsLeft];
    }
    else{
        secondsLeft = 60;
    }
}

- (void)showClock {
    self.clockView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 133, self.view.frame.size.width, 40)];
    self.clockView.backgroundColor = [UIColor whiteColor];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    self.clockView.textAlignment = NSTextAlignmentCenter;
    [self.clockView setFont:[UIFont systemFontOfSize:21.0f weight:UIFontWeightBold]];
    [self.view addSubview:self.clockView];
    
    self.dayView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 40)];
    self.dayView.backgroundColor = [UIColor whiteColor];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    self.dayView.textAlignment = NSTextAlignmentCenter;
    [self.dayView setFont:[UIFont systemFontOfSize:21.0f weight:UIFontWeightBold]];
    [self.view addSubview:self.dayView];
}

- (void)timerTick:(NSTimer *)timer {
    NSDate *now = [NSDate date];
    
    static NSDateFormatter *timeFormatter;
    if (!timeFormatter) {
        timeFormatter = [[NSDateFormatter alloc] init];
        timeFormatter.dateFormat = @"hh:mm:ss aaa";  // very simple format  "8:47:22 AM"
    }
    self.clockView.text = [timeFormatter stringFromDate:now];
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"EEEE, MMM d, YYYY";  // very simple format  "8:47:22 AM"
    }
    self.dayView.text = [dateFormatter stringFromDate:now];
    
}

- (void)onTimerEvent:(NSTimer*)timer
{
    self.flashView.hidden = !self.flashView.hidden;
}

- (void)animateFlashView {

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
