//
//  TableViewControllerProyectos.m
//  Móviles Servicio Social
//
//  Created by Omar Carreon on 04/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "TableViewControllerProyectos.h"
#import "TableViewControllerLugares.h"
#import "CrearProyectoTableViewController.h"
#import "TableViewControllerGrupo.h"
#import <Parse/Parse.h>

@interface TableViewControllerProyectos ()
@property (strong,nonatomic) NSArray *listaproyectos; // lista de los proyectos en el lugar
@property (strong,nonatomic) NSString *objectId;
@property (strong,nonatomic) NSString *objectIdToDelete; // guarda el objeto a borrar
@end

@implementation TableViewControllerProyectos
// obtiene el id del lugar proviniente
- (void)setLugarSeleccionado:(id)lugarSeleccionado{
    if (_lugarSeleccionado != lugarSeleccionado) {
        _lugarSeleccionado = lugarSeleccionado;
        
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
// Funcion que hace un query select para buscar los proyectos en el lugar que se selecciono
- (void)configureView {
    // Update the user interface for the detail item.
    if (!self.lugarDeUsuario) {
        PFQuery *query = [PFQuery queryWithClassName:@"Proyecto"];
        //[query whereKey:@"IDLugar" equalTo:self.detailItem];
        [query whereKey:@"IDLugar" equalTo:[PFObject objectWithoutDataWithClassName:@"Lugar" objectId:self.lugarSeleccionado]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.listaproyectos = [[NSMutableArray alloc]initWithArray:objects];
                [self.tableView reloadData];
            }
            if ([objects count] == 0){
                // There was a problem
                UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"No hay proyectos disponibles." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
        NSLog(@"admin");
    } else {
        PFQuery *query = [PFQuery queryWithClassName:@"Proyecto"];
        //[query whereKey:@"IDLugar" equalTo:self.detailItem];
        [query whereKey:@"IDLugar" equalTo:[PFObject objectWithoutDataWithClassName:@"Lugar" objectId:self.lugarDeUsuario]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.listaproyectos = [[NSMutableArray alloc]initWithArray:objects];
                [self.tableView reloadData];
            }
            if ([objects count] == 0){
                // There was a problem
                UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"No hay proyectos disponibles." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
        NSLog(@"no admin");
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
        self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                                             initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:nil action:nil];
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

    return self.listaproyectos.count;
}

// despliega nombre del proyecto
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"proyectos" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.listaproyectos valueForKey:@"Nombre"] objectAtIndex:indexPath.row];
    
    return cell;
}


- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

// Funcion para borrar un proyecto, solo se puede borrar si no hay grupos en el
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"Grupo"];
        [query whereKey:@"IDProyecto" equalTo:[PFObject objectWithoutDataWithClassName:@"Proyecto" objectId:[[self.listaproyectos valueForKey:@"objectId"] objectAtIndex:indexPath.row]]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                if ([objects count] > 0){
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:@"Borrar Proyecto"
                                                  message:@"El proyecto tiene grupos y no puede borrarse."
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction
                                         actionWithTitle:@"Ok"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                             
                                         }];
                    [alert addAction:ok];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                } else {
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:@"Borrar Proyecto"
                                                  message:@"El proyecto está vacío, ¿desea borrarlo?"
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction
                                         actionWithTitle:@"Si"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             PFObject *object = [self.listaproyectos objectAtIndex:indexPath.row];
                                             [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                 [self viewDidLoad];
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
        }];

    }
}

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
    // si el segue es crear proyecto, indica que el tableview es delegado
    if ([[segue identifier] isEqualToString:@"crearproyecto"]){
        [[segue destinationViewController] setDelegado:self];
        // si el segue se dirige a un grupo, envia object id del proyecto seleccionado y del lugar proviniente
    } else if ([[segue identifier] isEqualToString:@"grupos"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.objectId = [[self.listaproyectos valueForKey:@"objectId"] objectAtIndex:indexPath.row];
        [[segue destinationViewController] setProyectoSeleccionado:self.objectId];
        [[segue destinationViewController] setDetailItemLugar:self.lugarSeleccionado];
        [[segue destinationViewController] setLugarDeUsuario:self.lugarDeUsuario];
    }
}

// Funcion para crear proyecto, hace una funcion de insert PFObject con la informacion que se proporciono
- (void)crearProyecto:(NSString *)nombre withDes:(NSString *)des{
    PFObject *proyecto = [PFObject objectWithClassName:@"Proyecto"];
    proyecto[@"Nombre"] = nombre;
    proyecto[@"Descripcion"] = des;
    proyecto[@"IDLugar"] = [PFObject objectWithoutDataWithClassName:@"Lugar" objectId:self.lugarSeleccionado];
    
    [proyecto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Listo" message:@"Proyecto creado exitósamente" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            [self configureView];
        } else {
            // There was a problem
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Ocurrió un error al intentar crear el proyecto" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
}
// quita la vista de crear proyecto
- (void)quitaVista{
    [self.navigationController popViewControllerAnimated:YES];
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
