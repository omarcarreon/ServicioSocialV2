//
//  AgregarAlumnoTableViewController.h
//  Móviles Servicio Social
//
//  Created by alumno on 13/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgregarAlumnoTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *tfNombre;
@property (weak, nonatomic) IBOutlet UITextField *tfMatricula;
@property (weak, nonatomic) IBOutlet UITextField *tfCorreo;
@property (weak, nonatomic) IBOutlet UITextField *tfTelefono;
@property (weak, nonatomic) IBOutlet UITextField *tfCarrera;
@property (weak, nonatomic) IBOutlet UITextField *tfSemestre;


@end
