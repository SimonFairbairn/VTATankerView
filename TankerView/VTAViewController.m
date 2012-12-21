//
//  VTAViewController.m
//  TankerView
//
//  Created by Simon Fairbairn on 19/12/2012.
//  Copyright (c) 2012 Simon Fairbairn. All rights reserved.
//

#import "VTAViewController.h"
#import "VTATankerView.h"


@interface VTAViewController ()

@property (nonatomic, strong) VTATankerView *imageTanker;
@property (nonatomic, strong) VTATankerView *pickerTanker;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *picker;


@end

@implementation VTAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Grab a new image view with an image
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bug-boy"]];

    
    // Grab a tanker
    self.imageTanker = [VTATankerView newTanker];
    // Configure the tanker
    self.imageTanker.shouldStretchContent = NO;
    // Load 'er up
    self.imageTanker.content = self.imageView;
    // Set sail
    [self.view addSubview:self.imageTanker];
    
	// Something more complicated? A DatePicker perhaps?
//    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
//    self.datePicker.date = [NSDate date];
//    self.datePicker.datePickerMode = UIDatePickerModeDate;

    self.picker = [[UIPickerView alloc] init];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    
    // Grab a tanker
    self.pickerTanker = [VTATankerView newTanker];
    self.pickerTanker.shouldRespondToSwipe = YES;
    // Load the old girl up
    self.pickerTanker.content = self.picker;
    // Set sail
    [self.view addSubview:self.pickerTanker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button:(UIButton *)sender {
    if ( sender.tag == 1 ) {
        
        if ( self.imageTanker.containerViewActive == YES ) {
            [self.imageTanker hide];
        } else {
            [self.imageTanker show];
        }
    } else {
        
        if ( self.pickerTanker.containerViewActive == YES ) {
            [self.pickerTanker hide];
        } else {
            [self.pickerTanker show];
        }
    }
}

- (IBAction)darkenSwitch:(UISwitch *)sender {
    self.imageTanker.shouldDarkenScreen = sender.isOn;
    self.pickerTanker.shouldDarkenScreen = sender.isOn;
}



-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 1;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

@end
