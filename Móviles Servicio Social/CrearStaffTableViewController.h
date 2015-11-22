//
//  CrearStaffTableViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 11/5/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProtocoloAgregarStaff <NSObject>

- (void) agregarStaff:(NSString *)email withName:(NSString *)name withID:(NSString *)mat withCareer:(NSString *)career withSemester:(NSString *)sem withTelefono:(NSString *)tel withPassword:(NSString *)pass;

- (void)quitaVista;
@end

@interface CrearStaffTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *tfEMail;

@property (strong, nonatomic) IBOutlet UITextField *tfPassword;

@property (weak, nonatomic) IBOutlet UITextField *tfName;

@property (weak, nonatomic) IBOutlet UITextField *tfID;

@property (weak, nonatomic) IBOutlet UITextField *tfCareer;

@property (weak, nonatomic) IBOutlet UITextField *tfSemester;

@property (weak, nonatomic) IBOutlet UITextField *tfTelefono;

@property (nonatomic,strong)id <ProtocoloAgregarStaff> delegado;

- (IBAction)guardarStaff:(UIBarButtonItem *)sender;

@end
