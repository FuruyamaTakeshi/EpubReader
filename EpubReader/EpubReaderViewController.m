//
//  EpubReaderViewController.m
//  EpubReader
//
//  Created by T.Furuyama on 11/07/20.
//  Copyright 2011 TF 技術研究所. All rights reserved.
//

#import "EpubReaderViewController.h"
#import "ZipArchive.h"
#import "MyParser.h"

@implementation EpubReaderViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    LOG_METHOD;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path_ = [paths objectAtIndex:0];
    //NSString *inPath = [[NSBundle mainBundle] pathForResource:@"LittleBoPeep-ANurseryRhymePictureBook" ofType:@"epub"];
    NSString *inPath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"epub"];
    
    ZipArchive *zarchive = [[ZipArchive alloc] init];
    
    if ([zarchive UnzipOpenFile:inPath]) {
        BOOL ret = [zarchive UnzipFileTo:[path_ stringByAppendingPathComponent:@"ext"] overWrite:YES];
        if (ret == NO) {
            LOG(@"error");
        }
        [zarchive UnzipCloseFile];
    }
    [zarchive release];
    MyParser *myparser = [[MyParser alloc] init];
    NSError *parseError = nil;
    LOG(@"path=%@", path_);
    
    [myparser parse:path_ parseError:&parseError];
    NSString *opfFilePath = myparser.opfFilePath;
    LOG(@"out:%@", opfFilePath);
    //NSString *pathext = [path stringByAppendingPathComponent:@"ext/META-INF/container.xml"];
    NSString *pathext = [path_ stringByAppendingString:[NSString stringWithFormat:@"/ext/%@", opfFilePath]];
    LOG(@"ext:%@", pathext);
    
    MyParser *ncxparser = [[MyParser alloc] initWithFile:pathext];
    
    LOG(@"%@", ncxparser.ncxFilePath);
    
    navMapparser_ = [[MyParser alloc] initWithFile:[path_ stringByAppendingFormat:@"/ext/OEBPS/%@", ncxparser.ncxFilePath]];
    
    NSString *cotentPath = [NSString stringWithFormat:@"%@/ext/OEBPS/%@", path_, [navMapparser_.srcArray objectAtIndex:1]]; 
    LOG(@"contentPath=%@", cotentPath);
    webview_ = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    NSURL *url = [NSURL fileURLWithPath:cotentPath];
    NSURLRequest *urlreq = [[NSURLRequest alloc] initWithURL:url];
                        
    [webview_ loadRequest:urlreq];
    webview_.center = self.view.center;
    [self.view addSubview:webview_];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma -
#pragma Touch Event
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 

}
@end
