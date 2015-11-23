//
//  AgregarParticipantesTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProtocoloCrearBeneficiario <NSObject>

- (void) crearBeneficiario:(NSString *)nombre withTel:(NSString *)telefono withEdad:(NSString  *)edad withDireccion:(NSString *)direccion withCelular:(NSString *)celular withTutor:(NSString *)tutor;

- (void)quitaVista;
@end
@interface AgregarParticipantesTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *tfNombre;
@property (weak, nonatomic) IBOutlet UITextField *tfTelefono;
@property (strong, nonatomic) IBOutlet UITextField *tfEdad;
@property (strong, nonatomic) IBOutlet UITextField *tfDireccion;
@property (strong, nonatomic) IBOutlet UITextField *tfCelular;
@property (strong, nonatomic) IBOutlet UITextField *tfTutor;

- (IBAction)crearBeneficiario:(UIBarButtonItem *)sender;
@property (nonatomic,strong)id <ProtocoloCrearBeneficiario> delegado;

@end
