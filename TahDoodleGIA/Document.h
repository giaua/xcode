//
//  Document.h
//  TahDoodleGIA
//
//  Created by Admin on 31.07.15.
//  Copyright (c) 2015 Alliance Holding Limited Liability Company. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
    <NSTableViewDataSource>
@property (nonatomic) NSMutableArray *tasks;
@property (nonatomic) IBOutlet NSTableView *tasksTable;
@property (nonatomic, readonly) NSInteger clickedRow;
- (IBAction)addTasks:(id)sender;
- (IBAction)deleteTasks:(id)sender;

@end

