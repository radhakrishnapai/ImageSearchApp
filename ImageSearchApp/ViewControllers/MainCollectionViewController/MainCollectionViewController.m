 //
//  MainCollectionViewController.m
//  ImageSearchApp
//
//  Created by Pai on 5/19/18.
//  Copyright © 2018 Pai. All rights reserved.
//

#import "MainCollectionViewController.h"
#import "FlickrPhotoSearchWebService.h"
#import "FlickrSearchResponce.h"
#import "FlickrPhotoCollectionViewCell.h"
#import "FlickrPhoto.h"
#import "ImageDownloadManager.h"
#import "CustomNavigationAnimation.h"
#import "ImageDetailViewController.h"

typedef enum : NSUInteger {
    TwoItems = 2,
    ThreeItems,
    FourItems,
} NumberOfItems;

@interface MainCollectionViewController () {
    NSMutableArray *_photosArray;
    NSMutableArray *_flickrPhotosArray;
    NumberOfItems _numberOfItemsPerRow;
    UISearchBar *_searchBar;
    CGRect _originFrame;
    FlickrPhoto *_selectedPhoto;
    FlickrPhotoCollectionViewCell *_selectedCell;
    BOOL _isPaginating;
}

@property (strong, nonatomic) IBOutlet UIView *emptyView;

@end

@implementation MainCollectionViewController

static NSString * const reuseIdentifier = @"FlickrPhotoCollectionViewCell";
static NSString * const headerReuseIdentifier = @"HeaderView";
static NSString * const footerReuseIdentifier = @"FooterView";
static NSString * const thumbnailURL = @"https://farm%ld.staticflickr.com/%@/%@_%@_t.jpg";
static NSString * const segueIdentifier = @"showDetails";
static CGFloat navigationBarHeight = 44; // Could not find a way to get height of navigation bar of the VC to be pushed.

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _photosArray = [[NSMutableArray alloc] init];
    _flickrPhotosArray = [[NSMutableArray alloc] init];
    _numberOfItemsPerRow = TwoItems;
    self.navigationController.delegate = self;
    [self createRefreshControl];
    [self reloadPage];
    [self createSearchbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSearchbar {
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.placeholder = @"Search an image";
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    self.navigationItem.titleView = _searchBar;
}

- (void)createRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadPage) forControlEvents:UIControlEventValueChanged];
    refreshControl.transform = CGAffineTransformScale(refreshControl.transform, 0.7, 0.7);
    self.collectionView.refreshControl = refreshControl;
}

- (void)reloadPage {
    [self searchPhotosForText:_searchBar.text page:1 blocking:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:segueIdentifier]) {
        ImageDetailViewController *toViewController = (ImageDetailViewController *)segue.destinationViewController;
        toViewController.imageView.image = _selectedCell.imageView.image;
        toViewController.image = _selectedCell.imageView.image;
        toViewController.flickrPhoto = _selectedPhoto;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        
        // Return frames for animating the transition
        
        
        ImageDetailViewController *imageDetailVC = (ImageDetailViewController *)toVC;
        [imageDetailVC.view layoutIfNeeded];
        CGRect frame = imageDetailVC.view.frame;
        CGRect navFrame = imageDetailVC.navigationController.navigationBar.frame;
        if (@available(iOS 11.0, *)) {
            // issue to get frame of size arrea.
            
            UIWindow *window = UIApplication.sharedApplication.keyWindow;
            CGFloat topPadding = window.safeAreaInsets.top;
            CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
            if (topPadding < statusBarHeight) {
                topPadding = statusBarHeight;
            }
            CGFloat bottomPadding = window.safeAreaInsets.bottom;
            frame.origin.y = topPadding + navigationBarHeight;
            frame.size.height -= (topPadding + bottomPadding + navigationBarHeight);
        } else {
            frame.origin.y = navFrame.origin.y + navigationBarHeight;
            frame.size.height -= (navFrame.origin.y + navigationBarHeight);
        }
        
        return [[CustomNavigationAnimation alloc] initWithOriginFrame:_originFrame endFrame:frame animatingView:imageDetailVC.imageView duration:UINavigationControllerHideShowBarDuration isPresenting:YES];
    } else if (operation == UINavigationControllerOperationPop) {
        ImageDetailViewController *imageDetailVC = (ImageDetailViewController *)fromVC;
        CGRect frame = [imageDetailVC.imageView convertRect:imageDetailVC.imageView.frame toView:imageDetailVC.view];
        return [[CustomNavigationAnimation alloc] initWithOriginFrame:frame endFrame:_originFrame animatingView:imageDetailVC.imageView duration:UINavigationControllerHideShowBarDuration isPresenting:NO];
    } else {
        return nil;
    }
}


#pragma mark Flickr Search API

- (void)searchPhotosForText:(NSString *)searchText page:(NSInteger)page blocking:(BOOL)isBlocking {
    if (isBlocking) {
        if (!self.collectionView.refreshControl.isRefreshing) {
            [LoadingIndicator startAnimatingInView:self.view];
        }
    }
    
    [FlickrPhotoSearchWebService getFlickrPhotoSearchWithSearchText:searchText page:page success:^(NSURLResponse *response, id responseObject) {
        FlickrSearchResponce *searchResponse = [[FlickrSearchResponce alloc] initWithDictionary:responseObject];
        FlickrPhotos *flickrPhotos = searchResponse.photos;
        if (page == 1) {
            [_flickrPhotosArray removeAllObjects];
            [_photosArray removeAllObjects];
            if (self.collectionView.refreshControl.isRefreshing) {
                [self.collectionView.refreshControl endRefreshing];
            } else {
                [LoadingIndicator stopAnimating];
            }
        }
        [_flickrPhotosArray addObject:searchResponse.photos];
        [_photosArray addObjectsFromArray:flickrPhotos.photosArray];
        [self.collectionView reloadData];
        [self manageEmptyView];
        _isPaginating = false;
    } failure:^(NSError *error) {
        if (page == 1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Image Search App" message:error.userInfo[@"NSLocalizedDescription"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        if (self.collectionView.refreshControl.isRefreshing) {
            [self.collectionView.refreshControl endRefreshing];
        } else {
            [LoadingIndicator stopAnimating];
        }
        _isPaginating = false;
        [self.collectionView reloadData];
        [self manageEmptyView];
    }];
}

- (void)manageEmptyView {
    if (_photosArray.count == 0) {
        self.emptyView.frame = self.collectionView.frame;
        [self.view addSubview:self.emptyView];
    } else {
        [self.emptyView removeFromSuperview];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoCollectionViewCell *collectionViewCell = (FlickrPhotoCollectionViewCell *)cell;
    collectionViewCell.imageView.image = [UIImage imageNamed:@"PlaceholderImage"];;
    FlickrPhoto *flickrPhoto = [_photosArray objectAtIndex:indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:thumbnailURL, (long)flickrPhoto.farm, flickrPhoto.server, flickrPhoto.idField, flickrPhoto.secret]];
    [[ImageDownloadManager sharedInstance] downloadImageForUrl:imageUrl completionBlock:^(NSURL *url, UIImage *image, NSError *error) {
        if (error == nil) {
            if (![url.absoluteString containsString:FLICKR_PHOTO_UNAVAILABLE_URL_STRING]) {
                collectionViewCell.imageView.image = image;
            }
        }
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhoto *flickrPhoto = [_photosArray objectAtIndex:indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:thumbnailURL, (long)flickrPhoto.farm, flickrPhoto.server, flickrPhoto.idField, flickrPhoto.secret]];
    [[ImageDownloadManager sharedInstance].session getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
        for (NSURLSessionDownloadTask *downloadTask in downloadTasks) {
            if ([imageUrl.absoluteString isEqualToString:downloadTask.originalRequest.URL.absoluteString]) {
                downloadTask.priority = 0.5;
            }
        }
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    _originFrame = [collectionView convertRect:layoutAttributes.frame toView:collectionView.superview];
    _selectedPhoto = [_photosArray objectAtIndex:indexPath.row];
    _selectedCell = (FlickrPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:segueIdentifier sender:nil];
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat size = (screenWidth - 20.0 - (10.0 * (_numberOfItemsPerRow - 1))) / _numberOfItemsPerRow;
    return CGSizeMake(size, size);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    FlickrPhotos *photos = [_flickrPhotosArray lastObject];
    if (photos) {
        if ((photos.page + 1) <= photos.pages) {
            CGSize size = [UIScreen mainScreen].bounds.size;
            size.height = 30.0;
            return size;
        } else {
            return CGSizeZero;
        }
    } else {
        return CGSizeZero;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionFooter ]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseIdentifier forIndexPath:indexPath];
    } else {
        return nil;
    }
}

# pragma mark Option Button

- (IBAction)tappedOnOptionButton:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Select number of images to be displayed per row" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"2 images" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _numberOfItemsPerRow = TwoItems;
        [self.collectionView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"3 images" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _numberOfItemsPerRow = ThreeItems;
        [self.collectionView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"4 images" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _numberOfItemsPerRow = FourItems;
        [self.collectionView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchPhotosForText:searchBar.text page:1 blocking:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.collectionView.contentOffset.y + self.collectionView.bounds.size.height > self.collectionView.contentSize.height - 30) {
        FlickrPhotos *photos = [_flickrPhotosArray lastObject];
        if ((photos.page + 1) <= photos.pages) {
            if (!_isPaginating) {
                [self searchPhotosForText:_searchBar.text page:photos.page + 1 blocking:NO];
                _isPaginating = true;
            }
        }
    }
}

@end
