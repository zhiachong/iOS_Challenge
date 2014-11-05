//
//  ViewController.m
//  Fibonacci
//
//  Created by PetrMac on 11/4/14.
//  Copyright (c) 2014 Petr. All rights reserved.
//

#import "ViewController.h"

// Add two arrays of the same size (size)
// Each array is a representation of a natural number
// The returned array will have the size of (size + 1) elements


@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize table data
    
    _fibNumArr = [[NSMutableArray alloc] init];
    [_fibNumArr addObject:@"1"];
    [_fibNumArr addObject:@"1"];
    _maxN = [_textMaxN.text intValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _maxN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self getFibNum: (int)indexPath.row];
    cell.textLabel.numberOfLines = 0;
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

    _maxN = [_textMaxN.text intValue];
    
    [self.tableFibonacci reloadData];
}

- (NSString *) addTwoNumbers: (NSString *) arr1 :(NSString *) arr2 {
    if(arr1.length < arr2.length)
        arr1 = [@"0" stringByAppendingString:arr1];
    
    NSUInteger size = arr2.length;
    NSString *arrTotal = [[NSString alloc] init];
    
    NSInteger remainder = 0;
    for (NSInteger i = size - 1; i >= 0; i--) {
        NSString *c1 = [arr1 substringWithRange:NSMakeRange(i, 1)];
        NSString *c2 = [arr2 substringWithRange:NSMakeRange(i, 1)];
        
        NSInteger temp = [c1 integerValue] + [c2 integerValue] + remainder;
        NSInteger r = temp % 10;
        arrTotal = [[NSString stringWithFormat:@"%i", (int)r] stringByAppendingString: arrTotal];
        remainder = temp / 10;
    }
    if(remainder != 0)
        arrTotal = [[NSString stringWithFormat:@"%i", (int)remainder] stringByAppendingString: arrTotal];
    
    return arrTotal;
}

- (NSString *) getFibNum:(int) n {
    if(n < _fibNumArr.count)
        return [_fibNumArr objectAtIndex: n];
    
    NSString *fibNum1 = [_fibNumArr objectAtIndex:_fibNumArr.count - 2];
    NSString *fibNum2 = [_fibNumArr objectAtIndex:_fibNumArr.count - 1];
    NSString *fibReultNum;
    
    // Do the Iterative way
    for (int i = (int)_fibNumArr.count-1; i < n ; i++) {
        fibReultNum = [self addTwoNumbers: fibNum1 :fibNum2];
        fibNum1 = fibNum2;
        NSString *fibNum2Temp = fibReultNum;
        fibNum2 = fibNum2Temp;
        [_fibNumArr addObject:fibReultNum];
    }
    
    return fibReultNum;
}

@end