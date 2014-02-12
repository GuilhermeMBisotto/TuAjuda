//
//  ListaInstTableViewController.h
//  TuAjuda
//
//  Created by Guilherme Moresco Bisotto on 2/7/14.
//  Copyright (c) 2014 BEPiD.TuAjuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaInstTableViewController : UITableViewController

@property int quantInst;
@property NSMutableArray *listaInstituicoesReceiv;
@property NSArray *tipos;
@property NSArray *locallizacao;
@property NSString *busca;

@end
