//
//  CrearGrupoTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProtocoloCrearGrupo <NSObject>

- (void) crearGrupo:(NSString *)numero;
- (void)quitaVista;
@end

@interface CrearGrupoTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *tfNumero;

- (IBAction)crearGrupo:(UIBarButtonItem *)sender;

@property (nonatomic,strong)id <ProtocoloCrearGrupo> delegado;

@end
