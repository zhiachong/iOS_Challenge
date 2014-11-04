//
//  ViewController.m
//  Fibonacci
//
//  Created by toxicsun on 11/4/14.
//  Copyright (c) 2014 Arevik Tunyan. All rights reserved.
//

#import "ViewController.h"
#import "MathFunctions.h"

@interface ViewController () {
	NSArray *fibonacciNumbers;
	NSInteger maxCount;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)calculateFibonacci {
	fibonacciNumbers = [[MathFunctions shareInstance] getFibonacciSequence:maxCount];
	[self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [fibonacciNumbers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@", [fibonacciNumbers objectAtIndex:indexPath.row]];
	
	return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	maxCount = [textField.text integerValue];
	[self calculateFibonacci];
	return YES;
}

@end
