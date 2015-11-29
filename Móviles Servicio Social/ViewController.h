//
//  ViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 10/21/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
// outlet boton de login
@property (weak, nonatomic) IBOutlet UIButton *bttnLogin;
// outlet textfield email
@property (weak, nonatomic) IBOutlet UITextField *tfEMail;
// outlet textfield password
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
// accion del boton login
- (IBAction)login:(UIButton *)sender;
// quita el teclado
- (void) voidQuitaTeclado;

@end

