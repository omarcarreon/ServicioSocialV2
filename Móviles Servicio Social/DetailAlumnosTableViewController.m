//
//  DetailAlumnosTableViewController.m
//  Móviles Servicio Social
//
//  Created by Omar Carreon on 22/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "DetailAlumnosTableViewController.h"
#import <Parse/Parse.h>

@interface DetailAlumnosTableViewController ()

@end

@implementation DetailAlumnosTableViewController
// obtiene objectid del alumno
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
// Funcion que hace un query select buscando al alumno con su object id, si lo encuentra despliega su info
- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        PFQuery *query = [PFQuery queryWithClassName:@"Alumno"];
        [query whereKey:@"objectId" equalTo:self.detailItem];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.tfNombre.text = [[objects valueForKey:@"Nombre"] objectAtIndex:0];
                self.tfTelefono.text = [[objects valueForKey:@"Telefono"] objectAtIndex:0];
                self.tfMatricula.text = [[objects valueForKey:@"Matricula"] objectAtIndex:0];
                self.tfCorreo.text = [[objects valueForKey:@"Correo"] objectAtIndex:0];
                self.tfCarrera.text = [[objects valueForKey:@"Carrera"] objectAtIndex:0];
                self.tfSemestre.text = [[objects valueForKey:@"Semestre"] objectAtIndex:0];
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

@end
