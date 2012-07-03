
#import "AppViewController.h"
#import "PageView.h"

@implementation AppViewController

@synthesize pagingScrollView, pageControl;

- (void)viewDidLoad
{
	[super viewDidLoad];

	numPages = 3;

	self.pagingScrollView.frame = (CGRect) { .origin = {0, 0}, .size = {320, 416} };
	self.pagingScrollView.padding = 20;
	self.pagingScrollView.previewInsets = UIEdgeInsetsMake(0, 20, 0, 20);
	self.pagingScrollView.pageInsets = UIEdgeInsetsMake(10, 10, 10, 10);
	[self.pagingScrollView reloadPages];

	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = numPages;
}

- (void)releaseObjects
{
	self.pagingScrollView = nil;
	self.pageControl = nil;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	[self releaseObjects];
}

- (void)dealloc
{
	[self releaseObjects];
}

- (void)didReceiveMemoryWarning
{
	[self.pagingScrollView didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)pageTurn
{
	[self.pagingScrollView selectPageAtIndex:pageControl.currentPage animated:YES];
}

#pragma mark - View Controller Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.pagingScrollView beforeRotation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.pagingScrollView afterRotation];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)theScrollView
{
	self.pageControl.currentPage = [self.pagingScrollView indexOfSelectedPage];
	[self.pagingScrollView scrollViewDidScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)theScrollView
{
	if ([self.pagingScrollView indexOfSelectedPage] == numPages - 1)
	{
		numPages++;
		[self.pagingScrollView reloadPages];
		self.pageControl.numberOfPages = numPages;
	}
  
	[self.pagingScrollView scrollViewDidEndDecelerating];
}

#pragma mark - MHPagingScrollViewDelegate

- (NSInteger)numberOfPagesInPagingScrollView:(MHPagingScrollView *)pagingScrollView
{
	return numPages;
}

- (UIView *)pagingScrollView:(MHPagingScrollView *)thePagingScrollView pageForIndex:(NSInteger)index
{
	PageView *pageView = (PageView *)[thePagingScrollView dequeueReusablePage];
	if (pageView == nil)
		pageView = [[PageView alloc] init];

	[pageView setPageIndex:index];
	return pageView;
}

@end
