//
//  TableViewController.m
//  XMLOrJSON
//
//  Created by Mengying Xu on 14-11-5.
//  Copyright (c) 2014年 Crystal Xu. All rights reserved.
//

#import "TableViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "Model.h"
#import "JSONKit.h"//将字典转换成json
#import "DDXMLDocument.h"
#import "TFHpple.h"

@interface TableViewController ()<NSXMLParserDelegate>
{
    NSString *Cdata;
    NSString *currentText;
    NSMutableDictionary *dic;
}
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,copy)NSString *currentElement;

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"xml"];
    
    NSString *stringXml = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    switch (self.selectRow) {
        case 1:
        {
            //=================================== xml
//            [self xmlRequest];
            [self xmlByios:[stringXml dataUsingEncoding:NSUTF8StringEncoding]];
        }
            break;
        case 2:
        {
            //=================================== xml
//            [self xmlRequest];
            [self kissXML:stringXml];
        }
            break;

        case 3:
        {
            //=================================== json
//            [self jsonRequest];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"json"];
            
            NSString *stringJson = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            [self jsonJieXiByIos:[stringJson dataUsingEncoding:NSUTF8StringEncoding]];
        }
            break;
        case 4:
        {
            //=================================== json
            //            [self jsonRequest];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"json"];
            
            NSString *stringJson = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            [self jsonKit:stringJson];
        }
            break;
        case 5:
        {
            //=================================== json
            //            [self jsonRequest];
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"html"];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"html"];

            NSString *stringJson = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            [self htmlByHpple:stringJson];
        }
            break;
        default:
            break;
    }

}
/*
- (void)requestSuccess:(AFHTTPRequestOperation*)op WithObj:(id)responseObject
{
    
    NSData *data = (NSData*)responseObject;
    
    NSString *str = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
//    NSLog(@"请求成功: %@",str);
    switch (self.selectRow) {
        case 1:
        {
            //系统自带解析xml
            [self xmlByios:data];
        }
            break;
        case 2:
        {
            //KissXML
            [self kissXML:str];
        }
            break;
            
        case 3:
        {
            //系统自带解析json
            [self jsonJieXiByIos:data];
        }
            break;
            
            
        default:
            break;
    }
 
}
- (void)requestFail:(AFHTTPRequestOperation*)op WithObj:(NSError*)err
{
    NSLog(@"请求失败： %@",err);
}
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableView DataSource And Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sfagv"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sfagv"];

    }

    switch (self.selectRow) {
        case 1:
        {
            //    ============================= NSXMLPraser
            Model *del = [[Model alloc] init];
            NSDictionary *dd = [self.dataArr objectAtIndex:indexPath.row];
            [del encodeFromDic:dd];
            cell.textLabel.text = del.aa ;
        }
            break;
        case 2:
        {
            //    ============================= KissXML
            cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row] ;
        }
            break;
            
        case 3:
        {
            //    ============================= json
            cell.textLabel.text = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"a"];
        }
            break;
        case 4:
        {
            //    ============================= json
            cell.textLabel.text = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"b"];
        }
            break;
        case 5:
        {
            //    ============================= json
            cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row] ;
        }
            break;

        default:
            break;
    }

   
    
    return cell;
}
#pragma mark -使用Hpple解析HTML
- (void)htmlByHpple:(NSString*)htmlStr
{
    TFHpple *html = [[TFHpple alloc] initWithHTMLData:[htmlStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *arr = [html searchWithXPathQuery:@"//img"];
    
    for(int i=0; i < [arr count]; i++)
    {
        TFHppleElement *aE = [arr objectAtIndex:i];
        NSDictionary *dicHtml = [aE attributes];

        NSString *str = [dicHtml objectForKey:@"src"];
        if(str)
        {
            [_dataArr addObject:str];
            
        }

    }

/*    NSArray *arr = [html searchWithXPathQuery:@"//a"];
    
    NSLog(@"arr: %@",arr);
    
    for(int i=0; i < [arr count]; i++)
    {
        TFHppleElement *aE = [arr objectAtIndex:i];
        NSArray *aArr = [aE children];
        
        for(int j=0; j < [aArr count]; j++)
        {
            TFHppleElement *aaE = [aArr objectAtIndex:j];
            
            NSDictionary *dicHtml = [aaE attributes];
            
            NSString *str = [dicHtml objectForKey:@"title"];
            
            if(str)
            {
                [_dataArr addObject:str];

            }
            else
            {
                NSString *str2 = aaE.content;
                if(str2)
                {
                    [_dataArr addObject:str2];
                    
                }

            }
        }
    }
    */
    [self.tableView reloadData];
}

//如果解析的网页不是utf8编码，如gbk编码，可以先将其转换为utf8编码再对其进行解析

-(NSData *) toUTF8:(NSData *)sourceData
{
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [sourceData bytes], [sourceData length], kCFStringEncodingGB_18030_2000, false);
    
    if(gbkStr == NULL)
    {
        return nil;
    }
    else
    {
        NSString *gbkString = (__bridge NSString*)gbkStr;
        //根据网页源代码中编码方式进行修改，此处为从gbk转换为utf8
        NSString *utf8_String = [gbkString stringByReplacingOccurrencesOfString:@"META http-equiv=\"Content-Type\" content=\"text/html; charset=GBK\""
                                                                     withString:@"META http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\""];
        
        return [utf8_String dataUsingEncoding:NSUTF8StringEncoding];
    }
    
}
#pragma mark -使用JSONKit解析器
- (void)jsonKit:(NSString*)jsonStr
{
    NSDictionary *dicjson = [jsonStr objectFromJSONStringWithParseOptions:JKParseOptionNone];
    
    NSArray *rows = [dicjson objectForKey:@"rows"];

    [_dataArr addObjectsFromArray:rows];

    [self.tableView reloadData];

}
#pragma mark -使用系统自带json解析器
/*- (void)jsonRequest
{
//=================================== json

    NSMutableDictionary *dicpost = [[NSMutableDictionary alloc] init];
    [dicpost setObject:@"50" forKey:@"ROWS"];
    [dicpost setObject:@"PUBLISH_DATE" forKey:@"SIDX"];
    [dicpost setObject:@"1" forKey:@"PAGE"];
    [dicpost setObject:@"desc" forKey:@"SORD"];
    
    AFHTTPRequestOperationManager *manage = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://221.229.120.27:8699/"]];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    
    //初始化网络请求
    NSString *xmlString = [dicpost JSONString];
    NSURL *url = [NSURL URLWithString:[[NSURL URLWithString:@"OAGetArticalList.do" relativeToURL: [NSURL URLWithString:@"http://221.229.120.27:8699/"]] absoluteString]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.allowsCellularAccess = manage.requestSerializer.allowsCellularAccess;
    request.cachePolicy = manage.requestSerializer.cachePolicy;
    request.HTTPShouldHandleCookies = manage.requestSerializer.HTTPShouldHandleCookies;
    request.HTTPShouldUsePipelining = manage.requestSerializer.HTTPShouldUsePipelining;
    request.networkServiceType = manage.requestSerializer.networkServiceType;
    request.timeoutInterval = manage.requestSerializer.timeoutInterval;
    
    //定义header
    request.HTTPMethod = @"POST";
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gbk" forHTTPHeaderField:@"charset"];
    //定义body
    [request setHTTPBody:[xmlString dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
    
    NSLog(@"xmlString: %@",xmlString);
    AFHTTPRequestOperation *op =  [manage HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self requestSuccess:operation WithObj:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self requestFail:operation WithObj:error];
    }];
    [op start];
}*/
- (void)jsonJieXiByIos:(NSData*)data
{
    NSError *parseError = nil;
    
    NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
    
    if(parseError)
    {
        NSLog(@"parseError: %@", parseError);
        
    }
    
    self.dataArr = [dic2 objectForKey:@"rows"];
    
    [self.tableView reloadData];
    NSLog(@"请求成功dic2: %@",dic2);
    
}
#pragma mark -使用系统自带xml解析器
/*
- (void)xmlRequest
{
//    ===================================    xml
    NSMutableDictionary *dicpost = [[NSMutableDictionary alloc] init];

    [dicpost setObject:@"01" forKey:@"HealthCategoryID"];
    [dicpost setObject:@"1" forKey:@"PageNum"];
    [dicpost setObject:@"10" forKey:@"PageSize"];
    
    AFHTTPRequestOperationManager *manage = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://221.229.120.27:8699/"]];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];

    AFHTTPRequestOperation *op = [manage GET:@"http://221.229.120.27:8699/GetHealthPediaArticleList.do"
          parameters:dicpost
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [self requestSuccess:operation WithObj:responseObject];
                 
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [self requestFail:operation WithObj:error];
                 
             }];
    NSLog(@"op: %@",op);
}
- (NSString*)mime:(NSURLRequest*)req
{
    NSURLResponse *response;
    
    [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];
    
    return [response MIMEType];
}*/
#pragma mark -使用KissXML解析器
- (void)kissXML:(NSString*)xmlString
{
    //開始使用KissXML，將讀出的XML字串指定給DDXMLDocument物件
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    //開始解析
    NSArray *children = xmlDoc.rootElement.children;
    
    for(int i=0; i < [children count]; i++)
    {
        DDXMLNode *child = [children objectAtIndex:i];
        
        if([child.name isEqualToString:@"ResultCode"])
        {
            NSLog(@"ResultCode：%@", [child stringValue]);

        }
        else if([child.name isEqualToString:@"PageNum"])
        {
            NSLog(@"PageNum：%@", [child stringValue]);

        }
        else if([child.name isEqualToString:@"TotalPage"])
        {
            NSLog(@"TotalPage：%@", [child stringValue]);
            
        }
        else if([child.name isEqualToString:@"Alist"])
        {
            
            NSArray *childrenList = [child children];
            
            for(int j=0; j < [childrenList count]; j++)
            {
                DDXMLNode *childrenArticle = [childrenList objectAtIndex:j];
                
//                [child nodesForXPath:@"HealthPediaArticle" error:nil];

                NSArray *aaChild = [childrenArticle children];

                for(int m=0; m < [aaChild count]; m++)
                {
                    DDXMLNode *aChild = [aaChild objectAtIndex:m];
                    
//                    Model *model = [[Model alloc] init];
//                    
//                    [model encodeFromDic:aChild];
//                    [_dataArr addObject:model];
                    if([aChild.name isEqualToString:@"aa"])
                    {
                        NSLog(@"aa：%@", [aChild stringValue]);
                    }
                    else if([aChild.name isEqualToString:@"b"])
                    {
                        NSLog(@"b：%@", [aChild stringValue]);
                        [_dataArr addObject:[aChild stringValue]];
                        
                    }
                    else if([aChild.name isEqualToString:@"c"])
                    {
                        NSLog(@"c：%@", [aChild stringValue]);
                        
                    }
                    else if([aChild.name isEqualToString:@"d"])
                    {
                        NSLog(@"d：%@", [aChild stringValue]);
                        
                    }
                }
            }
        }
    }

    [self.tableView reloadData];
}

#pragma mark -使用系统自带xml解析器
- (void)xmlByios:(NSData*)data
{
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    
    [xmlParser setDelegate:self];
    
    BOOL flag = [xmlParser parse]; //开始解析
    if(flag) {
        NSLog(@"解析xml成功");
    }else{
        NSLog(@"解析xml失败");
    }
}
//开始解析前，在这里可以做一些初始化工作
// 假设已声明有实例变量 dataDict，parserObject
- (void)parserDidStartDocument:(NSXMLParser *)parser;
{
    NSLog(@"parser： %@",parser);
}

//当解析器对象遇到xml的开始标记时，调用这个方法。
//获得结点头的值
//解析到一个开始tag，开始tag中可能会有properpies，例如<book catalog="Programming">
//所有的属性都存储在attributeDict中
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if([elementName isEqualToString:@"list"])
    {
        NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
        
        dic = d;
        
        [self.dataArr addObject:d];
    }
    else  if([elementName isEqualToString:@"ResultCode"])
    {
        
    }
    else  if([elementName isEqualToString:@"PageNum"])
    {
        
    }
    else  if([elementName isEqualToString:@"TotalPage"])
    {
        
    }
    else if (dic)
    {
        NSMutableString *str = [[NSMutableString alloc] initWithCapacity:0];
        
        [dic setObject:str forKey:elementName];
        self.currentElement = elementName;
    }
}

//当解析器找到开始标记和结束标记之间的字符时，调用这个方法。
//解析器，从两个结点之间读取具体内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //记录所取得的文字列
    //    NSLog(@"string： %@",string);
    currentText = string;
    
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    
    Cdata =[[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    
    NSLog(@"cData:%@",[NSString stringWithUTF8String:[CDATABlock bytes]]);
}
//当解析器对象遇到xml的结束标记时，调用这个方法。
//获取结点结尾的值，此处为一Tag的完成
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if([elementName isEqualToString:@"list"])
    {
        
        dic = nil;
        
    }
    else
    {
        
        if([elementName isEqualToString:@"ResultCode"] || [elementName isEqualToString:@"PageNum"]|| [elementName isEqualToString:@"TotalPage"])
        {
            //            [self.dic setObject:Cdata?Cdata:@"wu" forKey:elementName];
            
        }
        else if([elementName isEqualToString:self.currentElement])
        {
            [dic setObject:currentText?currentText:@" w" forKey:elementName];
            
        }
        
    }
    
}

//xml解析结束后的一些操作可在此
- (void)parserDidEndDocument:(NSXMLParser *)parser {

    [self.tableView reloadData];
}


@end
