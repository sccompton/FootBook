//
//  DetailViewController.m
//  FootBook
//
//  Created by Stephen Compton on 1/29/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import "DetailViewController.h"
#import "Person.h"
#import "Profile.h"
@import CoreData;


@interface DetailViewController ()<NSFetchedResultsControllerDelegate>
{
    __weak IBOutlet UITextField *numberOfFeetTextField;
    __weak IBOutlet UITextField *shoeSizeTextField;
    __weak IBOutlet UITextField *hairinessTextField;
    __weak IBOutlet UITextView *commentsTextView;
    __weak IBOutlet UIImageView *feetImageView;
    Person *person;
    __weak IBOutlet UILabel *numberOfFeetLabel;
    __weak IBOutlet UILabel *shoeSizeLabel;
    __weak IBOutlet UILabel *hairinessLabel;

}

- (void)configureView;


@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Profile"];
//    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"hairiness" ascending:YES]];
//    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:@"foo"];
//    [_fetchedResultsController performFetch:nil];
//    _fetchedResultsController.delegate = self;
//
    
    
    commentsTextView.alpha = 0;
    hairinessTextField.alpha = 0;
    shoeSizeTextField.alpha = 0;
    numberOfFeetTextField.alpha = 0;
    
    numberOfFeetLabel.alpha = 1;
    shoeSizeLabel.alpha = 1;
    hairinessLabel.alpha = 1;
    
//    hairinessLabel.text = profile.hairiness;
//    profile.size = shoeSizeTextField.text;
//    profile.hairiness = hairinessTextField.text;
//    profile.number = numberOfFeetTextField.text;

    [self configureView];
}



- (IBAction)onEditButtonPressed:(id)sender {
    commentsTextView.alpha = 1;
    hairinessTextField.alpha = 1;
    shoeSizeTextField.alpha = 1;
    numberOfFeetTextField.alpha = 1;
    
    numberOfFeetLabel.alpha = 0;
    shoeSizeLabel.alpha = 0;
    hairinessLabel.alpha = 0;
    
}


- (IBAction)onProfileCreated:(id)sender {
    Profile *profile = [NSEntityDescription insertNewObjectForEntityForName:@"Profile" inManagedObjectContext:person.managedObjectContext];
    profile.size = shoeSizeTextField.text;
    profile.hairiness = hairinessTextField.text;
    profile.number = numberOfFeetTextField.text;
    profile.comment = commentsTextView.text;
    [person addProfileObject:profile];
    [person.managedObjectContext save:nil];
    
    numberOfFeetLabel.text = profile.number;
    shoeSizeLabel.text = profile.size;
    hairinessLabel.text = profile.hairiness;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    commentsTextView.alpha = 0;
    hairinessTextField.alpha = 0;
    shoeSizeTextField.alpha = 0;
    numberOfFeetTextField.alpha = 0;
    
    numberOfFeetLabel.alpha = 1;
    shoeSizeLabel.alpha = 1;
    hairinessLabel.alpha = 1;
}

- (void)setDetailItem:(Person *)newPerson
{
    person = newPerson;
    self.title = person.name;
    
}


#pragma mark - Managing the detail item

//- (void)setDetailItem:(id)newDetailItem
//{
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//        // Update the view.
//        [self configureView];
//    }
//}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
