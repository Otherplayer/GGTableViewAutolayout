//
//  ViewController.m
//  GGTableViewAutoLayout
//
//  Created by __无邪_ on 15/4/28.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "ViewController.h"
#import "GGCell.h"

#define IOS_VERSION_7_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
#define IS_IOS8 (kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_7_1)


static NSString *iden = @"GGCellIdentifier";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *tableData;
@property (nonatomic, strong) UITableViewCell *prototypeCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableData = @[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890", @"1\n2", @"1\n2\n3", @"1"];
    
//    [self.tableView registerClass:[GGCell class] forCellReuseIdentifier:iden];
    if (IS_IOS8) {
        self.tableView.estimatedRowHeight = 44.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }else{
        self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:iden];
    }
    
    NSLog(@"%d",IS_IOS8);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GGCell *cell = [tableView dequeueReusableCellWithIdentifier:iden forIndexPath:indexPath];
    [cell.introLabel setText:[self.tableData objectAtIndex:indexPath.row]];
    return cell;
}

//#ifdef XXX
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IOS8) {
        return UITableViewAutomaticDimension;
    }
    
    GGCell *cell = (GGCell *)self.prototypeCell;
    cell.introLabel.text = [self.tableData objectAtIndex:indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"h=%f", size.height + 1);
    return 1  + size.height;
    
}
//
//#else
//
//#endif

@end
