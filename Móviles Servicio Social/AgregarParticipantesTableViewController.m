//
//  AgregarParticipantesTableViewController.m
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "AgregarParticipantesTableViewController.h"

@interface AgregarParticipantesTableViewController ()

@end

@implementation AgregarParticipantesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     /*
     El siguiente código se obtuvo de:
     http://stackoverflow.com/questions/19029833/ios-7-navigation-bar-text-and-arrow-color
     */
    //Cambia el color de la barra.
    [self.navigationController.navigationBar setBarTintColor:[self colorWithHexString:@"00B28C"]];
    //Cambia el color del titulo
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    //Cambia el color del back.
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    // se usan para navegar en los outlets

    self.tfNombre.delegate = (id)self;
    self.tfEdad.delegate = (id)self;
    self.tfDireccion.delegate = (id)self;
    self.tfCelular.delegate = (id)self;
    self.tfTutor.delegate = (id)self;
    self.tfTelefono.delegate = (id)self;
}
// Funcion para navegar en los outlets
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.tfNombre)
    {
        [self.tfEdad becomeFirstResponder];
    } else if (textField == self.tfEdad)
    {
        [self.tfDireccion becomeFirstResponder];
    } else if (textField == self.tfDireccion)
    {
        [self.tfTelefono becomeFirstResponder];
    } else if (textField == self.tfTelefono)
    {
        [self.tfCelular becomeFirstResponder];
    } else if (textField == self.tfCelular)
    {
        [self.tfTutor becomeFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
// Funcion del protocolo para guardar alumno
- (IBAction)crearBeneficiario:(UIBarButtonItem *)sender {
    NSString *nombre = self.tfNombre.text;
    NSString *telefono = self.tfTelefono.text;
    NSString *edad = self.tfEdad.text;
    NSString *direccion = self.tfDireccion.text;
    NSString *celular = self.tfCelular.text;
    NSString *tutor = self.tfTutor.text;
    
    if (![nombre isEqualToString:@""] && ![edad isEqualToString:@""] && ![direccion isEqualToString:@""] && ![tutor isEqualToString:@""]){
        
        [self.delegado crearBeneficiario:nombre withTel:telefono withEdad:edad withDireccion:direccion withCelular:celular withTutor:tutor];
        [self.delegado quitaVista];
        
    } else {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Faltan campos por completar" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
