//
//  ViewController.m
//  TuAjuda
//
//  Created by Guilherme Moresco Bisotto on 2/7/14.
//  Copyright (c) 2014 BEPiD.TuAjuda. All rights reserved.
//

#import "ViewController.h"
#import "Instituicao.h"
#import "ListaInstTableViewController.h"
#import "TiposInstituicoesViewController.h"
#import "LocalizacaoTableViewController.h"
#define Rgb2UIColor(r, g, b)[UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface ViewController ()
@property int quantInst;
@property NSMutableArray *listaTipos;
@property NSMutableArray *listaLocalizacao;
@property NSMutableArray *listaTelaTipos;
@property NSMutableArray *listaTelaLocalizacao;
@property (nonatomic)  NSMutableArray *listaFinal;

@end

@implementation ViewController

-(NSMutableArray *)listaFinal
{
    if (!_listaFinal) {
        _listaFinal = [[NSMutableArray alloc] init];
    }
    return _listaFinal;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIColor *navColor = [UIColor colorWithRed:((14) / 255.0) green:((170) / 255.0) blue:((237) / 255.0) alpha:1.0];
    self.navigationController.navigationBar.barTintColor = navColor;
    _listaInstituicao = [[NSMutableArray alloc]init];
    [self CriaInstituicoes];
    
    [_campoBusca setDelegate:self];
    
    NSMutableDictionary *navBarTextAttributes = [NSMutableDictionary dictionaryWithCapacity:1];
    
    [navBarTextAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName ];
    
    self.navigationController.navigationBar.titleTextAttributes = navBarTextAttributes;
    
    _listaTipos = [[NSMutableArray alloc]init];
    _listaLocalizacao = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.barTintColor = navColor;
    _listaInstituicao = [[NSMutableArray alloc]init];
    [self CriaInstituicoes];
    
    [_campoBusca setDelegate:self];
    [self setNeedsStatusBarAppearanceUpdate];
    [self getTiposDeInstituicao:_listaInstituicao];
    [self getLocalizacao:_listaInstituicao];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"gotoListagemInstituicoes"])
    {
        ListaInstTableViewController *tableViewInst = (ListaInstTableViewController *)segue.destinationViewController;

        if (self.listaFinal.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"alert" message:@"Ops! Infelizmente sua busca não retornou nenhum resultado, por favor redefina sua busca." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
            tableViewInst.listaInstituicoesReceiv = self.listaFinal;
        
        
    }
    else if ([[segue identifier] isEqualToString:@"gotoTypes"])
    {
        TiposInstituicoesViewController *tiVC = (TiposInstituicoesViewController *)segue.destinationViewController;
        
        tiVC.arrayTipos = self.listaTipos;
        tiVC.listaTipos = self.listaTelaTipos;
    }
    else if([[segue identifier] isEqualToString:@"gotoLocalizations"])
    {
        LocalizacaoTableViewController *ltVC = (LocalizacaoTableViewController *)segue.destinationViewController;
        ltVC.arrayLocalizacao = self.listaLocalizacao;
        ltVC.listaLocalizacao = self.listaTelaLocalizacao;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"gotoListagemInstituicoes"]) {
        
        UITextField *campoBusca = (UITextField*)[self.view viewWithTag:9000];
        NSString *textoBusca = [campoBusca text];
        
        UILabel *lblTipos = (UILabel*)[self.view viewWithTag:1200];
        NSString *textoTipos = [lblTipos text];
        NSArray *arrayTipo = [textoTipos componentsSeparatedByString:@", "];
        
        UILabel *lblLocalizacao = (UILabel*)[self.view viewWithTag:1300];
        NSString *textoLocalizacao = [lblLocalizacao text];
        NSArray *arrayLoc = [textoLocalizacao componentsSeparatedByString:@", "];
        
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"nome CONTAINS[cd] %@ OR nome LIKE[cd] %@ OR cidade CONTAINS[cd] %@ OR cidade LIKE[cd] %@", textoBusca, textoBusca, textoBusca, textoBusca];
        
        NSArray* listinha = [_listaInstituicao filteredArrayUsingPredicate:predicate];

        
        if (listinha.count == 0 && [[campoBusca text] isEqualToString:@""]) {
            self.listaFinal = [self filtra:_listaInstituicao withTipos:arrayTipo withLoca:arrayLoc];
        }
        
        else if([arrayLoc[0] isEqualToString:@""] && [arrayTipo[0] isEqualToString:@""])
        {
            self.listaFinal = (NSMutableArray*)listinha;
        }
        else
            self.listaFinal = [self filtra:(NSMutableArray*)listinha withTipos:arrayTipo withLoca:arrayLoc];
        
        bool valida = listinha.count == 0 && [arrayLoc[0] isEqualToString:@""] && [arrayTipo[0] isEqualToString:@""] && ![[campoBusca text] isEqualToString:@""];
        if (self.listaFinal.count == 0 || valida) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"alert" message:@"Ops! Infelizmente sua busca não retornou nenhum resultado, por favor redefina sua busca." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            
            return NO;
        }
    }
    return YES;
}

-(NSMutableArray*)filtra: (NSMutableArray*)listCompleta withTipos:(NSArray*)tipos withLoca:(NSArray*)loc
{
    NSMutableArray *arrayAux = [[NSMutableArray alloc]init];
    
    if([loc[0] isEqualToString:@""] && [tipos[0] isEqualToString:@""]){
        return listCompleta;
    }
    else if ([tipos[0] isEqualToString:@""]) {
        for (int i = 0; i < listCompleta.count; i++) {
            NSString *locIntC = [listCompleta[i]cidade];
            for (int j= 0; j < loc.count; j++) {
                NSString *locInt = loc[j];
                if ([locIntC isEqualToString:locInt]) {
                    [arrayAux addObject:listCompleta[i]];
                }
            }
        }
    }
    else if ([loc[0] isEqualToString:@""]){
        for (int i = 0; i < listCompleta.count; i++) {
            NSString *tipoIntC = [listCompleta[i]areaAtuacao];
            for (int j= 0; j < tipos.count; j++) {
                NSString *tipoInt = tipos[j];
                if ([tipoIntC isEqualToString:tipoInt]) {
                    [arrayAux addObject:listCompleta[i]];
                }
            }
        }
    }
    else {
        for (int i = 0; i < listCompleta.count; i++) {
            NSString *tipoIntC = [listCompleta[i]areaAtuacao];
            NSString *locIntC = [listCompleta[i]cidade];
            for (int j= 0; j < tipos.count; j++) {
                NSString *tipoInt = tipos[j];
                for (int g = 0; g < loc.count; g++) {
                    NSString *locInt = loc[g];
                    if ([tipoIntC isEqualToString:tipoInt] && [locIntC isEqualToString:locInt]) {
                        [arrayAux addObject:listCompleta[i]];
                    }
                }
            }
        }
    }
    
    return arrayAux;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.campoBusca resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backFromType:(UIStoryboardSegue*)segue
{
    TiposInstituicoesViewController *tiVC = (TiposInstituicoesViewController*)segue.sourceViewController;
    self.listaTipos = tiVC.arrayTipos;
    
    UILabel *lblTipos = (UILabel*)[self.view viewWithTag:1200];
    
    NSString *str = [[NSString alloc]init];
    for (int i = 0; i < tiVC.arrayTipos.count; i++) {
        str = [str stringByAppendingString:[tiVC.arrayTipos objectAtIndex:i]];
        if (i != tiVC.arrayTipos.count-1) {
            str = [str stringByAppendingString:@", "];
        }
    }
    
    [lblTipos setText:str];
    
}

-(IBAction)backFromLocalization:(UIStoryboardSegue*)segue
{
    LocalizacaoTableViewController *ltVC = (LocalizacaoTableViewController*)segue.sourceViewController;
    self.listaLocalizacao = ltVC.arrayLocalizacao;
    
    UILabel *lbllocalizatio = (UILabel*)[self.view viewWithTag:1300];
    
    NSString *str = [[NSString alloc]init];
    for (int i = 0; i < ltVC.arrayLocalizacao.count; i++) {
        str = [str stringByAppendingString:[ltVC.arrayLocalizacao objectAtIndex:i]];
        if (i != ltVC.arrayLocalizacao.count-1) {
            str = [str stringByAppendingString:@", "];
        }
    }
    
    [lbllocalizatio setText:str];
    
}

-(void)CriaInstituicoes
{
    
    Instituicao *inst1 = [[Instituicao alloc]init];
    
    Instituicao *inst2 = [[Instituicao alloc]init];
    
    Instituicao *inst3 = [[Instituicao alloc]init];
    
    Instituicao *inst4 = [[Instituicao alloc]init];
    
    Instituicao *inst5 = [[Instituicao alloc]init];
    
    Instituicao *inst6 = [[Instituicao alloc]init];
    
    Instituicao *inst7 = [[Instituicao alloc]init];
    
    Instituicao *inst8 = [[Instituicao alloc]init];
    
    
    
    inst1.nome = @"AELCA";
    
    NSString *nomeImagemCapa1 = @"AELCA_capa.jpeg";
    
    UIImage *imagemCapa1 = [UIImage imageNamed:nomeImagemCapa1];
    
    inst1.imagem = imagemCapa1;
    
    inst1.areaAtuacao = @"Assistência Social";
    
    inst1.endereco = @"R. General Salvador Pinheiro, 799";
    
    inst1.telefone = @"(51)3334-6222";
    
    inst1.email = @"aelca@uol.com.br";
    
    inst1.site = @"http://aelca.blogspot.com";
    
    inst1.bairro = @"Vila Jardim";
    
    inst1.cidade = @"Porto Alegre";
    
    inst1.uf = @"RS";
    
    inst1.brevePerfil = @"A AELCA é uma organização atuante no bairro Vila Jardim, em Porto Alegre/RS. Foi fundada em 1968 a partir da iniciativa de um grupo de luteranos. Em 1982, recebeu uma doação anônima com a qual construiu um prédio e passou a funcionar exclusivamente como creche. Atualmente, tem capacidade para dar assistência a 250 crianças, adolescentes e suas famílias através dos programas de Educação Infantil e Serviço de Apoio Socio Educativo. Mantém ainda um ponto de cultura, Vila na Trilha, com diversas oficinas.";
    
    inst1.missao = @"Ensina à criança o caminho em que deve andar, e, ainda quando for velha, não se desviará dele.";
    
    inst1.principaisParceiros = @"Secretaria Municipal de Educação, Fundação de Assistencia Social e Comunitária, SESC Mesa Brasil, CEASA, Supermercado Nacional.";
    
    inst1.projeto = @"Reforma do telhado";
    
    inst1.comoAjudar = @"";
    
    
    inst2.nome = @"AEVAS";
    
    NSString *nomeImagemCapa2 = @"AEVAS_capa.jpeg";
    
    UIImage *imagemCapa2 = [UIImage imageNamed:nomeImagemCapa2];
    
    inst2.imagem = imagemCapa2;
    
    inst2.areaAtuacao = @"Assistência Social";
    
    inst2.endereco = @"Rua Bento Gonçalves, 2394";
    
    inst2.telefone = @"(51)3527-6645";
    
    inst2.email = @"raiodesol@aevas.org.br";
    
    inst2.site = @"www.redecrianca.org.br";
    
    inst2.bairro = @"Centro";
    
    inst2.cidade = @"NOVO HAMBURGO";
    
    inst2.uf = @"RS";
    
    inst2.brevePerfil = @"A AEVAS (Associação Evangélica de Ação Social em Novo Hamburgo) é uma ONG que foi criada em meio às tentativas civis de interferir positivamente no meio de grupos sociais que não conseguem inserir-se de forma justa nas políticas publicas adotada pelo estado. A Associação não possui fins lucrativos e vem tentando, através das diversas parcerias firmadas e através do serviço de voluntariado, realizar um trabalho que venha cada vez mais ao encontro das necessidades reais do público atendido por esta";
    
    inst2.missao = @"Promover ações embasadas em valores culturais, sociais, afetivos e educacionais, colaborando para o desenvolvimento integral da identidade de crianças, adolescentes e famílias inserindo-as na sociedade.";
    
    inst2.principaisParceiros = @"Prefeitura Municipal de Novo Hamburgo, IECLB – Igreja Evangélica de Confissão Luterana no Brasil e Fundação Rosina Heinrich – Alemanha.";
    
    inst2.projeto = @"Protegendo Nosso Espaço";
    
    inst2.comoAjudar = @"";
    
    
    
    inst3.nome = @"ISCERGS";
    
    NSString *nomeImagemCapa3 = @"ISCERGS_capa.jpeg";
    
    UIImage *imagemCapa3 = [UIImage imageNamed:nomeImagemCapa3];
    
    inst3.imagem = imagemCapa3;
    
    inst3.areaAtuacao = @"Vulnerabilidade Social";
    
    inst3.endereco = @"Rua Dois Amigos, 176";
    
    inst3.telefone = @"(51)3453-2002";
    
    inst3.email = @"iscergs@gmail.com";
    
    inst3.site = @"";
    
    inst3.bairro = @"";
    
    inst3.cidade = @"Sapucaia do Sul";
    
    inst3.uf = @"RS";
    
    inst3.brevePerfil = @"O ISCERGS – Instituto Educacional, Social e Cultural do Estado do Rio Grande do Sul é uma organização da sociedade civil, fundada em 2006 e desde então labora para a elevação da qualidade de vida da comunidade sapucaiense e gaúcha. Fixada em Sapucaia do Sul, a organização sem finalidade lucrativa atua nas áreas da Educação, Ação Social e Cultura desenvolvendo projetos, programas e ações em parceria com as entidades da cidade e junto a governos (municipal, estadual e federal).";
    
    inst3.missao = @"Promover a melhoria da qualidade de vida da comunidade gaúcha por meio de programas e ações alicerçadas na Educação, na Ação Social e na Cultura. Visão: Desenvolver a Educação em seus diferentes níveis e modalidades como ferramenta de transformação social.";
    
    inst3.principaisParceiros = @"Parceiros Voluntários, Comitê da Cidadania Comb. Fome e Miséria, Pastoral da Criança, ACAPASS – Associação Casa de Passagem, Casa Lar Meu Refúgio, Associação de Moradores Bela Vista, Associação de Moradores Fortuna, Associação de Moradores Santa Luzia, COMDICA – Conselho Municipal dos Direitos da Criança e do Adolescente de Sapucaia do Sul, CUFA-RS, Conselho Tutelar, Secretaria Municipal de Saúde, Secretaria Municipal de Desenvolvimento Social, Secretaria Municipal de Educação.";
    
    inst3.projeto = @"Rede de Atenção à Criança e ao Adolescente";
    
    inst3.comoAjudar = @"";
    
    
    
    inst4.nome = @"Royale";
    
    NSString *nomeImagemCapa4 = @"Royale_capa.jpeg";
    
    UIImage *imagemCapa4 = [UIImage imageNamed:nomeImagemCapa4];
    
    inst4.imagem = imagemCapa4;
    
    inst4.areaAtuacao = @"Cultura, Arte, Educação e Direitos Humanos.";
    
    inst4.endereco = @"Rua Professor Braga, 247";
    
    inst4.telefone = @"(55)3223-5533";
    
    inst4.email = @"royale_escola@yahoo.com.br";
    
    inst4.site = @"www.royalesocial.org";
    
    inst4.bairro = @"Centro";
    
    inst4.cidade = @"SANTA MARIA";
    
    inst4.uf = @"RS";
    
    inst4.brevePerfil = @"Em 1996, a Royale, ainda como instituição privada, iniciou uma oficina gratuita de Ballet Clássico para crianças pobres de uma escola da rede municipal de ensino da cidade de Santa Maria. Este trabalho teve grande receptividade na comunidade e levou a Royale a ampliá-lo. Em 1997, apresentou para a Prefeitura Municipal de Santa Maria um projeto no qual abria 40 vagas para as crianças das rede municipal de ensino. Esta experiência mudou totalmente o curso da Royale Academia de Ballet. Auxiliada por um grupo de professores universitários e com o apoio de alguns cidadãos, que compreenderam e acreditaram na sua nova proposta, a Royale Academia de Ballet transformou-se, em 1998, na Royale Escola de Dança e Integração.";
    
    inst4.missao = @"Integrar socialmente, por meio da arte e da educação, crianças, adolescentes, portadores de necessidades educativas especiais e suas famílias, expostas a situações de grave risco social na cidade de Santa Maria. Fazer da dança o agente motivador para ampliar os conhecimentos dos demais segmentos da arte, da luta pela valorização do ser humano e do domínio dos códigos da modernidade.";
    
    inst4.principaisParceiros = @"Petrobrás, Programa Bovespa Social, Embaixada da França no Brasil, Centro Universitário Franciscano, Conselhos Tutelares da cidade de Santa Maria, Secretaria de Município da Cultura, Monet Plaza Shopping, Art/Meio Propaganda, Gráfica e Editora Pallotti e UFSM.";
    
    inst4.projeto = @"Custeio de Oficinas de Arte e Educação";
    
    inst4.comoAjudar = @"";
    
    
    
    inst5.nome = @"IEIMAN";
    
    NSString *nomeImagemCapa5 = @"IEIMAN_capa.jpeg";
    
    UIImage *imagemCapa5 = [UIImage imageNamed:nomeImagemCapa5];
    
    inst5.imagem = imagemCapa5;
    
    inst5.areaAtuacao = @"Crianças";
    
    inst5.endereco = @"rua C, acesso 2 - Vila nazaré, 16";
    
    inst5.telefone = @"(51)33440201";
    
    inst5.email = @"ieimanpf@terra.com.br";
    
    inst5.site = @"NP";
    
    inst5.bairro = @"São Sebastião";
    
    inst5.cidade = @"Porto Alegre";
    
    inst5.uf = @"RS";
    
    inst5.brevePerfil = @"A Creche Maria de Nazaré surgiu a partir da necessidade das famílias da comunidade em ter um espaço físico adequado e seguro para deixar seus filhos enquanto estivessem no trabalho. Foi então que, em 1987, através da Associação de Moradores da Vila Nazaré e em convênio com a extinta Legião Brasileira de Assistência – LBA, foi erguida a Creche. Em 2001, foi iniciado um novo trabalho, com a eleição de Diretoria, novo Estatuto Social e CNPJ. Assim, o atendimento foi se desenvolvendo proporcionalmente ao trabalho executado, dando credibilidade às pessoas responsáveis pela Creche.";
    
    inst5.missao = @"Missão: Promover a formação integral das crianças, adolescentes, jovens e de suas famílias oportunizando-lhes condições para que se tornem protagonistas de sua própria transformação social";
    
    inst5.principaisParceiros = @"Instituto HSBC, Ministério da Cultura, Grupo Hospitalar Conceição, Academia Scorpions";
    
    inst5.projeto = @"Metamorfose da Cidadania";
    
    inst5.comoAjudar = @"";
    
    
    
    inst6.nome = @"SOS Vida";
    
    NSString *nomeImagemCapa6 = @"SOS Vida_capa.jpeg";
    
    UIImage *imagemCapa6 = [UIImage imageNamed:nomeImagemCapa6];
    
    inst6.imagem = imagemCapa6;
    
    inst6.areaAtuacao = @"Dependência química nas áreas educacional, emocional, física e espiritual, contemplando o sujeito integral, com projetos interdisciplinares.";
    
    inst6.endereco = @"R. Dr. Mauri Gomes, 405";
    
    inst6.telefone = @"(55)3313-1974";
    
    inst6.email = @"sos.vida@yahoo.com.br";
    
    inst6.site = @"www.sosvidact.org.br";
    
    inst6.bairro = @"Haller";
    
    inst6.cidade = @"SANTO ANGELO";
    
    inst6.uf = @"RS";
    
    inst6.brevePerfil = @"O SOS VIDA surgiu da necessidade de ter no município de Santo Ângelo uma instituição voltada para a recuperação de usuários de substâncias psicoativas. Iniciou em fevereiro de 1997, com Alivindo Faganello, ex-dependente e atual diretor, que formou o primeiro grupo de mútua-ajuda entre pessoas decididas a fazer de suas vidas um exemplo para aqueles que estivessem atravessando o caminho das drogas. Com a doação de uma área foram realizadas as primeiras internações. Em 1999, iniciou-se a construção de um prédio para abrigar a administração, refeitório e alojamento. Surgia aí o Centro de Reabilitação Social e Beneficente Evangélico SOS – VIDA.";
    
    inst6.missao = @"Resgatar vidas do álcool e das drogas. Visão: Ser uma instituição onde o paciente encontre condições e suporte para sua reestruturação e reinserção social.";
    
    inst6.principaisParceiros = @"Fundação Mauricio Sirotsky Sobrinho, Prefeitura Municipal de Santo Ângelo, Secretaria Municipal de Educação, Departamento Municipal do Meio Ambiente, Secretaria Municipal de Assistência Social, Secretaria Municipal de Saúde, Universidade Regional Integrada do Alto Uruguai e das Missões, Ministério da Saúde, Junta Evangelística Missioneira, Faculdade Batista Pioneira, Parceiros Voluntários e Fundação Luterana de Diaconia.";
    
    inst6.projeto = @"rte e Educação no Tratamento de Dependência Química para Adolescentes";
    
    inst6.comoAjudar = @"";
    
    
    
    
    
    inst7.nome = @"Fadem";
    
    NSString *nomeImagemCapa7 = @"Fadem_capa.jpeg";
    
    UIImage *imagemCapa7 = [UIImage imageNamed:nomeImagemCapa7];
    
    inst7.imagem = imagemCapa7;
    
    inst7.areaAtuacao = @"Educação, Saúde, Assistência Social";
    
    inst7.endereco = @"Rua Frei Henrique Golland Trindade, 445";
    
    inst7.telefone = @"(51)332-86780";
    
    inst7.email = @"fadem@fadem.com.br";
    
    inst7.site = @"www.fadem.com.br";
    
    inst7.bairro = @"Boa Vista";
    
    inst7.cidade = @"Porto Alegre";
    
    inst7.uf = @"RS";
    
    inst7.brevePerfil = @"A FADEM - Fundação de Atendimento de Deficiência Múltipla foi fundada em 1983 por iniciativa de familiares de pessoas com deficiências múltiplas e profissionais da área técnica, pois nesta época não havia em Porto Alegre uma instituição que oferecesse os atendimentos necessários a estas crianças. A Fundação funciona em sede própria, desde janeiro de 1998, em terreno cedido pela Prefeitura Municipal de Porto Alegre. Em 2009, inaugurou um novo anexo, um prédio construído pelo Consulado do Japão durante o ano de 2008.";
    
    inst7.missao = @"Missão: Prestar atendimento a crianças e adolescentes de baixa renda PCDs (pessoas com deficiência) e suas famílias. Visão: Ser referência no atendimento a PCDs.";
    
    inst7.principaisParceiros = @"FASC, CMDCA, Funcriança, CMAS, Fórum de Entidades, COMDEPA, Parceiros Voluntários, Gerdau, Baldo, Vonpar, Banrisul, Nacional e a comunidade.";
    
    inst7.projeto = @"Sustentação 2013, Aquisição de Quadra Poliesportiva Adaptada para PCDs";
    
    inst7.comoAjudar = @"";
    
    
    
    inst8.nome = @"CEREPAL";
    
    NSString *nomeImagemCapa8 = @"CEREPAL_capa.jpeg";
    
    UIImage *imagemCapa8 = [UIImage imageNamed:nomeImagemCapa8];
    
    inst8.imagem = imagemCapa8;
    
    inst8.areaAtuacao = @"Assistência Social";
    
    inst8.endereco = @"Rua Brigadeiro Oliveira Nery, 100";
    
    inst8.telefone = @"(51)3342-9753";
    
    inst8.email = @"deise_fre@hotmail.com";
    
    inst8.site = @"www.cerepal.org.br";
    
    inst8.bairro = @"Passo D`areia";
    
    inst8.cidade = @"Porto Alegre";
    
    inst8.uf = @"RS";
    
    inst8.brevePerfil = @"O CEREPAL é um espaço para reabilitação de crianças com paralisia cerebral. Em 1974, foi regulamentada a Escola de Educação Especial e em 1978 o Serviço de Medicina Física aos adultos e jovens. Com o tempo, houve a necessidade de organização dos serviços e definição da clientela. A área técnica avançou com objetividade reorganizando o perfil, partindo dos objetivos estatutários da Entidade que é prestar o atendimento ao lesionado cerebral. Além dos programas que promovem a reabilitação, educação e saúde aos pacientes neurolesionados que frequentam nossa instituição, as famílias e/ou cuidadores também são assistidos em suas necessidades, uma vez que consideramos o apoio familiar parte do tratamento dos pacientes.";
    
    inst8.missao = @"Promover a qualidade de vida, reabilitação, educação, valorização e assistência ao paciente com lesão cerebral e sua integração com a sociedade.";
    
    inst8.principaisParceiros = @"FASC, Secretaria do Estado da Educação, Secretaria Municipal da Educação, SUS, CMDCA/FUNCRIANÇA, Casa do Pequeno Operário, Sociedade Porvir Científico, Fundo Pró-Infância dos Profissionais Gerdau.";
    
    inst8.projeto = @"Pintando o CEREPAL, Qualificação de serviços e infra-estrutura";
    
    inst8.comoAjudar = @"";
    
    
    
    
    
    
    [_listaInstituicao addObject:inst1];
    
    [_listaInstituicao addObject:inst2];
    
    [_listaInstituicao addObject:inst3];
    
    [_listaInstituicao addObject:inst4];
    
    [_listaInstituicao addObject:inst5];
    
    [_listaInstituicao addObject:inst6];
    
    [_listaInstituicao addObject:inst7];
    
    [_listaInstituicao addObject:inst8];
    
    _quantInst = _listaInstituicao.count;
    
    //Salva os dados
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    for(int i = 0; i < _listaInstituicao.count;i++)
    {
        Instituicao *aux = [_listaInstituicao objectAtIndex:i];
        NSString *keyNome = [NSString stringWithFormat:@"nome%d",i];
        NSString *keyImagem = [NSString stringWithFormat:@"imagem%d",i];
        NSString *keyAreaAtuacao = [NSString stringWithFormat:@"areaAtuacao%d",i];
        NSString *keyEndereco = [NSString stringWithFormat:@"endereco%d",i];
        NSString *keyTelefone = [NSString stringWithFormat:@"telefone%d",i];
        
        NSString *keyEmail = [NSString stringWithFormat:@"email%d",i];
        NSString *keySite = [NSString stringWithFormat:@"site%d",i];
        NSString *keyBairro = [NSString stringWithFormat:@"bairro%d",i];
        NSString *keyCidade = [NSString stringWithFormat:@"cidade%d",i];
        NSString *keyUf = [NSString stringWithFormat:@"uf%d",i];
        NSString *keyBrevePerfil = [NSString stringWithFormat:@"brevePerfil%d",i];
        NSString *keyMissao = [NSString stringWithFormat:@"missao%d",i];
        NSString *keyPrincipaisParceiros = [NSString stringWithFormat:@"principaisParceiros%d",i];
        NSString *keyProjeto = [NSString stringWithFormat:@"projeto%d",i];
        NSString *keyComoAjudar = [NSString stringWithFormat:@"comoAjdar%d",i];
        //        NSString *keyTelefone = [NSString stringWithFormat:@"telefone%d",i];
        
        
        NSString *imagemName = [[NSString alloc]init];
        imagemName = aux.imagem.description;
        
        [defaults setObject:aux.nome forKey:keyNome];
        [defaults setObject:imagemName forKey:keyImagem];
        [defaults setObject:aux.areaAtuacao forKey:keyAreaAtuacao];
        [defaults setObject:aux.endereco forKey:keyEndereco];
        [defaults setObject:aux.telefone forKey:keyTelefone];
        
        [defaults setObject:aux.email forKey:keyEmail];
        [defaults setObject:aux.site forKey:keySite];
        [defaults setObject:aux.bairro forKey:keyBairro];
        [defaults setObject:aux.cidade forKey:keyCidade];
        [defaults setObject:aux.uf forKey:keyUf];
        [defaults setObject:aux.brevePerfil forKey:keyBrevePerfil];
        [defaults setObject:aux.missao forKey:keyMissao];
        [defaults setObject:aux.principaisParceiros forKey:keyPrincipaisParceiros];
        [defaults setObject:aux.projeto forKey:keyProjeto];
        [defaults setObject:aux.comoAjudar forKey:keyComoAjudar];
        //        [defaults setObject:aux.telefone forKey:keyTelefone];
    }
    
    //    [defaults synchronize];
    
}

-(void)getTiposDeInstituicao:(NSMutableArray*)listaInst
{
    NSMutableArray *aux = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < listaInst.count; i++) {
        NSString *area = [listaInst[i]areaAtuacao];
        if ([aux indexOfObject:area] == NSNotFound) {
            [aux addObject:area];
        }
    }
    

    self.listaTelaTipos = aux;
}

-(void)getLocalizacao:(NSMutableArray*)listaLocalizacao
{
    NSMutableArray *aux = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < listaLocalizacao.count; i++) {
        NSString *cidade = [listaLocalizacao[i]cidade];
        if ([aux indexOfObject:cidade] == NSNotFound) {
            [aux addObject:cidade];
        }
    }
    
    
    self.listaTelaLocalizacao = aux;
}


@end
