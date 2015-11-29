//
//  DetailBeneficiarioTableViewController.h
//  Móviles Servicio Social
//
//  Created by Omar Carreon on 22/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailBeneficiarioTableViewController : UITableViewController
// outlets para desplegar info del alumno
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITextField *tfNombre;
@property (strong, nonatomic) IBOutlet UITextField *tfEdad;
@property (strong, nonatomic) IBOutlet UITextField *tfDireccion;
@property (strong, nonatomic) IBOutlet UITextField *tfTelefono;
@property (strong, nonatomic) IBOutlet UITextField *Celular;
@property (strong, nonatomic) IBOutlet UITextField *tfTutor;

@end
