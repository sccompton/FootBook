//
//  MasterViewController.m
//  FootBook
//
//  Created by Stephen Compton on 1/29/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Person.h"
#import "Profile.h"
@import CoreData;


@interface MasterViewController ()<NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *peopleArray;
}

@end

@implementation MasterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:@"foo"];
    [_fetchedResultsController performFetch:nil];
    _fetchedResultsController.delegate = self;
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"First Run"])
    {
         [self load];
        [userDefaults setObject:[NSDate date ] forKey:@"First Run"];
    [userDefaults synchronize];
    
    }
    //[self reload];
}


-(void)load
{
    
    NSURL* url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/3/friends.json"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         peopleArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

         for (NSString *text in peopleArray) {
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
             person.name = text;
        [self.managedObjectContext save:nil];
         }
     }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fetchedResultsController.sections[section] numberOfObjects];
}

//reloads tableview everytime anything is done with the table
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        default:
            break;
    }
}


- (IBAction)onPersonAdded:(UITextField *)sender {
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_managedObjectContext];
    person.name = sender.text;
    NSError *error = nil;
    [_managedObjectContext save: &error];
    // [self.tableView reloadData];
    sender.text = @"";
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *person = [_fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = person.name;
 //   cell.detailTextLabel.text = profile.hairiness;
    return cell;
}


//delete person:
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *person = [_fetchedResultsController objectAtIndexPath:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_managedObjectContext deleteObject:person];
        [_managedObjectContext save:nil];
    }
}



//-(IBAction)unWindFromDetailController:(UIStoryboardSegue *)segue
//{
//    DetailViewController *viewController = segue.sourceViewController;
//    NSIndexPath *indexPath;
//    
//    [peopleArray addObject:[viewController adoredToothpaste]];
//    indexPath = [NSIndexPath indexPathForRow: adoredToothpastesArray.count-1 inSection:0];
//    [adoredToothpastesTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationFade];
//    NSLog(@"unwind");
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
