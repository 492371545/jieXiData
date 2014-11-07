//
//  ViewController.m
//  XMLOrJSON
//
//  Created by Mengying Xu on 14-11-3.
//  Copyright (c) 2014年 Crystal Xu. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "WebViewController.h"
@interface ViewController ()

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UITableView *dataTable;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"NSXMLParser",@"KissXML",@"NSJSONSerialization",@"JSONKit",@"HTML",@"加载html", nil];

}
#pragma mark -UITableView DataSource And Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sfagv"];
    
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 5)
    {
        WebViewController *vc = [[WebViewController alloc] init];

        [self.navigationController pushViewController:vc animated:YES];

        return;
    }
    
    TableViewController *vc = [[TableViewController alloc] init];
    
    vc.selectRow = indexPath.row+1;
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
