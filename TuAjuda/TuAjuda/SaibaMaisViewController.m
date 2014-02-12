//
//  SaibaMaisViewController.m
//  WeHelp
//
//  Created by Bruno Rovea Soares on 10/02/14.
//  Copyright (c) 2014 Bruno Rovea Soares. All rights reserved.
//

#import "SaibaMaisViewController.h"

@interface SaibaMaisViewController ()

@end

@implementation SaibaMaisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITextView *txtSaibaMais = (UITextView*)[self.view viewWithTag:1];
    [txtSaibaMais setText:self.strSaibaMais];
    [txtSaibaMais setFont:[UIFont systemFontOfSize:15]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
