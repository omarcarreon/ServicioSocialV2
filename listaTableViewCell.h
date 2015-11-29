//
//  listaTableViewCell.h
//  Móviles Servicio Social
//
//  Created by Omar Carreon on 21/11/15.
//  Copyright © 2015 Angel González. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface listaTableViewCell : UITableViewCell
// outlets que se utilizan en alumnos y beneficiarios para mostrar faltas y asistencias
@property (strong, nonatomic) IBOutlet UILabel *tfAsistencia;
@property (strong, nonatomic) IBOutlet UILabel *tfFaltas;
@property (strong, nonatomic) IBOutlet UILabel *tfNombre;


@end
