//
//  DetailViewController.m
//  NFL12
//
//  Created by Kritsakorn on 7/24/15.
//  Copyright (c) 2015 Kritsakorn. All rights reserved.
//

#import "DetailViewController.h"
#import "NFLVenueData.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *venueImageView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        if ([self isViewLoaded]) {
            [self configureView];
        }
        
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NFLVenueData *venueData = (NFLVenueData *)self.detailItem;
        self.nameLabel.text = venueData.name;
        self.addressLineLabel.text = [venueData getFullAddress];
        
        //set schedule
        NSMutableString *scheduleText = [NSMutableString stringWithString:@""];
        for (NSDictionary *scheduleDict in venueData.schedule) {
            [scheduleText appendString:[NFLVenueData requiredDateFormat:scheduleDict]];
        }
        self.scheduleLabel.text = scheduleText;
        
        //check and load image of venue
        if (!venueData.venueImage) {
            if (![venueData.imageURL  isEqual: @""]) {
                NSURL *url = [NSURL URLWithString:venueData.imageURL];
                [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
                    if (succeeded) {
                        dispatch_async(dispatch_get_main_queue(), ^(void)
                        {
                            self.venueImageView.image = image;
                            // cache tthe image
                            venueData.venueImage = image;
                        });
                    }
                }];
            }
        }
        else {
           self.venueImageView.image = venueData.venueImage;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
}

#pragma mark - Asynchronously load image from URL
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ( !error )
         {
             UIImage *image = [[UIImage alloc] initWithData:data];
             completionBlock(YES,image);
         } else{
             completionBlock(NO,nil);
         }
     }];
}



@end
