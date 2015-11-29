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

@property (strong, nonatomic) id detailItem; // id del proyecto proviniente

@end
