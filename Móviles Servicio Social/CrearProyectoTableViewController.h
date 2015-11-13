//
//  CrearProyectoTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/8/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProtocoloCrearProyecto <NSObject>

- (void) crearProyecto:(NSString *)nombre withDes:(NSString *)des;

- (void)quitaVista;
@end

@interface CrearProyectoTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *tfNombre;

@property (weak, nonatomic) IBOutlet UITextField *tfDescripcion;

@property (nonatomic,strong)id <ProtocoloCrearProyecto> delegado;

- (IBAction)crearProyecto:(UIBarButtonItem *)sender;

@end
