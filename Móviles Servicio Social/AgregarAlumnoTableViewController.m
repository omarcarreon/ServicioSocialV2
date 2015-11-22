//
//  AgregarAlumnoTableViewController.m
//  Móviles Servicio Social
//
//  Created by alumno on 13/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "AgregarAlumnoTableViewController.h"

@interface AgregarAlumnoTableViewController ()

@end

@implementation AgregarAlumnoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tfNombre.delegate = (id)self;
    self.tfMatricula.delegate = (id)self;
    self.tfCorreo.delegate = (id)self;
    self.tfTelefono.delegate = (id)self;
    self.tfCarrera.delegate = (id)self;
    self.tfSemestre.delegate = (id)self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.tfNombre)
    {
        [self.tfMatricula becomeFirstResponder];
    }
    else if (textField == self.tfMatricula)
    {
       [self.tfCorreo becomeFirstResponder];
    }
    else if (textField == self.tfCorreo)
    {
        [self.tfCarrera becomeFirstResponder];
    }
    else if (textField == self.tfCarrera)
    {
        [self.tfSemestre becomeFirstResponder];
    }
    else if (textField == self.tfSemestre)
    {
        [self.tfTelefono becomeFirstResponder];
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


- (IBAction)guardarAlumno:(UIBarButtonItem *)sender {
    NSString *email = self.tfCorreo.text;
    NSString *nombre = self.tfNombre.text;
    NSString *matricula = self.tfMatricula.text;
    NSString *carrera = self.tfCarrera.text;
    NSString *semestre = self.tfSemestre.text;
    NSString *telefono = self.tfTelefono.text;
    
    if (![email isEqualToString:@""] && ![nombre isEqualToString:@""] && ![matricula isEqualToString:@""] && ![carrera isEqualToString:@""] && ![semestre isEqualToString:@""] && ![telefono isEqualToString:@""]){
        
        [self.delegado crearAlumno:email withName:nombre withID:matricula withCareer:carrera withSemester:semestre withTelefono:telefono];
        [self.delegado quitaVista];
        
    } else {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Faltan campos por completar" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
