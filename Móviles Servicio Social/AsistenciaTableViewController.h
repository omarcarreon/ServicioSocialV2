//
//  AsistenciaTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
// Protocolo de asistencia beneficiario
@protocol ProtocoloAsistenciaBeneficiario <NSObject>
- (void)quitaVista2;
@end

@interface AsistenciaTableViewController : UITableViewController
@property (strong, nonatomic) id detailItem; // id del grupo
// boton para guardar la asistencia
- (IBAction)guardarAsistencia:(UIBarButtonItem *)sender;

@property (nonatomic,strong)id <ProtocoloAsistenciaBeneficiario> delegado;

@end
