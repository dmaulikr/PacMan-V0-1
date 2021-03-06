//
//  SelectLayer.m
//  PacMan-V0-1
//
//  Created by 朱 俊健 on 14-6-6.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "SelectLayer.h"

#import "MyHeader.h"

#import "GameLayer.h"
#import "SettingLayer.h"
#import "GameData.h"

@implementation SelectLayer

+ (CCScene *)Scene
{
    CCScene * scene = [CCScene node];
    
    SelectLayer * selectLayer = [SelectLayer node];
    
    [scene addChild:selectLayer];
    
    return scene;
}


- (id)init
{
    self = [super init];
    if (self) {
        
        CCSprite * background = [[CCSprite alloc] initWithFile:@"Select_Background.png"];
        background.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        [self addChild:background];
        
        NSString * highScore;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"]) {
            highScore = [NSString stringWithFormat:@"%d", [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] intValue]];
        }
        else{
            [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"highScore"];
            highScore = @"0";
        }
        
        CCLabelTTF * score;
        score = [[CCLabelTTF alloc] initWithString:highScore fontName:[GameData sharedData].scoreName fontSize:SCORE_FONTSIZE];
//        [score setColor:[GameData sharedData].scoreColor];
        score.position = CGPointMake(570 / 2, SCREEN_HEIGHT - 20);
        [self addChild:score];
        
        
        CCMenuItemImage * ironBtn = [[CCMenuItemImage alloc] initWithNormalImage:@"Select_IronStyle.png" selectedImage:@"Select_IronStyle_HL.png" disabledImage:nil target:self selector:@selector(onPressIronBtn:)];
        ironBtn.position = CGPointMake(201.5, SCREEN_HEIGHT - 182);
//        [self addChild:ironBtn];
        
        CCMenuItemImage * summerBtn = [[CCMenuItemImage alloc] initWithNormalImage:@"Select_SummerStyle.png" selectedImage:@"Select_SummerStyle_HL.png" disabledImage:nil target:self selector:@selector(onPressSummerBtn:)];
        summerBtn.position = CGPointMake(737 / 2, SCREEN_HEIGHT - 182);
//        [self addChild:summerBtn];
        
        CCMenuItemImage * ironSettingBtn = [[CCMenuItemImage alloc] initWithNormalImage:@"IronStart_Setting.png" selectedImage:@"IronStart_Setting_HL.png" disabledImage:nil target:self selector:@selector(onPressSettingBtn:)];
        ironSettingBtn.position = CGPointMake(22, SCREEN_HEIGHT - 19);
        
        CCMenuItemImage * friendsBtn = [[CCMenuItemImage alloc] initWithNormalImage:@"Select_Friends.png" selectedImage:@"Select_Friends_HL.png" disabledImage:nil target:self selector:@selector(onPressFriendsBtn:)];
        friendsBtn.position = CGPointMake(990 / 2, SCREEN_HEIGHT - 38 / 2);
        
        CCMenu * menu = [CCMenu menuWithItems:ironBtn, summerBtn, ironSettingBtn, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
        
        setLayer = [SettingLayer node];
    }
    return self;
}

- (IBAction)onPressSummerBtn:(id)sender
{
    CCScene * scene = [GameLayer SceneWithStyle:SummerStyle];
    CCTransitionCrossFade * tran = [CCTransitionFadeBL
                                    transitionWithDuration:0.7 scene:scene];
    [[CCDirector sharedDirector] replaceScene:tran];
}

- (IBAction)onPressIronBtn:(id)sender
{
    CCScene * scene = [GameLayer SceneWithStyle:IronStyle];
    CCTransitionCrossFade * tran = [CCTransitionFadeBL
                                    transitionWithDuration:0.7 scene:scene];
    [[CCDirector sharedDirector] replaceScene:tran];
}

- (IBAction)onPressSettingBtn:(id)sender
{
    if ([setLayer parent] != nil) {
        return;
    }
    setLayer = [SettingLayer node];
    
    [self addChild:setLayer];
}

- (IBAction)onPressFriendsBtn:(id)sender
{
    NSLog(@"按下了朋友按钮");
}

@end
