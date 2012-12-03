//
//  MyParser.m
//  EpubRead
//
//  Created by T.Furuyama on 11/07/20.
//  Copyright 2011 TF 技術研究所. All rights reserved.
//

#import "MyParser.h"
#import "Ncx.h"

@implementation MyParser
@synthesize opfFilePath = opfFilePath_;
@synthesize ncxFilePath = ncxFilePath_;
@synthesize ncx = ncx_;
@synthesize srcArray = srcArray_;

- (void) dealloc {
    [opfFilePath_ release];
    [ncxFilePath_ release];
    [srcArray_ release];
    [ncx_ release];
    self.opfFilePath = nil;
    self.ncxFilePath = nil;
    self.ncx = nil;
    self.srcArray = nil;
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithFile:(NSString*)path {
    LOG_METHOD;
    self = [super init];
    srcArray_ = [[NSMutableArray alloc] init];
    LOG(@"%@", path);
    if (self) {
        NSData *xml = [NSData dataWithContentsOfFile:path];
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xml];
        [parser setDelegate:self];
        parser.shouldProcessNamespaces = NO;
        parser.shouldReportNamespacePrefixes = NO;
        parser.shouldResolveExternalEntities = NO;
        [parser parse];
        
    }
    return self;
}
- (void)parse:(NSString*)output parseError:(NSError**)error {
    LOG_METHOD;
    NSString *path = [output stringByAppendingPathComponent:@"ext/META-INF/container.xml"];
    NSData *xml = [NSData dataWithContentsOfFile:path];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xml];
    //parser.delegate = self;
    [parser setDelegate:self];
    parser.shouldProcessNamespaces = NO;
    parser.shouldReportNamespacePrefixes = NO;
    parser.shouldResolveExternalEntities = NO;
    [parser parse];
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
    }
}

// Reduce potential parsing errors by using string constants declared in a single place.
static NSString * const kEntryElementName = @"entry";
static NSString * const kLinkElementName = @"link";
static NSString * const kTitleElementName = @"title";
static NSString * const kUpdatedElementName = @"updated";
static NSString * const kGeoRSSPointElementName = @"georss:point";

#pragma mark -
#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    LOG_METHOD;
    if (qName) {
        elementName = qName;
    }
    if ([elementName isEqualToString:@"rootfile"]) {
        opfFilePath_ = [attributeDict objectForKey:@"full-path"];
    }
    if ([elementName isEqualToString:@"item"]) {
        NSString *relAttribute = [attributeDict valueForKey:@"id"];
        if ([relAttribute isEqualToString:@"ncx"]) {
            ncxFilePath_ = [attributeDict valueForKey:@"href"];
            LOG(@"ncxFilePath_=%@", ncxFilePath_);
            
        }
    }
    if ([elementName isEqualToString:@"content"]) {
        NSString *relAttribute = [attributeDict valueForKey:@"src"];
        [srcArray_ addObject:relAttribute];
        LOG(@"content=%@", relAttribute);
    }    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    LOG_METHOD;
    
}
@end
