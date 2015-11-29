//
//  DetailAlumnosTableViewController.h
//  Móviles Servicio Social
//
//  Created by Omar Carreon on 22/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailAlumnosTableViewController : UITableViewController
// outlets para desplegar info del alumno
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITextField *tfNombre;
@property (strong, nonatomic) IBOutlet UITextField *tfMatricula;
@property (strong, nonatomic) IBOutlet UITextField *tfCorreo;
@property (strong, nonatomic) IBOutlet UITextField *tfCarrera;
@property (strong, nonatomic) IBOutlet UITextField *tfSemestre;
@property (strong, nonatomic) IBOutlet UITextField *tfTelefono;

@end
