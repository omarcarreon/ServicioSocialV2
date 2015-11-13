//
//  ViewControllerAdminPrincipal.m
//  Móviles Servicio Social
//
//  Created by Angel González on 10/21/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "ViewControllerAdminPrincipal.h"
#import "CrearStaffTableViewController.h"
#import <Parse/Parse.h>

@interface ViewControllerAdminPrincipal ()

@end

@implementation ViewControllerAdminPrincipal

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    
    //Formato de los botones.
    _bttnGroups.layer.cornerRadius = 10;
    _bttnStatistics.layer.cornerRadius = 10;
    _bttnCreateStaff.layer.cornerRadius = 10;
    _bttnLogOut.layer.cornerRadius = 10;
    //Cambia el color del back.
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

}


- (void) agregarStaff:(NSString *)email withName:(NSString *)name withID:(NSString *)mat withCareer:(NSString *)career withSemester:(NSString *)sem withTelefono:(NSString *)tel{
    
    PFUser *user = [PFUser user];
    user.username = email;
    user.password = @"user1";
    user[@"Nombre"] = name;
    user.email = email;
    user[@"Matricula"] = mat;
    user[@"Carrera"] = career;
    user[@"Semestre"] = sem;
    user[@"Telefono"] = tel;
    NSNumber *privilegios = [NSNumber numberWithBool:NO];
    [user setObject:privilegios forKey:@"Privilegios"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
           
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Listo" message:@"Staff creado exitosamente" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Ocurrió un error al intentar crear el staff" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }];
    
}

- (void)quitaVista{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"crearstaff"]){
        [[segue destinationViewController] setDelegado:self];
    }
}


- (IBAction)logout:(UIButton *)sender {
    
}
@end
