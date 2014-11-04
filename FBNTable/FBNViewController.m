//
//  ViewController.m
//  FBNTable
//
//  Created by Dzmitry Navak on 04/11/14.
//  Copyright (c) 2014 navakdzmitry. All rights reserved.
//

#import "FBNViewController.h"
#import "FBNCellTableViewCell.h"
#import "FBNFibNumbers.h"

@interface FBNViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITextField*          fibCount;
@property (nonatomic, strong) UIButton*             fibStart;
@property (nonatomic, strong) UITableView*          fbTable;
@property (nonatomic, strong) FBNFibNumbers*        fbNumbers;
@property (nonatomic)         unsigned long long    fibN;
@property (nonatomic, strong) NSMutableArray*       heightCashe;

@end

@implementation FBNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fibN = 3;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.fibCount = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth(self.view.bounds) - 120, 50)];
    [_fibCount setKeyboardType:UIKeyboardTypeNumberPad];
    _fibCount.text = [NSString stringWithFormat:@"%llu",_fibN];
    [_fibStart setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
    [self.view addSubview:_fibCount];
    
    self.fibStart = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fibCount.frame), 20, 100, 50)];
    [_fibStart addTarget:self action:@selector(onFibStart) forControlEvents:UIControlEventTouchUpInside];
    [_fibStart setTitle:@"Reload" forState:UIControlStateNormal];
    [_fibStart setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.04]];
    [_fibStart setTitleColor:[UIColor colorWithWhite:0 alpha:0.9] forState:UIControlStateNormal];
    [self.view addSubview:_fibStart];
    
    self.fbTable = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                 CGRectGetMaxY(self.fibCount.frame) + 10,
                                                                 CGRectGetWidth(self.view.bounds),
                                                                 CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.fibCount.frame) - 10)
                                                style:UITableViewStylePlain];
    
    _fbTable.delegate = self;
    _fbTable.dataSource = self;
    _fbTable.rowHeight = 40;
    _fbTable.allowsSelection = NO;
    
    [self.view addSubview:_fbTable];
    
    self.fbNumbers = [[FBNFibNumbers alloc] initWithCapacity:_fibN];
    
    UITapGestureRecognizer* viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    viewTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:viewTap];
}

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fibN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"CommemtCellIdentifier";
    
    FBNCellTableViewCell* fbCell = [self.fbTable dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!fbCell) {
        fbCell = [[FBNCellTableViewCell alloc] initWithReuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.row < _fibN) {
        [fbCell setFibNumber:[self.fbNumbers fibStringAtPosition:indexPath.row] forPosition:indexPath.row];
    }
    
    for (int i = 0; i< 1; i++) {
        if (indexPath.row + i < _fibN) {
            [self.fbNumbers fibStringAtPosition:(indexPath.row+i)];
        }
    }
    
    return fbCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static FBNCellTableViewCell* testCell = nil;
    if(!testCell) {
        testCell = [[FBNCellTableViewCell alloc] initWithReuseIdentifier:nil];
    }
    
    if(indexPath.row < _fibN) {
        if ([_fbNumbers isElementSetted:indexPath.row]) {
            [testCell setFibNumber:[self.fbNumbers fibStringAtPosition:indexPath.row] forPosition:indexPath.row];
            return MAX([testCell optimalHeight], self.fbTable.rowHeight);
        }
        
        return self.fbTable.rowHeight;
    }
    
    return self.fbTable.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

# pragma mark - actions

- (void)onFibStart
{
    [self.view endEditing:YES];
    
    if ([self.fibCount.text integerValue] > 0) {
        _fibN = [self.fibCount.text integerValue];
        self.fbNumbers = [[FBNFibNumbers alloc] initWithCapacity:_fibN];
        
        [self.fbTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        [self.fbTable reloadData];
    }
}

- (void)onTap:(id)sender
{
    [self.view endEditing:YES];
}

@end
