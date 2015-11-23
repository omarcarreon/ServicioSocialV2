//
//  AsistenciaAlumnosTableViewController.m
//  Móviles Servicio Social
//
//  Created by Angel González on 11/20/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "AsistenciaAlumnosTableViewController.h"
#import <Parse/Parse.h>

@interface AsistenciaAlumnosTableViewController ()
@property (strong,nonatomic) NSArray *listaalumnos;
@property (strong,nonatomic) NSString *objectId;

@end

@implementation AsistenciaAlumnosTableViewController

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
        PFQuery *query = [PFQuery queryWithClassName:@"Alumno"];
        [query whereKey:@"IDGrupo" equalTo:[PFObject objectWithoutDataWithClassName:@"Grupo" objectId:self.detailItem]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.listaalumnos = [[NSMutableArray alloc]initWithArray:objects];
                [self.tableView reloadData];
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

/*
 Parte del código que permite usar el checkmark.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = [[tableView indexPathsForVisibleRows] indexOfObject:indexPath];
    
    if (index != NSNotFound) {
        UITableViewCell *cell = [[tableView visibleCells] objectAtIndex:index];
        if ([cell accessoryType] == UITableViewCellAccessoryNone) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listaalumnos.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"asistenciaalumno" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.listaalumnos valueForKey:@"Nombre"] objectAtIndex:indexPath.row];
    
    return cell;
}


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

- (IBAction)guardarAsistenciaAlumno:(UIBarButtonItem *)sender {
    for (int row = 0; row < [self.tableView numberOfRowsInSection:0]; row++) {
        NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:0];
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:cellPath];
        NSString *tempID = [[self.listaalumnos valueForKey:@"objectId"]objectAtIndex:row];
        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            
            PFQuery *query = [PFQuery queryWithClassName:@"Alumno"];
            [query getObjectInBackgroundWithId:tempID
                                         block:^(PFObject *beneficiario, NSError *error) {
                                             [beneficiario incrementKey:@"Asistencia"];
                                             [beneficiario saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                 if (succeeded) {
                                                     // The score key has been incremented
                                                 } else {
                                                     // There was a problem, check error.description
                                                 }
                                             }];
                                         }];
            
        } else {
            PFQuery *query = [PFQuery queryWithClassName:@"Alumno"];
            [query getObjectInBackgroundWithId:tempID
                                         block:^(PFObject *beneficiario, NSError *error) {
                                             [beneficiario incrementKey:@"Faltas"];
                                             [beneficiario saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                 if (succeeded) {
                                                     // The score key has been incremented
                                                 } else {
                                                     // There was a problem, check error.description
                                                 }
                                             }];
                                         }];
        }
    }
    [self.delegado quitaVista2];
}
@end
