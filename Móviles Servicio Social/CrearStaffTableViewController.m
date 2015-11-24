//
//  CrearStaffTableViewController.m
//  Móviles Servicio Social
//
//  Created by Angel González on 11/5/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import "CrearStaffTableViewController.h"
#import <Parse/Parse.h>

@interface CrearStaffTableViewController ()

@end

@implementation CrearStaffTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
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
    
    self.tfEMail.delegate = (id)self;
    self.tfPassword.delegate = (id)self;
    self.tfName.delegate = (id)self;
    self.tfID.delegate = (id)self;
    self.tfCareer.delegate = (id)self;
    self.tfSemester.delegate = (id)self;
    self.tfTelefono.delegate = (id)self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.tfName)
    {
        [self.tfEMail becomeFirstResponder];
    }
    else if (textField == self.tfEMail)
    {
        [self.tfPassword becomeFirstResponder];
    }
    else if (textField == self.tfPassword)
    {
        [self.tfID becomeFirstResponder];
    }
    else if (textField == self.tfID)
    {
        [self.tfCareer becomeFirstResponder];
    }
    else if (textField == self.tfCareer)
    {
        [self.tfSemester becomeFirstResponder];
        
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
    return 7;
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

- (IBAction)guardarStaff:(UIBarButtonItem *)sender {
    NSString *email = self.tfEMail.text;
    NSString *nombre = self.tfName.text;
    NSString *matricula = self.tfID.text;
    NSString *carrera = self.tfCareer.text;
    NSString *semestre = self.tfSemester.text;
    NSString *telefono = self.tfTelefono.text;
    NSString *pass = self.tfPassword.text;
    
    if (![email isEqualToString:@""] && ![nombre isEqualToString:@""] && ![matricula isEqualToString:@""] && ![carrera isEqualToString:@""] && ![semestre isEqualToString:@""] && ![telefono isEqualToString:@""] && ![pass isEqualToString:@""]){
        
        [self.delegado agregarStaff:email withName:nombre withID:matricula withCareer:carrera withSemester:semestre withTelefono:telefono withPassword:pass];
        [self.delegado quitaVista];
        
    } else {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Faltan campos por completar" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
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
