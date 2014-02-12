//
//  Instituicao.h
//  TuAjuda
//
//  Created by Guilherme Moresco Bisotto on 2/7/14.
//  Copyright (c) 2014 BEPiD.TuAjuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instituicao : NSObject

@property NSString *nome;
@property UIImage *imagem;
@property NSString *areaAtuacao;
@property NSString *endereco;
@property NSString *telefone;
@property NSString *email;
@property NSString *site;
@property NSString *bairro;
@property NSString *cidade;
@property NSString *uf;
@property NSString *brevePerfil;
@property NSString *missao;
@property NSString *principaisParceiros;
@property NSString *projeto;
@property NSString *comoAjudar;
@property NSMutableArray *listaImagens;

@end
