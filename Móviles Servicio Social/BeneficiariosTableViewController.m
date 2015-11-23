//
//  BeneficiariosTableViewController.m
//  Móviles Servicio Social
//
//  Created by Angel González on 11/12/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "BeneficiariosTableViewController.h"
#import "AgregarParticipantesTableViewController.h"
#import <Parse/Parse.h>
#import "listaTableViewCell.h"

@interface BeneficiariosTableViewController ()
@property (strong,nonatomic) NSArray *listabeneficiarios;
@property (strong,nonatomic) NSString *objectId;

@end

@implementation BeneficiariosTableViewController

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        PFQuery *query = [PFQuery queryWithClassName:@"Beneficiario"];
        [query whereKey:@"IDGrupo" equalTo:[PFObject objectWithoutDataWithClassName:@"Grupo" objectId:self.detailItem]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.listabeneficiarios = [[NSMutableArray alloc]initWithArray:objects];
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return self.listabeneficiarios.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    listaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beneficiarios" forIndexPath:indexPath];
    cell.tfNombre.text = [[self.listabeneficiarios valueForKey:@"Nombre"] objectAtIndex:indexPath.row];
    NSInteger asistencias= [[[self.listabeneficiarios valueForKey:@"Asistencia"] objectAtIndex:indexPath.row] intValue];
    NSInteger faltas = [[[self.listabeneficiarios valueForKey:@"Faltas"] objectAtIndex:indexPath.row] intValue];
    
    cell.tfAsistencia.text = [NSString stringWithFormat:@"%ld",asistencias];
    cell.tfFaltas.text = [NSString stringWithFormat:@"%ld",faltas];
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Borrar Beneficiario"
                                      message:@"¿Desea borrar el beneficiario?"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Si"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 PFObject *object = [self.listabeneficiarios objectAtIndex:indexPath.row];
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

- (void) crearBeneficiario:(NSString *)nombre withTel:(NSString *)telefono withEdad:(NSString  *)edad withDireccion:(NSString *)direccion withCelular:(NSString *)celular withTutor:(NSString *)tutor{
    PFObject *beneficiario = [PFObject objectWithClassName:@"Beneficiario"];
    beneficiario[@"Nombre"] = nombre;
    beneficiario[@"Telefono"] = telefono;
    beneficiario[@"Edad"] = edad;
    beneficiario[@"Direccion"] = direccion;
    beneficiario[@"Tutor"] = tutor;
    beneficiario[@"Celular"] = celular;
    beneficiario[@"IDGrupo"] = [PFObject objectWithoutDataWithClassName:@"Grupo" objectId:self.detailItem];
    beneficiario[@"Asistencia"] = [NSNumber numberWithInt:0];
    beneficiario[@"Faltas"] = [NSNumber numberWithInt:0];
    
    
    [beneficiario saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Listo" message:@"Beneficiario agregado exitosamente" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            [self configureView];
        } else {
            // There was a problem
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Ocurrió un error al intentar agregar al beneficiario" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
}

- (void)quitaVista{
    [self.navigationController popViewControllerAnimated:YES];
}

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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"crearbeneficiario"]){
        [[segue destinationViewController] setDelegado:self];
    } else if ([[segue identifier] isEqualToString:@"detallebeneficiario"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.objectId = [[self.listabeneficiarios valueForKey:@"objectId"] objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:self.objectId];
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
