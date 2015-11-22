//
//  AgregarAlumnoTableViewController.h
//  Móviles Servicio Social
//
//  Created by alumno on 13/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProtocoloCrearAlumno <NSObject>

- (void) crearAlumno:(NSString *)email withName:(NSString *)name withID:(NSString *)mat withCareer:(NSString *)career withSemester:(NSString *)sem withTelefono:(NSString *)tel;

- (void)quitaVista;
@end

@interface AgregarAlumnoTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *tfNombre;
@property (weak, nonatomic) IBOutlet UITextField *tfMatricula;
@property (weak, nonatomic) IBOutlet UITextField *tfCorreo;
@property (weak, nonatomic) IBOutlet UITextField *tfTelefono;
@property (weak, nonatomic) IBOutlet UITextField *tfCarrera;

@property (weak, nonatomic) IBOutlet UITextField *tfSemestre;

- (IBAction)guardarAlumno:(UIBarButtonItem *)sender;

@property (nonatomic,strong)id <ProtocoloCrearAlumno> delegado;


@end
