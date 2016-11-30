//
//  ViewController.m
//  TakeVideo
//
//  Created by at on 2016/11/22.
//  Copyright © 2016年 at. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    检测相机是否可用
    
    //配置imaePiccontroller
    
    [self ConfigerController];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)ConfigerController{
    
    UIImagePickerController *controller =[[UIImagePickerController alloc
                                           ]init];
    //设置视频源
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //媒体类型
    NSString *requireType = (__bridge NSString *)kUTTypeMovie;
    controller.mediaTypes =[[NSArray alloc]initWithObjects:requireType, nil];
    
    //委托代理方法
    controller.delegate=self;
    
    //设置拍摄质量
    controller.videoQuality = UIImagePickerControllerQualityTypeHigh;
    //设置拍摄时间
    controller.videoMaximumDuration = 30.0;
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
    
    
}
//点击取消拍摄
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
//录制完成后
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //创建视频播放类
   __block MPMoviePlayerViewController *movieController;
    
    //info 类型 附加信息
    //获取视频的相关信息
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(__bridge NSString*)kUTTypeMovie]) {
    
        NSDictionary *dic=[info objectForKey:UIImagePickerControllerMediaMetadata];
        NSLog(@"附加信息==%@",dic);
        //获取视频的地址
        NSURL *url =[info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"视频地址==%@",url);
        
//        movieController =[[MPMoviePlayerViewController alloc]initWithContentURL:url];
//        //设置播放的缩放比例
//        movieController.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
//        //设置视频控制样式
//        movieController.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
//        //拍摄视频隐藏
//        [picker dismissViewControllerAnimated:YES completion:^{
//           
//            [self presentMoviePlayerViewControllerAnimated:movieController];
//            
//            
//            
//        }];
        
        
        //保存视频
        ALAssetsLibrary *alassLib=[[ALAssetsLibrary alloc]init];
        
        [alassLib writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
           
            if (error == nil) {
                NSLog(@"保存成功");
                
            }else{
                
                NSLog(@"保存失败===%@",error);
            }
            
            
        }];
        
    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
