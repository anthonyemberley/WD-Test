//
//  newCreateFileViewController.m
//  WineDefinediOS
//
//  Created by Anthony Emberley on 11/9/14.
//  Copyright (c) 2014 Anthony Emberley. All rights reserved.
//

#import "newCreateFileViewController.h"

@interface newCreateFileViewController (){
    NSArray *appearancePickerData;
}

@end

@implementation newCreateFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appearancePickerData = @[@"item1", @"item2", @"item3"];
    self.appearancePickerView.dataSource = self;
    self.appearancePickerView.delegate = self;
    self.appearancePickerView.hidden = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if([pickerView isEqual: self.appearancePickerView]){
        return appearancePickerData.count;
        
        
    }
    else{
        return appearancePickerData.count;
    }

}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([pickerView isEqual: self.appearancePickerView]){
        return appearancePickerData[row];
    
        
    }
    else{
        return appearancePickerData[row];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
