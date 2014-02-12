//
//  DetalheInstituicaoV3ViewController.h
//  TuAjuda
//
//  Created by Guilherme Moresco Bisotto on 2/10/14.
//  Copyright (c) 2014 BEPiD.TuAjuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Instituicao.h"

@interface DetalheInstituicaoV3ViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property Instituicao *instituicao;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@end
