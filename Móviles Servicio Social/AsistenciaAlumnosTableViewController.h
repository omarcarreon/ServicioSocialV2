//
//  AsistenciaAlumnosTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/20/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProtocoloAsistenciaAlumno <NSObject>
- (void)quitaVista2;
@end

@interface AsistenciaAlumnosTableViewController : UITableViewController
@property (strong, nonatomic) id detailItem;

- (IBAction)guardarAsistenciaAlumno:(UIBarButtonItem *)sender;
@property (nonatomic,strong)id <ProtocoloAsistenciaAlumno> delegado;

@end
