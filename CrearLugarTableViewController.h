//
//  CrearLugarTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/8/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
// Protocolo para crear un lugar
@protocol ProtocoloCrearLugar <NSObject>

- (void) crearLugar:(NSString *)nombre withDir:(NSString *)dir;

- (void)quitaVista;
@end

@interface CrearLugarTableViewController : UITableViewController
// outlets para crear un lugar
@property (weak, nonatomic) IBOutlet UITextField *tfNombre;

@property (weak, nonatomic) IBOutlet UITextField *tfDireccion;

@property (nonatomic,strong)id <ProtocoloCrearLugar> delegado;
// boton crear lugar
- (IBAction)crearLugar:(UIBarButtonItem *)sender;


@end
