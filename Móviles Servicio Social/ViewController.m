//
//  ViewController.m
//  Móviles Servicio Social
//
//  Created by Angel González on 10/21/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapgestureTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voidQuitaTeclado)];
    [self.view addGestureRecognizer:tapgestureTap];
    
    _bttnLogin.layer.cornerRadius = 10;
    
    /*
     El siguiente código se obtuvo de:
     http://stackoverflow.com/questions/19029833/ios-7-navigation-bar-text-and-arrow-color
     */
    //Cambia el color de la barra.
    [self.navigationController.navigationBar setBarTintColor:[self colorWithHexString:@"00B28C"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) voidQuitaTeclado{
    [self.view endEditing:YES];
}

- (IBAction)unwindLogout:(UIStoryboardSegue *)segue{
    [PFUser logOut];
    self.tfEMail.text = @"";
    self.tfPassword.text = @"";

}
- (IBAction)login:(UIButton *)sender {
    
    [PFUser logInWithUsernameInBackground:self.tfEMail.text password:self.tfPassword.text block:^(PFUser *user, NSError *error)
     {
         if (!error) {
             [self performSegueWithIdentifier:@"loginSegue" sender:nil];
         } else {
             
             UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Correo y/o contraseña incorrectos." preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
         }
     }];
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
