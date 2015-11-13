//
//  ViewController.h
//  Móviles Servicio Social
//
//  Created by Angel González on 10/21/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *bttnLogin;

@property (weak, nonatomic) IBOutlet UITextField *tfEMail;

@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

- (IBAction)login:(UIButton *)sender;

- (void) voidQuitaTeclado;

@end

