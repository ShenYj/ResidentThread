//
//  ViewController.m
//  ResidentThread
//
//  Created by EZen on 2025/05/06.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction
                                                                                           target: self
                                                                                           action: @selector(toucheRightNavigationItem:)];
}

- (void)toucheRightNavigationItem:(id)sender {
    
    NextViewController *nextVC = [[NextViewController alloc] init];
    [self.navigationController pushViewController: nextVC animated: YES];
}

@end
