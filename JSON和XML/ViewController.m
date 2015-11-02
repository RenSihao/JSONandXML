//
//  ViewController.m
//  JSON和XML
//
//  Created by RenSihao on 15/10/29.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "ViewController.h"
#import "BookInfo.h"

@interface ViewController () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *books;
@property (nonatomic, strong) BookInfo *bookInfo;
@property (nonatomic, strong) NSString *content; //内容哨兵
@property (nonatomic, strong) NSString *attri; //属性哨兵
@end

@implementation ViewController

//视图已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     初始化两个按钮，分别用于启动XML解析和JSON解析
     */
    
    UIButton *jsonBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    jsonBtn.frame = CGRectMake(10, 64, 300, 30);
    [jsonBtn setTitle:@"JSON解析_NSJSONSerialization(性能最好)" forState:UIControlStateNormal];
    jsonBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    jsonBtn.titleLabel.textColor = [UIColor blackColor];
    jsonBtn.backgroundColor = [UIColor orangeColor];
    jsonBtn.tag = 1;
    [jsonBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jsonBtn];
    
    
    UIButton *jsonBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    jsonBtn1.frame = CGRectMake(10,CGRectGetMaxY(jsonBtn.frame)+5, 300, 30);
    [jsonBtn1 setTitle:@"JSON解析_JSONKit(使用方便)" forState:UIControlStateNormal];
    jsonBtn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    jsonBtn1.titleLabel.textColor = [UIColor blackColor];
    jsonBtn1.backgroundColor = [UIColor orangeColor];
    jsonBtn1.tag = 2;
    [jsonBtn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jsonBtn1];
    
    
    
    
    UIButton *xmlBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    xmlBtn.frame = CGRectMake(10,CGRectGetMaxY(jsonBtn1.frame)+5, 350, 30);
    [xmlBtn setTitle:@"XML解析_NSMLPrarser(SAX方式，适合大文件)" forState:UIControlStateNormal];
    xmlBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    xmlBtn.titleLabel.textColor = [UIColor whiteColor];
    xmlBtn.backgroundColor = [UIColor blueColor];
    xmlBtn.tag = 3;
    [xmlBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xmlBtn];
    
    
    UIButton *xmlBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    xmlBtn1.frame = CGRectMake(10,CGRectGetMaxY(xmlBtn.frame)+5, 350, 30);
    [xmlBtn1 setTitle:@"XML解析_GDataXML(DOM方式，适合小文件)" forState:UIControlStateNormal];
    xmlBtn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    xmlBtn1.titleLabel.textColor = [UIColor whiteColor];
    xmlBtn1.backgroundColor = [UIColor blueColor];
    xmlBtn1.tag = 4;
    [xmlBtn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xmlBtn1];
    
    
}
/**
 lazyload
 */
- (NSMutableArray *)books
{
    if(!_books)
    {
        _books = [NSMutableArray array];
    }
    return _books;
}
/**
 监听点击事件
 */
- (void)buttonClick:(UIButton *)sender
{
    if(sender.tag == 1)
    {
        NSLog(@"JSONSeria");
        [self jsonParserJSONSeria];
    }
    else if(sender.tag == 2)
    {
        NSLog(@"JSONKit");
        [self jsonParserJSONKit];
    }
    else if (sender.tag == 3)
    {
        NSLog(@"SAX");
        [self xmlParserSAX];
        
    }
    else if(sender.tag == 4)
    {
        NSLog(@"DOM");
        [self xmlParserDOM];
    }
    
}
/**
 XML 解析方法 使用NSXMLParser
 */
- (void)xmlParserSAX
{
    //设置URL路径
    NSURL *url = [NSURL URLWithString:@"http://localhost/book.xml"];
    
    //新建URL请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //废弃
//    [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    
    //iOS9新推出
    
    //配置会话类型
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建一组会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    //让会话发起请求任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        if(data)
        {
            //初始化XML解析器，传入待解析数据
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
            xmlParser.delegate = self;
            [xmlParser parse];
        }
        else
        {
            NSLog(@"请求失败！获取数据为空！");
        }
    }];
    //执行
    [task resume];
}
/**
 XML 解析方法 使用GDataXML
 */
- (void)xmlParserDOM
{
    
}



/**
 JSON 解析方法 使用NSJSONSerialization
 */
- (void)jsonParserJSONSeria
{
    //设置URL路径
    NSURL *url = [NSURL URLWithString:@"http://localhost/js.json"];
    
    //新建URL请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //废弃
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        //
//    }];
    
    //iOS9新推出
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        if(data)
        {
            
        }
        else
        {
            NSLog(@"获取js数据失败");
        }
    }];
    [task resume];
    
    
    
}
/**
 JSON 解析方法 使用JSONKit
 */
- (void)jsonParserJSONKit
{
    
}


#pragma mark - NSXMLParserDelegate
//扫描到文档开头，解析开始
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"扫描到文档开头");
    //清空数组
    [self.books removeAllObjects];
}

//扫描到元素开始处调用
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    //NSLog(@"扫描到元素%@开始 属性：%@", elementName, attributeDict);
    //有属性的元素在这一步进行处理，没有属性的元素在这一步不做任何事，强行将有属性的元素的属性解析并赋给模型
    if([elementName isEqualToString:@"bookstore"])
    {
        self.bookInfo = [[BookInfo alloc] init];
    }
    
    else if([elementName isEqualToString:@"book"])
    {
        self.bookInfo = [[BookInfo alloc] init];
    }
    else if([elementName isEqualToString:@"category"])
    {
        self.bookInfo.category = attributeDict[@"category"];
    }
    else if ([elementName isEqualToString:@"title"])
    {
        self.bookInfo.title = attributeDict[@"title"];
    }
    else if([elementName isEqualToString:@"lang"])
    {
        self.bookInfo.lang = attributeDict[elementName];
    }
    
    
    
}
//扫描到元素内容处调用
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"扫描到元素%@内容", string);
    //元素内容赋给“哨兵”
    self.content = string;
}
//扫描到元素结束处调用
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"扫描到元素%@结束", elementName);
    if([elementName isEqualToString:@"bookstore"])
    {
        //所有书内容解析完毕
        NSLog(@"bookStore所有节点解析结束");
    }
    else if([elementName isEqualToString:@"book"])
    {
        //一本书所有内容解析完毕，添加到数组内
        [self.books addObject:self.bookInfo];
    }
    else if([elementName isEqualToString:@"title"])
    {
        self.bookInfo.title = self.content;
    }
    else if ([elementName isEqualToString:@"author"])
    {
        self.bookInfo.author = self.content;
    }
    else if([elementName isEqualToString:@"year"])
    {
        self.bookInfo.year = self.content;
    }
    else if([elementName isEqualToString:@"price"])
    {
        self.bookInfo.price = self.content;
    }
    
    
}
//扫描到文档结束，解析完毕
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"扫描到文档结束");
    for(BookInfo *book in self.books)
    {
        NSLog(@"%@", book);
    }
}











@end
