//
//  AlumnosTableViewController.m
//  Móviles Servicio Social
//
//  Created by alumno on 13/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "AlumnosTableViewController.h"
#import <Parse/Parse.h>
#import "listaTableViewCell.h"

@interface AlumnosTableViewController ()
@property (strong,nonatomic) NSArray *listaalumnos; //arreglo con lista de alumnos
@property (strong,nonatomic) NSString *objectId;
@end

@implementation AlumnosTableViewController
//   Obtiene id del grupo
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
// Funcion para desplegar todos los alumnos del grupo actual
- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        PFQuery *query = [PFQuery queryWithClassName:@"Alumno"];
        [query whereKey:@"IDGrupo" equalTo:[PFObject objectWithoutDataWithClassName:@"Grupo" objectId:self.detailItem]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.listaalumnos = [[NSMutableArray alloc]initWithArray:objects];
                [self.tableView reloadData];
            }
            if ([objects count] == 0){
                // There was a problem
                UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"No hay alumnos registrados en este grupo." preferredStyle:UIAlertControllerStyleAlert];
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
    return self.listaalumnos.count;
}
//  Despliega nombre , asistencias y faltas del alumno
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    listaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alumnos" forIndexPath:indexPath];
    cell.tfNombre.text = [[self.listaalumnos valueForKey:@"Nombre"] objectAtIndex:indexPath.row];
    NSInteger asistencias= [[[self.listaalumnos valueForKey:@"Asistencia"] objectAtIndex:indexPath.row] intValue];
    NSInteger faltas = [[[self.listaalumnos valueForKey:@"Faltas"] objectAtIndex:indexPath.row] intValue];
    
    cell.tfAsistencia.text = [NSString stringWithFormat:@"%ld",asistencias];
    cell.tfFaltas.text = [NSString stringWithFormat:@"%ld",faltas];
    return cell;
}


- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//  Funcion para borrar un alumno
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Borrar Alumno"
                                      message:@"¿Desea borrar el alumno?"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Si"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 PFObject *object = [self.listaalumnos objectAtIndex:indexPath.row];
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
// Quita vista de agregar alumno
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
// Funcion de prepare for segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // si el segue es crear alumno, indica que el tableview es el delegado
    if ([[segue identifier] isEqualToString:@"crearalumno"]){
        [[segue destinationViewController] setDelegado:self];
        // si el segue es el detalle del alumno, pasa el object id del alumno seleccionado
    } else if ([[segue identifier] isEqualToString:@"detallealumno"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.objectId = [[self.listaalumnos valueForKey:@"objectId"] objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:self.objectId];
    }
}

// Funcion para crear alumno, aqui se hace la funcion de parse PFObject para crearlo con los parametros recibidos
- (void) crearAlumno:(NSString *)email withName:(NSString *)name withID:(NSString *)mat withCareer:(NSString *)career withSemester:(NSString *)sem withTelefono:(NSString *)tel{
    
    PFObject *alumno = [PFObject objectWithClassName:@"Alumno"];
    alumno[@"Nombre"] = name;
    alumno[@"Matricula"] = mat;
    alumno[@"Correo"] = email;
    alumno[@"Telefono"] = tel;
    alumno[@"Carrera"] = career;
    alumno[@"Semestre"] = sem;
    alumno[@"IDGrupo"] = [PFObject objectWithoutDataWithClassName:@"Grupo" objectId:self.detailItem];
    alumno[@"Asistencia"] = [NSNumber numberWithInt:0];
    alumno[@"Faltas"] = [NSNumber numberWithInt:0];
    
    
    [alumno saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Listo" message:@"Alumno agregado exitósamente" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            [self configureView];
        } else {
            // There was a problem
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Ocurrió un error al intentar agregar al alumno" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

@end
