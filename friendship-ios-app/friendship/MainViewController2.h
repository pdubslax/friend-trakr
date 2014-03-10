//
//  MainViewController2.h
//  TableSearch
//
//  Created by jmatchett on 05/20/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class Product;

@protocol ProductPickerDelegate2 <NSObject>
@required
-(void)productWasPicked:(Product*)product;
@end

@interface MainViewController2 : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
{
	NSArray			*listContent;			// The master content.
	NSMutableArray	*filteredListContent;	// The content filtered as a result of a search.
	
	// The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    BOOL			searchWasActive;
    id <ProductPickerDelegate2> delegate1;
    UISearchDisplayController *aSearchDisplayController;
}

@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain) UISearchDisplayController *aSearchDisplayController;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@property (assign) id <ProductPickerDelegate2> delegate;

@end