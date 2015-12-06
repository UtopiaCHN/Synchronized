//
//  ViewController.m
//  Synchronized
//
//  Created by Utopia on 15/12/7.
//  Copyright © 2015年 Utopia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *bigArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self synchronized];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)synchronized
{
    bigArray = [NSMutableArray arrayWithCapacity:5];
    
    NSString *value0 = @"foo";
    NSString *value1 = @"bar";
    
    for (int i = 0; i < 5; i++)
    {
        [bigArray addObject:[NSString stringWithFormat:@"object-%d", i]];
    }
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self updateBigArray:value0];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self updateBigArray:value1];
    });
    
}

- (void)updateBigArray:(NSString *)value
{
    @synchronized(value)
    {
        for (int j = 0; j < bigArray.count; j++)
        {
            NSString *currentObject = [bigArray objectAtIndex:j];
            
            [bigArray replaceObjectAtIndex:j withObject:[currentObject stringByAppendingFormat:@"-%@", value]];   NSLog(@"%@", [bigArray objectAtIndex:j]);
        }
    }
    
  
}
@end
