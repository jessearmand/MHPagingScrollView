
#import "MHPagingScrollView.h"

@interface AppViewController : UIViewController <MHPagingScrollViewDelegate, UIScrollViewDelegate>
{
	int numPages;
}

@property (nonatomic, strong) IBOutlet MHPagingScrollView *pagingScrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

- (IBAction)pageTurn;

@end
