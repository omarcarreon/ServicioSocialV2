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

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        //[self configureView];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"beneficiarios"]) {
        [[segue destinationViewController] setDetailItem:self.detailItem];
    } else if ([[segue identifier] isEqualToString:@"alumnos"]) {
        [[segue destinationViewController] setDetailItem:self.detailItem];
    } else if ([[segue identifier] isEqualToString:@"crearstaff"]){
        [[segue destinationViewController] setDelegado:self];
    } else if ([[segue identifier] isEqualToString:@"tomarasistenciabeneficiario"]){
        [[segue destinationViewController] setDetailItem:self.detailItem];
        [[segue destinationViewController] setDelegado:self];
    } else if ([[segue identifier] isEqualToString:@"asistenciaalumnos"]){
        [[segue destinationViewController] setDetailItem:self.detailItem];
        [[segue destinationViewController] setDelegado:self];
    }
}

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

-(void)quitaVista2{
    [self.navigationController popViewControllerAnimated:YES];
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Listo" message:@"Asistencia guardada" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
