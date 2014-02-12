//
//  DetalheInstituicaoV3ViewController.m
//  WeHelp
//
//  Created by Bruno Rovea Soares on 06/02/14.
//  Copyright (c) 2014 Bruno Rovea Soares. All rights reserved.
//

#import "DetalheInstituicaoV3ViewController.h"
#import "SaibaMaisViewController.h"

@interface DetalheInstituicaoV3ViewController ()
{
    int instSelected;
}

@end

@implementation DetalheInstituicaoV3ViewController

@synthesize scrollView;
@synthesize tableView;
@synthesize pageControl;

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

    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(320, 0, 320, 240)];
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(640, 0, 320, 240)];
    UIImageView *image4 = [[UIImageView alloc]initWithFrame:CGRectMake(960, 0, 320, 240)];
    UIImageView *image5 = [[UIImageView alloc]initWithFrame:CGRectMake(1280, 0, 320, 240)];
    
    image1.image = [UIImage imageNamed:@"image1inst1.jpeg"];
    image2.image = [UIImage imageNamed:@"image2inst1.jpeg"];
    image3.image = [UIImage imageNamed:@"image3inst1.jpeg"];
    image4.image = [UIImage imageNamed:@"image4inst1.jpeg"];
    image5.image = [UIImage imageNamed:@"image5inst1.jpeg"];
    
    
    [scrollView addSubview:image1];
    [scrollView addSubview:image2];
    [scrollView addSubview:image3];
    [scrollView addSubview:image4];
    [scrollView addSubview:image5];
   
    pageControl.currentPage = 0;
    pageControl.numberOfPages = 5;
    
    UIView *myFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIImageView *imageFooter = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    imageFooter.image = [UIImage imageNamed:@"rodape"];
    myFooterView.backgroundColor = [UIColor colorWithRed:((14) / 255.0) green:((170) / 255.0) blue:((237) / 255.0) alpha:1.0];
    [myFooterView addSubview:imageFooter];
    self.tableView.tableFooterView = myFooterView;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [scrollView setContentSize:CGSizeMake(1600, 240)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section){
        case 0:{
            return @"Informações Gerais";
            break;
        }
        case 1:{
            return @"Breve perfil e histórico";
            break;
        }
        case 2:{
            return @"Missão/Valores";
            break;
        }
        case 3:{
            return @"Área de atuação";
            break;
        }
        case 4:{
            return @"Principais parceiros";
            break;
        }
        case 5:{
            return @"Projetos";
            break;
        }
        case 6:{
            return @"Como ajudar";
            break;
        }
        case 7:{
            return @"Faça sua doação em dinheiro";
            break;
        }
    } return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section){
        case 0:{
            return 7;
            break;
        }
        case 1:{
            return 1;
            break;
        }
        case 2:{
            return 1;
            break;
        }
        case 3:{
            return 1;
            break;
        }
        case 4:{
            return 1;
            break;
        }
        case 5:{
            return 1;
            break;
        }
        case 6:{
            return 1;
            break;
        }
        case 7:{
            return 1;
            break;
        }
    } return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==7) {
        return 150;
    } else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section){
        case 0:{//Informações Gerais
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellSection0" forIndexPath:indexPath];
            UILabel *lblTitulo = (UILabel *)[cell viewWithTag:1];
            UILabel *lblDesc = (UILabel *)[cell viewWithTag:2];
            
            switch (indexPath.row){
                case 0:{
                    lblTitulo.text = @"Site: ";
                    [lblDesc setText:self.instituicao.site];
                    lblDesc.textColor = [UIColor blueColor];
                    break;
                }
                case 1:{
                    lblTitulo.text = @"E-mail: ";
                    [lblDesc setText:self.instituicao.email];
                    lblDesc.textColor = [UIColor blueColor];
                    break;
                }
                case 2:{
                    lblTitulo.text = @"Telefone: ";
                    [lblDesc setText:self.instituicao.telefone];
                    lblDesc.textColor = [UIColor blueColor];
                    break;
                }
                case 3:{
                    lblTitulo.text = @"Endereço: ";
                    [lblDesc setText:self.instituicao.endereco];
                    lblDesc.textColor = [UIColor blackColor];
                    break;
                }
                case 4:{
                    lblTitulo.text = @"Bairro: ";
                    [lblDesc setText:self.instituicao.bairro];
                    lblDesc.textColor = [UIColor blackColor];
                    break;
                }
                case 5:{
                    lblTitulo.text = @"Cidade: ";
                    [lblDesc setText:self.instituicao.cidade];
                    lblDesc.textColor = [UIColor blackColor];
                    break;
                }
                case 6:{
                    lblTitulo.text = @"UF: ";
                    [lblDesc setText:self.instituicao.uf];
                    lblDesc.textColor = [UIColor blackColor];
                    break;
                }
            }
            break;
        }
        case 1:{//Breve Perfil
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellSection1" forIndexPath:indexPath];
            UILabel *lblSaibaMais = (UILabel *)[cell viewWithTag:11];
            UILabel *lblTexto = (UILabel *)[cell viewWithTag:12];
            lblSaibaMais.text = @"Saiba mais";
            lblSaibaMais.adjustsFontSizeToFitWidth = YES;
            lblTexto.text = self.instituicao.brevePerfil;
            
            break;
            
        }
        case 2:{//Missao
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellSection2" forIndexPath:indexPath];
            UILabel *lblSaibaMais = (UILabel *)[cell viewWithTag:21];
            UILabel *lblTexto = (UILabel *)[cell viewWithTag:22];
            lblSaibaMais.text = @"Saiba mais";
            lblSaibaMais.adjustsFontSizeToFitWidth = YES;
            lblTexto.text = self.instituicao.missao;
            break;
        }
        case 3:{//Area Atuacao
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellSection3" forIndexPath:indexPath];
            UILabel *lblSaibaMais = (UILabel *)[cell viewWithTag:31];
            UILabel *lblTexto = (UILabel *)[cell viewWithTag:32];
            lblSaibaMais.text = @"Saiba mais";
            lblSaibaMais.adjustsFontSizeToFitWidth = YES;
            lblTexto.text = self.instituicao.areaAtuacao;
            break;
        }
        case 4:{//Principais Parceiros
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellSection4" forIndexPath:indexPath];
            UILabel *lblSaibaMais = (UILabel *)[cell viewWithTag:41];
            UILabel *lblTexto = (UILabel *)[cell viewWithTag:42];
            lblSaibaMais.text = @"Saiba mais";
            lblSaibaMais.adjustsFontSizeToFitWidth = YES;
            lblTexto.text = self.instituicao.principaisParceiros;
            break;
        }
        case 5:{//Projetos
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellSection5" forIndexPath:indexPath];
            UILabel *lblSaibaMais = (UILabel *)[cell viewWithTag:51];
            UILabel *lblTexto = (UILabel *)[cell viewWithTag:52];
            lblSaibaMais.text = @"Saiba mais";
            lblSaibaMais.adjustsFontSizeToFitWidth = YES;
            lblTexto.text = self.instituicao.projeto;
            break;
        }
        case 6:{//Como Ajudar
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellSection6" forIndexPath:indexPath];
            UILabel *lblSaibaMais = (UILabel *)[cell viewWithTag:61];
            UILabel *lblTexto = (UILabel *)[cell viewWithTag:62];
            lblSaibaMais.text = @"Saiba mais";
            lblSaibaMais.adjustsFontSizeToFitWidth = YES;
            lblTexto.text = self.instituicao.comoAjudar;
            break;
        }
        case 7:{//Faça sua doacao em dinheiro
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellSection7" forIndexPath:indexPath];
            break;
        }
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (IBAction)changePage:(id)sender {
    CGRect frame;
    frame.origin.x = scrollView.frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 1:{
            instSelected = 1;
            [self performSegueWithIdentifier:@"goToSaibaMaisDetalhes" sender:indexPath];
            
            break;
        }
        case 2:{
            instSelected = 2;
            [self performSegueWithIdentifier:@"goToSaibaMaisDetalhes" sender:indexPath];
            
            break;
        }
        case 3:{
            instSelected = 3;
            [self performSegueWithIdentifier:@"goToSaibaMaisDetalhes" sender:indexPath];
            
            break;
        }
        case 4:{
            instSelected = 4;
            [self performSegueWithIdentifier:@"goToSaibaMaisDetalhes" sender:indexPath];
            
            break;
        }
        case 5:{
            instSelected = 5;
            [self performSegueWithIdentifier:@"goToSaibaMaisDetalhes" sender:indexPath];
            
            break;
        }
        case 6:{
            instSelected = 6;
            [self performSegueWithIdentifier:@"goToSaibaMaisDetalhes" sender:indexPath];
            break;
        }
        case 7:{
            return;
            break;
        }
        default:
            break;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"goToSaibaMaisDetalhes"])
    {
        SaibaMaisViewController *saibaMaisDetalhes = (SaibaMaisViewController *)segue.destinationViewController;
        
        [saibaMaisDetalhes.navigationItem setTitle:self.instituicao.nome];
        switch (instSelected) {
            case 1:{
                saibaMaisDetalhes.strSaibaMais = self.instituicao.brevePerfil;
                break;
            }
            case 2:{
                saibaMaisDetalhes.strSaibaMais = self.instituicao.missao;
                break;
            }
            case 3:{
                saibaMaisDetalhes.strSaibaMais = self.instituicao.areaAtuacao;
                break;
            }
            case 4:{
                saibaMaisDetalhes.strSaibaMais = self.instituicao.principaisParceiros;
                break;
            }
            case 5:{
                saibaMaisDetalhes.strSaibaMais = self.instituicao.projeto;
                break;
            }
            case 6:{
                saibaMaisDetalhes.strSaibaMais = self.instituicao.comoAjudar;
                break;
            }
            default:
                break;
        }
    }
}

@end
