//
//  MenudelGrupoTableViewController.m
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "MenudelGrupoTableViewController.h"
#import "AsistenciaTableViewController.h"

@interface MenudelGrupoTableViewController ()
@property (strong,nonatomic) NSString *objectId;

@end

@implementation MenudelGrupoTableViewController
//  Obtiene el id del grupo en el que el admin esta navegando
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        //[self configureView];
    }
}
//  Obtiene el id del grupo del usuario, loggeado como usuario
-(void)setIsAdmin:(id)isAdmin{
    if (_isAdmin != isAdmin) {
        _isAdmin = isAdmin;
        
        // Update the view.
        //[self configureView];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //Cambia el color de la barra.
    [self.navigationController.navigationBar setBarTintColor:[self colorWithHexString:@"00B28C"]];
    //Cambia el color del titulo
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];
    //Cambia el color del back.
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    // si no es admin, aparece un boton de logout
    if(!self.isAdmin){
        self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                             initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//  Decide las secciones para mostrar en el menu de acuerdo a si es admin o no
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.isAdmin){
        return 2;
    } else {
        return 3;
    }
}
//  Decide las opciones para mostrar en el menu de acuerdo a si es admin o no
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2){
        return 1;
    } else{
        return 2;
    }
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


#pragma mark - Navigation

// Prepare for segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Si el segue es al tableview de beneficiarios envia id del grupo
    if ([[segue identifier] isEqualToString:@"beneficiarios"]) {
        [[segue destinationViewController] setDetailItem:self.detailItem];
        // si el segue es al tableview de alumnos envia id del grupo
    } else if ([[segue identifier] isEqualToString:@"alumnos"]) {
        [[segue destinationViewController] setDetailItem:self.detailItem];
        // si el segue es a crear staff indica que esta view es el delegado
    } else if ([[segue identifier] isEqualToString:@"crearstaff"]){
        [[segue destinationViewController] setDelegado:self];
        // si el segue es a tomar asistencia de beneficiario envia id del grupo e indica que esta view es el delegado
    } else if ([[segue identifier] isEqualToString:@"tomarasistenciabeneficiario"]){
        [[segue destinationViewController] setDetailItem:self.detailItem];
        [[segue destinationViewController] setDelegado:self];
        // si el segue es a tomar asistencia de alumnos envia id del grupo e indica que esta view es el delegado
    } else if ([[segue identifier] isEqualToString:@"asistenciaalumnos"]){
        [[segue destinationViewController] setDetailItem:self.detailItem];
        [[segue destinationViewController] setDelegado:self];
    }
}
//  Funcion para agregar staff, hace una función de parse tipo PFUser y se le agregan todos los datos que se proporcionaron
- (void) agregarStaff:(NSString *)email withName:(NSString *)name withID:(NSString *)mat withCareer:(NSString *)career withSemester:(NSString *)sem withTelefono:(NSString *)tel withPassword:(NSString *)pass{
    
    PFUser *user = [PFUser user];
    user.username = email;
    user.password = pass;
    user[@"Nombre"] = name;
    user.email = email;
    user[@"Matricula"] = mat;
    user[@"Carrera"] = career;
    user[@"Semestre"] = sem;
    user[@"Telefono"] = tel;
    user[@"IDGrupo"] = [PFObject objectWithoutDataWithClassName:@"Grupo" objectId:self.detailItem];
    NSNumber *privilegios = [NSNumber numberWithBool:NO];
    [user setObject:privilegios forKey:@"Privilegios"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // si no hay error, muestra mensaje de listo
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Listo" message:@"Staff creado exitósamente" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            // hubo un error
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Ocurrió un error al intentar crear el staff" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }];
    
}

// Funcion del protocolo para quitar vista
- (void)quitaVista{
    [self.navigationController popViewControllerAnimated:YES];
}
// Funcion del protocolo para quitar vista cuando se regresa de tomar asistencia
-(void)quitaVista2{
    [self.navigationController popViewControllerAnimated:YES];
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Listo" message:@"Asistencia guardada" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
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
