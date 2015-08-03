//
//  Document.m
//  TahDoodleGIA
//
//  Created by Admin on 31.07.15.
//  Copyright (c) 2015 Alliance Holding Limited Liability Company. All rights reserved.
//

#import "Document.h"

@interface Document ()

@end

@implementation Document

#pragma mark - NSDocuments Overrides

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    //[NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    //return nil;
    
    // This method is called when our document is being saved
    // You are expexted to hand the caller an NSData objext wrapping our data
    // so that it can be written out an empty array
    if (!self.tasks) {
        self.tasks = [NSMutableArray array];
    }
    
    // Pack the tasks array into an NSData object
    NSData *data = [NSPropertyListSerialization
                    dataWithPropertyList:self.tasks
                    format:NSPropertyListXMLFormat_v1_0
                    options:0
                    error:outError];
    
    // Return the newly-packed NSData object
    return data;
    
}

- (BOOL)readFromData:(NSData *)data
              ofType:(NSString *)typeName
               error:(NSError **)outError {
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    // [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
    // return YES;
    
    // This method is called when a document is being loaded
    // You are handed an NSData object and expected to pull out data out of it
    // Extract the tasks
    self.tasks = [NSPropertyListSerialization propertyListWithData:data
                                                           options:NSPropertyListMutableContainers
                                                            format:NULL
                                                             error:outError];
    // return success or failiture depending on success of the above call
    return (self.tasks != nil);
    
}

#pragma mark - Data Source Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
    // This table view displays the tasks array,
    // so the number of entries in the table views will be the same
    // as the number of objects in the array
    return [self.tasks count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    // Return the item from tasks that corresponds to the cell
    // that the table view wants to display
    return [self.tasks objectAtIndex:row];
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    // When the user changes a task on the table view,
    // update tasks array
    [self.tasks replaceObjectAtIndex:row withObject:object];
    
    // And than flag the document as having unsaved changes
    [self updateChangeCount:NSChangeDone];
}


#pragma mark - Actions

- (void)addTasks:(id)sender
{
    // NSLog(@"Add Task button clicked!");
    // If there is no array yet, create one
    if (!self.tasks) {
        self.tasks = [NSMutableArray array];
    }
    
    [self.tasks addObject:@"New Item"];
    NSLog(@"Add Task button clicked!");
    // -reloadData tells the table view to refresh and ask its dataSource
    // (which happens to be this Document object in this case)
    // for new data to display
    [self.tasksTable reloadData];
    
    // -updateChangeCount: tells the application whether or not the document
    // has unsaved changes, NSChangeDone flags the documents unsaved
    [self updateChangeCount:NSChangeDone];
}

- (void)deleteTasks:(id)sender
{
    NSLog(@"%ld", (long)_clickedRow);
    [self.tasks removeObjectAtIndex:2];
    [self.tasksTable reloadData];
    [self updateChangeCount:NSChangeDone];
}


@end
