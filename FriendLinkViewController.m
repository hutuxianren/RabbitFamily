//
//  FriendLinkViewController.m
//  RabbitFamily
//
//  Created by luluteam on 15/8/24.
//  Copyright (c) 2015年 luluteam. All rights reserved.
//

#import "FriendLinkViewController.h"
#import "FamilyPhotoViewController.h"
@interface FriendLinkViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation FriendLinkViewController
{
    UIActivityIndicatorView *activityIndicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    activityIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    [activityIndicator setCenter:self
     .view.center];
    activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    activityIndicator.hidden=YES;
    self.webView.delegate=self;
    // Do any additional setup after loading the view.
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    activityIndicator.hidden=NO;
    [activityIndicator startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    activityIndicator.hidden=YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"加载网页失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertview show];
}
- (IBAction)zhonghuatushiwangClick:(id)sender {
    NSString *addr=@"http://www.chinatushi.com/";
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:addr]];
    [self.webView loadRequest:request];
}
- (IBAction)jiapushoujuanClick:(id)sender {
    NSString *addr=@"http://pan.baidu.com/disk/home#from=share_pan_logo&path=%252F%25E5%25AE%25B6%25E8%25B0%25B1%25E6%2596%2587%25E6%25A1%25A3";
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:addr]];
    [self.webView loadRequest:request];
}
- (IBAction)tushijixieClick:(id)sender {
    NSString *addr=@"http://tsgcjx.chinapyp.com/";
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:addr]];
    [self.webView loadRequest:request];
    
}
- (IBAction)toFamilyPhotoClick:(id)sender {
    [self performSegueWithIdentifier:@"tofamilyphoto_segue" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"tofamilyphoto_segue"])
    {
        FamilyPhotoViewController *fpVC=[[FamilyPhotoViewController alloc]init];
        fpVC=segue.destinationViewController;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
