//
//  ViewController.m
//  Fibonacci
//
//  Created by PetrMac on 11/4/14.
//  Copyright (c) 2014 Petr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize table data
    
    [self redrawTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0) {
        [self redrawTable];
    }
    
    return [textField resignFirstResponder];
}

//Redraw table with entered max N
- (void)redrawTable{
    //check if entered text is a valid number
    NSScanner *scanner = [NSScanner scannerWithString: _textMaxN.text];
    BOOL isNumeric = [scanner scanInteger: NULL] && [scanner isAtEnd];
    
    if(!isNumeric)
        return; //don't redraw table if the text is not a valid number
    
    //Warning if the max number exceeds the max of unsigned int
    if([_textMaxN.text longLongValue] > 2147483647)
        [[[UIAlertView alloc] initWithTitle:@"Warnning" message:@"Numbers larger than 2147483647 will not be shown." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    NSString *tempString;
    unsigned int maxN = [_textMaxN.text intValue];
    unsigned int f1 = 1; // seed value 1
    unsigned int f2 = 0; // seed value 2
    unsigned int fn; // used as a holder for each new value in the loop
    self.tableData = [[NSMutableArray alloc] init];
    
    //loop while the number does not exceed the entered max N
    while(maxN > f1 + f2)
    {
        fn = f1 + f2;
        f1 = f2;
        f2 = fn;
        
        tempString = [NSString stringWithFormat: @"%d", fn];
        [self.tableData addObject:tempString];
    }
    //reload the table with regenerated fibonacci numbers
    [self.tableFibonacci reloadData];
}

@end