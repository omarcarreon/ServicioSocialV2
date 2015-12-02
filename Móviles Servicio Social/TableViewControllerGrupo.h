//
//  TableViewControllerGrupo.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrearGrupoTableViewController.h"

@interface TableViewControllerGrupo : UITableViewController <ProtocoloCrearGrupo>

@property (strong, nonatomic) id proyectoSeleccionado; // id del proyecto proviniente
@property (strong, nonatomic) id detailItemLugar; // id del lugar proviniente
@property (strong, nonatomic) id lugarDeUsuario; // id del lugar del staff
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;

@end
