//
//  SZNItemViewController.m
//  SZNZoteroDemo
//
//  Created by Vincent Tourraine on 19/04/13.
//  Copyright (c) 2013 shazino. All rights reserved.
//

#import "SZNItemViewController.h"
#import <SZNZotero.h>

@interface SZNItemViewController ()

@property (nonatomic, strong) NSDictionary *displayableItemContent;

@end

@implementation SZNItemViewController

- (void)setItem:(SZNItem *)item
{
    _item = item;
    self.displayableItemContent = [item.content dictionaryWithValuesForKeys:[[item.content keysOfEntriesPassingTest:^BOOL(id key, id obj, BOOL *stop) {
        return [obj isKindOfClass:[NSString class]] && ![obj isEqualToString:@""];
    }] allObjects]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 3;
    else
        return [[self.displayableItemContent allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SZNDetailCell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = @"Title";
                cell.detailTextLabel.text = self.item.title;
                break;
            case 1:
                cell.textLabel.text = @"Type";
                cell.detailTextLabel.text = self.item.type;
                break;
            case 2:
                cell.textLabel.text = @"Identifier";
                cell.detailTextLabel.text = self.item.identifier;
                break;
        }
    }
    else
    {
        NSString *key = [self.displayableItemContent allKeys][indexPath.row];
        cell.textLabel.text = key;
        cell.detailTextLabel.text = self.displayableItemContent[key];
    }
    
    return cell;
}

#pragma mark - Table view delegate

@end