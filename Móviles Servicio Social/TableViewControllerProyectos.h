//
//  TableViewControllerProyectos.h
//  Móviles Servicio Social
//
//  Created by Omar Carreon on 04/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrearProyectoTableViewController.h"

@interface TableViewControllerProyectos : UITableViewController <ProtocoloCrearProyecto>

@property (strong, nonatomic) id detailItem;

@end
