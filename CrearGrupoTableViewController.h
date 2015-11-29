//
//  CrearGrupoTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
// Protocolo para crear un grupo
@protocol ProtocoloCrearGrupo <NSObject>

- (void) crearGrupo:(NSString *)numero;
- (void)quitaVista;
@end

@interface CrearGrupoTableViewController : UITableViewController
// outlet para numero/nombre del grupo
@property (weak, nonatomic) IBOutlet UITextField *tfNumero;
// boton de crear grupo
- (IBAction)crearGrupo:(UIBarButtonItem *)sender;

@property (nonatomic,strong)id <ProtocoloCrearGrupo> delegado;

@end
