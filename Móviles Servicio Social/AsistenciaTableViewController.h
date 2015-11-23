//
//  AsistenciaTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProtocoloAsistenciaBeneficiario <NSObject>
- (void)quitaVista2;
@end

@interface AsistenciaTableViewController : UITableViewController
@property (strong, nonatomic) id detailItem;
- (IBAction)guardarAsistencia:(UIBarButtonItem *)sender;

@property (nonatomic,strong)id <ProtocoloAsistenciaBeneficiario> delegado;

@end
