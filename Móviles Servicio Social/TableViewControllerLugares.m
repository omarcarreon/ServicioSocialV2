//
//  TableViewControllerLugares.m
//  Móviles Servicio Social
//
//  Created by Omar Carreon on 04/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "TableViewControllerLugares.h"
#import "TableViewControllerProyectos.h"
#import <Parse/Parse.h>

@interface TableViewControllerLugares ()
@property (strong,nonatomic) NSMutableArray *objects2;
@property (strong,nonatomic) NSString *objectId;
@property (strong,nonatomic) NSString *objectIdToDelete;
@end

@implementation TableViewControllerLugares
- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.objects2 = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"Lugar"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.objects2 = [[NSMutableArray alloc]initWithArray:objects];
            [self.tableView reloadData];
        }
    }];
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Lugar"];
    self.objects2 = [query findObjects];
    
    */
    
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
    return self.objects2.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lugares" forIndexPath:indexPath];
    cell.textLabel.text = [[self.objects2 valueForKey:@"Nombre"] objectAtIndex:indexPath.row];
    //self.objectId = [[NSString alloc]init];
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"Proyecto"];
        [query whereKey:@"IDLugar" equalTo:[PFObject objectWithoutDataWithClassName:@"Lugar" objectId:[[self.objects2 valueForKey:@"objectId"] objectAtIndex:indexPath.row]]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                if ([objects count] > 0){
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:@"Borrar Lugar"
                                                  message:@"El lugar tiene proyectos y no puede borrarse."
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
                                                  alertControllerWithTitle:@"Borrar Lugar"
                                                  message:@"El lugar está vacío, ¿desea borrarlo?"
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction
                                         actionWithTitle:@"Si"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             PFObject *object = [self.objects2 objectAtIndex:indexPath.row];
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


- (void) crearLugar:(NSString *)nombre withDir:(NSString *)dir{
    PFObject *lugar = [PFObject objectWithClassName:@"Lugar"];
    lugar[@"Nombre"] = nombre;
    lugar[@"Direccion"] = dir;

    [lugar saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Listo" message:@"Lugar creado exitosamente" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            [self viewDidLoad];
        } else {
            // There was a problem
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Ocurrió un error al intentar crear el lugar" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (void)quitaVista{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"proyectos"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.objectId = [[self.objects2 valueForKey:@"objectId"] objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:self.objectId];
        
    }
    else if ([[segue identifier] isEqualToString:@"crearlugar"]){
        [[segue destinationViewController] setDelegado:self];
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
