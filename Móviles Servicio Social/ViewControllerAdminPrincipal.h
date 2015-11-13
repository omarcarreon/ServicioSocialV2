//
//  ViewControllerAdminPrincipal.h
//  Móviles Servicio Social
//
//  Created by Angel González on 10/21/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrearStaffTableViewController.h"
#import "CrearLugarTableViewController.h"
#import "CrearProyectoTableViewController.h"
@interface ViewControllerAdminPrincipal : UIViewController <ProtocoloAgregarStaff>

@property (weak, nonatomic) IBOutlet UIButton *bttnGroups;

@property (weak, nonatomic) IBOutlet UIButton *bttnStatistics;

@property (weak, nonatomic) IBOutlet UIButton *bttnCreateStaff;

@property (weak, nonatomic) IBOutlet UIButton *bttnLogOut;

- (IBAction)logout:(UIButton *)sender;

@end
