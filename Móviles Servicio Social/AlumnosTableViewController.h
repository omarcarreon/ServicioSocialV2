//
//  AlumnosTableViewController.h
//  Móviles Servicio Social
//
//  Created by alumno on 13/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AgregarAlumnoTableViewController.h"

@interface AlumnosTableViewController : UITableViewController <ProtocoloCrearAlumno>
@property (strong, nonatomic) id detailItem;
@end
