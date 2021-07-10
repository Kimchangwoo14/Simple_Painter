//
//  ViewController.m
//  Simple_painter
//
//  Created by 김창우 on 10/03/2019.
//  Copyright © 2019 김창우. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





// Fix 버튼 클릭시 호출
-(IBAction) fixClick {
    
    [(MainView *)self.view setPCurDrawMode:false];
}


- (IBAction)undoClick:(id)sender {
    [(MainView *)self.view undoCheck];
}
- (IBAction)redoClick:(id)sender {
    [(MainView *)self.view redoCheck];
}
- (IBAction)setDrawMode:(id)sender {
    [(MainView *)self.view setPCurDrawMode:true];
}



// Setup 버튼 클릭시 호출
-(IBAction) setupClick {
    if(pPaintSetupView == nil) {
        PaintSetupView *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PaintSetupView"];
        viewController.delegate = self;
        pPaintSetupView = viewController;
    }
    [self presentViewController:pPaintSetupView animated:YES completion:nil];
}

// PainterSetupViewDelegate 델리케이트 구현 함수 (선 색상 설정)
- (void)painterSetupView:(PaintSetupView *)controller setColor:(UIColor *)color {
    [(MainView *)self.view setPCurColor:color];
}

// PainterSetupViewDelegate 델리게이트 구현 함수 (선 두께 설정)
- (void)painterSetupView:(PaintSetupView *)controller setWidth:(float)width {
    [(MainView *)self.view setPCurWidth:width];
}

- (IBAction)saveClick:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Save File"
                                          message:@"Input File Name"                                        preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"FileName", @"FileName");
     }];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSString *fileName = alertController.textFields.firstObject.text;
                                   fileName = [fileName stringByAppendingString:@".sp"];
                                   [(MainView *)self.view saveFile:fileName];
                               }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
- (IBAction)loadClick:(id)sender {
    /*
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Load File"
                                          message:@"Input File Name"                                        preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"FileName", @"FileName");
     }];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSString *fileName = alertController.textFields.firstObject.text;
                                   
                                   
                                   [(MainView *)self.view clearData];
                                   [(MainView *)self.view loadFile:fileName];
                               }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
    
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
     */
    fileList = [[NSMutableArray alloc] init];
    [fileList addObjectsFromArray:[(MainView *)self.view loadFileView]];
    UITableView *table =[[UITableView alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    table.delegate = self;
    table.dataSource = self;
    
    
    [self.view addSubview:table];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    NSString *fileName = [fileList objectAtIndex:indexPath.row];
    fileName = [fileName stringByReplacingOccurrencesOfString:@".sp" withString:@""];
    [cell.textLabel setText:fileName];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    cellText = [cellText stringByAppendingString:@".sp"];
    [(MainView *)self.view clearData];
    [(MainView *)self.view loadFile:cellText];
    [tableView removeFromSuperview];
    
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu",(unsigned long)fileList.count+1);
    return fileList.count;
}




@end
