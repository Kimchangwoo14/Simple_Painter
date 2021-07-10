//
//  ViewController.h
//  Simple_painter
//
//  Created by 김창우 on 10/03/2019.
//  Copyright © 2019 김창우. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointData.h"
#import "MainView.h"
#import "PaintSetupView.h"

@interface ViewController : UIViewController<PainterSetupViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    PaintSetupView *pPaintSetupView;
    NSMutableArray *fileList;
}


//Fix 버튼 클릭시 호출
-(IBAction) fixClick;
// Setup 버튼 클릭시 호출
-(IBAction) setupClick;




@end

