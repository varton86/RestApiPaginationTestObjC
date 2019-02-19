//
//  ListViewController.m
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 10.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
- (IBAction)doneButton:(UIBarButtonItem *)sender;

@end

@implementation ListViewController
{
    DataService *dataService;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.indicatorView startAnimating];
    self.title = @"List of Airports";

    dataService = [[DataService alloc] initWithCode:self.code];
    dataService.delegate = self;
    [dataService fetchData];
}

- (IBAction)doneButton:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataService totalCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"List"];
    if ([self isLoadingCellForIndexPath:indexPath])
    {
        [cell configureWithAirport:nil];
    }
    else
    {
        [cell configureWithAirport:[dataService airportAtIndex:indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    for (NSIndexPath * indexPath in indexPaths)
    {
        if ([self isLoadingCellForIndexPath:indexPath])
        {
            [dataService fetchData];
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (NO == [self isLoadingCellForIndexPath:indexPath])
    {
        [self performSegueWithIdentifier:@"ShowDetail" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([@"ShowDetail" isEqualToString:segue.identifier])
    {
        DetailViewController *detailViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (nil != indexPath)
        {
            detailViewController.airport = [dataService airportAtIndex:indexPath.row];
        }
    }
}

- (BOOL)isLoadingCellForIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row >= [dataService currentCount];
}

- (void)onFetchCompletedWithNewIndexPathsToReload:(NSArray<NSIndexPath *> *)newIndexPathsToReload
{
    if (YES == self.tableView.hidden)
    {
        [self.indicatorView stopAnimating];
        [self.tableView reloadData];
        self.tableView.hidden = NO;
        return;
    }
    NSArray<NSIndexPath *> *indexPathsToInsert = [self calculateIndexPathsToInsert];
    NSArray<NSIndexPath *> *indexPathsToReload = [self calculateIndexPathsToReload:newIndexPathsToReload];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];

    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)onFetchFailedWithReason:(NSString *)reason
{
    if (YES == self.tableView.hidden)
    {
        [self.indicatorView stopAnimating];
        self.tableView.hidden = NO;
    }
    [self.tableView reloadData];
    AlertDisplayer(self, reason);
}

- (NSArray<NSIndexPath *> *)calculateIndexPathsToReload:(NSArray<NSIndexPath *> *)indexPaths
{
    NSArray<NSIndexPath *> *indexPathsForVisibleRows = self.tableView.indexPathsForVisibleRows;
    NSMutableArray *indexPathsIntersection = [[NSMutableArray alloc] init];
    for (NSIndexPath *indexPath in indexPaths)
    {
        if ([indexPathsForVisibleRows containsObject:indexPath])
        {
            [indexPathsIntersection addObject:indexPath];
        }
    }
    return indexPathsIntersection;
}
     
- (NSArray<NSIndexPath *> *)calculateIndexPathsToInsert
{
    NSUInteger startIndex = [dataService currentCount];
    NSUInteger endIndex = [dataService totalCount];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSUInteger index = startIndex; index < endIndex; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [indexPathsToInsert addObject:indexPath];
    }
    return indexPathsToInsert;
}

@end
