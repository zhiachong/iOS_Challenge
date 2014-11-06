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
	NSString *maxCount;
	BOOL isFirstUpdate;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	NSNotification* notification = [NSNotification notificationWithName:@"UpdateView" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:@"UpdateView" object:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)calculateFibonacciForIndex {
	dispatch_queue_t backgroundQueue = dispatch_queue_create("fibonacciQueue", 0);
	dispatch_async(backgroundQueue, ^{
		JKBigInteger *count = [[JKBigInteger alloc] initWithString:maxCount];
		fibonacciNumbers = [NSArray arrayWithArray:[[MathFunctions shareInstance] getFibonacciSequence:count]];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
			[self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
		});
	});
}

- (void)updateTableView {
	fibonacciNumbers = [NSArray arrayWithArray:[MathFunctions shareInstance].numbersArray];
	[self.tableView reloadData];
	if (isFirstUpdate) {
		[self.tableView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
		isFirstUpdate = NO;
	}
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
	if (indexPath.row < [fibonacciNumbers count]) {
		NSString *formattedString = [NSString stringWithFormat:@"f[%d]: %@", indexPath.row, [fibonacciNumbers objectAtIndex:indexPath.row]];
		cell.textLabel.text =formattedString;
		cell.textLabel.adjustsFontSizeToFitWidth = YES;
		cell.textLabel.numberOfLines = 0;
		[cell.textLabel sizeToFit];
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	maxCount = textField.text;
	isFirstUpdate = YES;
	[self calculateFibonacciForIndex];
	return YES;
}

@end
