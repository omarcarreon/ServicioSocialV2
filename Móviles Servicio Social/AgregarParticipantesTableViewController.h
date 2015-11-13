//
//  AgregarParticipantesTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProtocoloCrearBeneficiario <NSObject>

- (void) crearBeneficiario:(NSString *)nombre withTel:(NSString *)telefono;

- (void)quitaVista;
@end
@interface AgregarParticipantesTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *tfNombre;
@property (weak, nonatomic) IBOutlet UITextField *tfTelefono;
- (IBAction)crearBeneficiario:(UIBarButtonItem *)sender;
@property (nonatomic,strong)id <ProtocoloCrearBeneficiario> delegado;

@end
