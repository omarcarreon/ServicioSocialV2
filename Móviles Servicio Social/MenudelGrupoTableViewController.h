//
//  MenudelGrupoTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrearStaffTableViewController.h"
#import <Parse/Parse.h>


@interface MenudelGrupoTableViewController : UITableViewController <ProtocoloAgregarStaff>

@property (strong, nonatomic) id detailItem;

@end
