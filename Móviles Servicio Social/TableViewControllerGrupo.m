//
//  TableViewControllerGrupo.m
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "TableViewControllerGrupo.h"
#import "CrearGrupoTableViewController.h"
#import "MenudelGrupoTableViewController.h"
#import <Parse/Parse.h>

@interface TableViewControllerGrupo ()
@property (strong,nonatomic) NSArray *listagrupos; // lista de los grupos en el proyecto
@property (strong,nonatomic) NSString *objectId;

@end

@implementation TableViewControllerGrupo
// obtiene el id del proyecto proviniente
- (void)setDetailItemLugar:(id)newdetailItemLugar {
    if (_detailItemLugar != newdetailItemLugar) {
        _detailItemLugar = newdetailItemLugar;
        
        // Update the view.
        //[self configureView];
    }
}
- (void)setProyectoSeleccionado:(id)proyectoSeleccionado {
    if (_proyectoSeleccionado != proyectoSeleccionado) {
        _proyectoSeleccionado = proyectoSeleccionado;
        
        // Update the view.
        [self configureView];
    }
}
// obtiene el id del lugar del staff
- (void) setLugarDeUsuario:(id)lugarDeUsuario {
    if (_lugarDeUsuario != lugarDeUsuario) {
        _lugarDeUsuario = lugarDeUsuario;
        // Update the view.
        //      [self configureView];
    }
}
// Funcion que hace un query select para buscar los grupos en el proyecto que se selecciono
- (void)configureView {
    // Update the user interface for the detail item.
    if (self.proyectoSeleccionado) {
        PFQuery *query = [PFQuery queryWithClassName:@"Grupo"];
        [query whereKey:@"IDProyecto" equalTo:[PFObject objectWithoutDataWithClassName:@"Proyecto" objectId:self.proyectoSeleccionado]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.listagrupos = [[NSMutableArray alloc]initWithArray:objects];
                [self.tableView reloadData];
            }
            if ([objects count] == 0){
                // There was a problem
                UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"No hay grupos disponibles." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
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
    
    if(self.lugarDeUsuario){
                                                              
        [self.addButton setEnabled:NO];
        [self.addButton setTintColor: [UIColor clearColor]];
        
    }

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
    return self.listagrupos.count;
}
// despliega numero/nombre del grupo
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"grupos" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.listagrupos valueForKey:@"Numero"] objectAtIndex:indexPath.row];
    
    return cell;
}


- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
// Funcion para borrar un grupo, si se borra el grupo tambien se borraran alumnos,  beneficiarios y staff relacionados a el
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"¿Desea borrar el grupo?"
                                      message:@"ATENCIÓN: Borrar el grupo eliminará permanentemente todos los datos del mismo."
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Si"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 PFObject *object = [self.listagrupos objectAtIndex:indexPath.row];
                                 [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                     [self viewDidLoad];
                                 }];
                                 // Borrar beneficiarios
                                 PFQuery *query = [PFQuery queryWithClassName:@"Beneficiario"];
                                 [query whereKey:@"IDGrupo" equalTo:[PFObject objectWithoutDataWithClassName:@"Grupo" objectId:[[self.listagrupos valueForKey:@"objectId"] objectAtIndex:indexPath.row]]];
                                 [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                     if (!error) {
                                      
                                         [PFObject deleteAllInBackground:objects];
                                     } else {
                                         NSLog(@"Error: %@ %@", error, [error userInfo]);
                                     }
                                 }];
                                 // Borrar alumnos
                                 PFQuery *query2 = [PFQuery queryWithClassName:@"Alumno"];
                                 [query2 whereKey:@"IDGrupo" equalTo:[PFObject objectWithoutDataWithClassName:@"Grupo" objectId:[[self.listagrupos valueForKey:@"objectId"] objectAtIndex:indexPath.row]]];
                                 [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects2, NSError *error) {
                                     if (!error) {
                                         [PFObject deleteAllInBackground:objects2];
                                     } else {
                                         NSLog(@"Error: %@ %@", error, [error userInfo]);
                                     }
                                 }];
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                            
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"No"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        [alert addAction:cancel];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

// Funcion para crear grupo, hace una funcion de insert PFObject con la informacion que se proporciono
- (void)crearGrupo:(NSString *)numero{
    PFObject *grupo = [PFObject objectWithClassName:@"Grupo"];
    grupo[@"Numero"] = numero;
    grupo[@"IDProyecto"] = [PFObject objectWithoutDataWithClassName:@"Proyecto" objectId:self.proyectoSeleccionado];
    
    [grupo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Listo" message:@"Grupo creado exitósamente" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            [self configureView];
        } else {
            // There was a problem
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Ocurrió un error al intentar crear el grupo" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
}
// quita la vista de crear grupo
- (void)quitaVista{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation

// Prepare for segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // si el segue es crear grupo, indica que el tableview es delegado
    if ([[segue identifier] isEqualToString:@"creargrupo"]){
        [[segue destinationViewController] setDelegado:self];
        // si el segue es el menu del grupo, manda el object id del grupo y lugar seleccionado variable que indica si es admin o no
    } else if([[segue identifier] isEqualToString:@"menugrupo"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.objectId = [[self.listagrupos valueForKey:@"objectId"] objectAtIndex:indexPath.row];
        [[segue destinationViewController] setIsAdmin:_lugarDeUsuario];
        [[segue destinationViewController] setGrupoSeleccionado:self.objectId];
        [[segue destinationViewController] setDetailItemLugar:_detailItemLugar];
        
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
