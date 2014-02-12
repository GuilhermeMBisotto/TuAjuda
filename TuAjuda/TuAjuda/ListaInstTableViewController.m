//
//  ListaInstTableViewController.m
//  TuAjuda
//
//  Created by Guilherme Moresco Bisotto on 2/7/14.
//  Copyright (c) 2014 BEPiD.TuAjuda. All rights reserved.
//

#import "ListaInstTableViewController.h"
#import "Instituicao.h"
#import "DetalheInstituicaoV3ViewController.h"

@interface ListaInstTableViewController ()

@end

@implementation ListaInstTableViewController
{
    //   NSMutableDictionary *dicSections;
    int instSelected;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //    dicSections = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *navBarTextAttributes = [NSMutableDictionary dictionaryWithCapacity:1];
    [navBarTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName ];
    self.navigationController.navigationBar.titleTextAttributes = navBarTextAttributes;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //[self CarregaInstituicoes];
}

//-(void) CarregaInstituicoes
//{
//    NSMutableArray *listIns = [[NSMutableArray alloc]init];
//    
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    for(int i = 0; i < _quantInst;i++)
//    {
//        Instituicao *inst = [[Instituicao alloc]init];
//        NSString *keyNome = [NSString stringWithFormat:@"nome%d",i];
//        NSString *keyImagem = [NSString stringWithFormat:@"imagem%d",i];
//        NSString *keyAreaAtuacao = [NSString stringWithFormat:@"areaAtuacao%d",i];
//        NSString *keyEndereco = [NSString stringWithFormat:@"endereco%d",i];
//        NSString *keyTelefone = [NSString stringWithFormat:@"telefone%d",i];
//        NSString *keyEmail = [NSString stringWithFormat:@"email%d",i];
//        NSString *keySite = [NSString stringWithFormat:@"site%d",i];
//        NSString *keyBairro = [NSString stringWithFormat:@"bairro%d",i];
//        NSString *keyCidade = [NSString stringWithFormat:@"cidade%d",i];
//        NSString *keyUf = [NSString stringWithFormat:@"uf%d",i];
//        NSString *keyBrevePerfil = [NSString stringWithFormat:@"brevePerfil%d",i];
//        NSString *keyMissao = [NSString stringWithFormat:@"missao%d",i];
//        NSString *keyPrincipaisParceiros = [NSString stringWithFormat:@"principaisParceiros%d",i];
//        NSString *keyProjeto = [NSString stringWithFormat:@"projeto%d",i];
//        NSString *keyComoAjudar = [NSString stringWithFormat:@"comoAjdar%d",i];
//        
//        inst.nome = [defaults objectForKey:keyNome];
//        NSString *nomeImagem = [NSString stringWithFormat:@"%@_capa.jpeg",inst.nome];
//        UIImage *imagemArq1 = [UIImage imageNamed:nomeImagem];
//        
//        inst.imagem = imagemArq1;
//        
//        inst.nome = [defaults objectForKey:keyNome];
//        inst.areaAtuacao = [defaults objectForKey:keyAreaAtuacao];
//        inst.endereco = [defaults objectForKey:keyEndereco];
//        inst.telefone = [defaults objectForKey:keyTelefone];
//        inst.email = [defaults objectForKey:keyEmail];
//        inst.site = [defaults objectForKey:keySite];
//        inst.bairro = [defaults objectForKey:keyBairro];
//        inst.cidade = [defaults objectForKey:keyCidade];
//        inst.uf = [defaults objectForKey:keyUf];
//        inst.brevePerfil = [defaults objectForKey:keyBrevePerfil];
//        inst.missao = [defaults objectForKey:keyMissao];
//        inst.principaisParceiros = [defaults objectForKey:keyPrincipaisParceiros];
//        inst.projeto = [defaults objectForKey:keyProjeto];
//        inst.comoAjudar = [defaults objectForKey:keyComoAjudar];
//        
//        NSMutableArray *arrayImage = [[NSMutableArray alloc]init];
//        //        arrayImage = [[NSMutableArray alloc]init];
//        
//        for(int j = 1; j <= 5;j++){
//            NSString *imgName = [NSString stringWithFormat:@"image%dinst%d.jpeg",j,i+1];
//            //            UIImageView *image1 = [[UIImageView alloc]init];
//            //            image1.image = [UIImage imageNamed:imgName];
//            [arrayImage addObject:imgName];
//            //            [inst.listaImagens addObject:imgName];
//        }
//        
//        inst.listaImagens = arrayImage;
//        [listIns addObject:inst];
//        
//    }
//    
//    NSMutableArray *listaFinal = [[NSMutableArray alloc]init];
//    listaFinal = [self filtra:listIns withTipos:_tipos withLoca:_locallizacao];
//    
//    if ([_tipos[0] isEqualToString:@""] && [_locallizacao[0] isEqualToString:@""]) {
//        _listaInstituicoesReceiv = listIns;
//    }
//    else
//        _listaInstituicoesReceiv = listaFinal;
//    
//}
//
//-(NSMutableArray*)filtra: (NSMutableArray*)listCompleta withTipos:(NSArray*)tipos withLoca:(NSArray*)loc
//{
//    NSMutableArray *arrayAux = [[NSMutableArray alloc]init];
//    
//    if ([tipos[0] isEqualToString:@""]) {
//        for (int i = 0; i < listCompleta.count; i++) {
//            NSString *locIntC = [listCompleta[i]cidade];
//            for (int j= 0; j < loc.count; j++) {
//                NSString *locInt = loc[j];
//                if ([locIntC isEqualToString:locInt]) {
//                    [arrayAux addObject:listCompleta[i]];
//                }
//            }
//        }
//    }
//    else if ([loc[0] isEqualToString:@""]){
//        for (int i = 0; i < listCompleta.count; i++) {
//            NSString *tipoIntC = [listCompleta[i]areaAtuacao];
//            for (int j= 0; j < tipos.count; j++) {
//                NSString *tipoInt = tipos[j];
//                if ([tipoIntC isEqualToString:tipoInt]) {
//                    [arrayAux addObject:listCompleta[i]];
//                }
//            }
//        }
//    }
//    else {
//        for (int i = 0; i < listCompleta.count; i++) {
//            NSString *tipoIntC = [listCompleta[i]areaAtuacao];
//            NSString *locIntC = [listCompleta[i]cidade];
//            for (int j= 0; j < tipos.count; j++) {
//                NSString *tipoInt = tipos[j];
//                for (int g = 0; g < loc.count; g++) {
//                    NSString *locInt = loc[g];
//                    if ([tipoIntC isEqualToString:tipoInt] && [locIntC isEqualToString:locInt]) {
//                        [arrayAux addObject:listCompleta[i]];
//                    }
//                }
//            }
//        }
//    }
//    
//    return arrayAux;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _listaInstituicoesReceiv.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellInstituicao";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //    cell.imageView.image = [[self.listaInst objectAtIndex:indexPath.row]imagem];
    //    Instituicao *instObj = (Instituicao *)dicSections[dicSections.allKeys[indexPath.section]];
    //    UILabel *label = (UILabel *)[cell viewWithTag:2];
    //    labelNomeInst.backgroundColor = [UIColor lightGrayColor];

    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    imageView.image = [_listaInstituicoesReceiv[indexPath.row]imagem];
    
    UILabel *labelNomeInst = (UILabel *)[cell viewWithTag:5];
    labelNomeInst.text = [_listaInstituicoesReceiv[indexPath.row]nome];
    
    UILabel *labelAreaAtuacaoInst = (UILabel *)[cell viewWithTag:2];
    [labelAreaAtuacaoInst setText:[_listaInstituicoesReceiv[indexPath.row]areaAtuacao]];
    
    UILabel *labelEnderecoInst = (UILabel *)[cell viewWithTag:3];
    [labelEnderecoInst setText:[_listaInstituicoesReceiv[indexPath.row]endereco]];

    UIButton *botaoTelefone = (UIButton *)[cell viewWithTag:4];
    [botaoTelefone setTitle:[_listaInstituicoesReceiv[indexPath.row]telefone] forState:UIControlStateNormal];
    cell.backgroundColor = [UIColor whiteColor];
        
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    instSelected = indexPath.row;
    return indexPath;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"gotoDetalheInstituicao"])
    {
        DetalheInstituicaoV3ViewController *detalheInst = (DetalheInstituicaoV3ViewController *)segue.destinationViewController;
        
        [detalheInst.navigationItem setTitle:[_listaInstituicoesReceiv[instSelected]nome]];
        detalheInst.instituicao = _listaInstituicoesReceiv[instSelected];
    }
}

@end
