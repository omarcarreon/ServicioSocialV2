//
//  ViewController.m
//  Móviles Servicio Social
//
//  Created by Angel González on 10/21/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "ViewController.h"
#import "TableViewControllerProyectos.h"
#import "TableViewControllerLugares.h"
#import <Parse/Parse.h>


@interface ViewController ()
@property NSInteger isAdmin; // variable para revisar si es admin
@property (strong, nonatomic) NSString* lugarID;  // guarda el ID del lugar en caso de no ser admin
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // quita el teclado
    UITapGestureRecognizer *tapgestureTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voidQuitaTeclado)];
    [self.view addGestureRecognizer:tapgestureTap];
    // estilo del boton de login
    _bttnLogin.layer.cornerRadius = 10;
    
    /*
     El siguiente código se obtuvo de:
     http://stackoverflow.com/questions/19029833/ios-7-navigation-bar-text-and-arrow-color
     */
    //Cambia el color de la barra.
    [self.navigationController.navigationBar setBarTintColor:[self colorWithHexString:@"00B28C"]];
    // se utilizan para navegar a traves de los textfields
    self.tfEMail.delegate = (id)self;
    self.tfPassword.delegate = (id)self;

}
// Función para navegar a traves de los textfields
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.tfEMail)
    {
        [self.tfPassword becomeFirstResponder];
    }
    else if (textField == self.tfPassword)
    {
        [self login:self.bttnLogin];
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Funcion para quitar el teclado
- (void) voidQuitaTeclado{
    [self.view endEditing:YES];
}
// Unwind para el logout
- (IBAction)unwindLogout:(UIStoryboardSegue *)segue{
    [PFUser logOut];
    self.tfEMail.text = @"";
    self.tfPassword.text = @"";

}
//  Función para el login, hace un query con PFUser con el mail y password del usuario
// Si es admin, te redirige al menu de admin, si no es admin te redirige al menu del grupo del staff
- (IBAction)login:(UIButton *)sender {
    
    [PFUser logInWithUsernameInBackground:self.tfEMail.text password:self.tfPassword.text block:^(PFUser *user, NSError *error)
     {
         if (!error) {
             PFQuery *query = [PFUser query];
             [query whereKey:@"email" equalTo:self.tfEMail.text];
             NSArray *checkuser = [query findObjects];
             self.isAdmin = [[[checkuser valueForKey:@"Privilegios"] objectAtIndex:0] integerValue];
             self.lugarID = [[checkuser valueForKey:@"IDLugar"] objectAtIndex:0];
             if (self.isAdmin == 1){
                 [self performSegueWithIdentifier:@"loginSegue" sender:nil];
             } else{
                 [self performSegueWithIdentifier:@"notadmin" sender:nil];
                 //[[segue destinationViewController] setDetailItem:self.objectId];

             }
             
         } else {
             
             UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Correo y/o contraseña incorrectos." preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
         }
     }];
}
// Funcion prepareforsegue si no es admin
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"notadmin"]){
        [[segue destinationViewController] setLugarDeUsuario:[self.lugarID valueForKey:@"objectId"]];

    } else {
    }
    
}

//Convierte un valor string hexadecimal(http://stackoverflow.com/questions/6207329/how-to-set-hex-color-code-for-background)
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



@end
