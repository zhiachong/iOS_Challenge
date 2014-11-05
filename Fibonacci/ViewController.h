//
//  ViewController.h
//  Fibonacci
//
//  Created by AnMac on 11/4/14.
//  Copyright (c) 2014 Petr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableFibonacci;
@property (nonatomic, retain) IBOutlet UITextField *textMaxN;
@property (strong) NSMutableArray *fibNumArr;
@property (nonatomic) int maxN;
@end

