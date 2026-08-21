local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "item1",
          Rotation = 0,
          NPCId = 101205,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "item2",
          Rotation = 0,
          NPCId = 101206,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC1",
          Rotation = 0,
          NPCId = 101107,
          Type = 0,
          Timeout = 0.0
        },
        {

          GroupId = 10130401,
          Type = 27,
          Timeout = 0.0
        },
        {

          StoryId = 101303,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline1_3_GZCSJ",
          Fadein = 0.0,
          Fadeout = 2.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = true,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 104,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 104,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          PlatName = "plat5",
          IsMove = true,
          Anim = "5loop",
          IsAutoSave = false,
          Type = 18,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          PlatName = "plat4",
          IsMove = true,
          Anim = "4loop",
          IsAutoSave = false,
          Type = 18,
          Timeout = 0.0,
          TimeoutKey = "1"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "is_down",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101205,
          Actions = {
            {

              CondId = 2014,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              storyId = 1002003,
              Type = 25,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10118,
              PosKey = "B2",
              Rotation = 180,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              Type = 124,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 101206,
          Actions = {
            {

              CondId = 2014,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              storyId = 1002004,
              Type = 25,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10114,
              PosKey = "item2",
              Rotation = 90,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              Type = 124,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101107,
          Actions = {
            {

              TipsId = 100161,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              PosKey = "NPC1",
              Rotation = 0,
              NPCId = 101107,
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "gKpxjXtK"
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "is_authorized",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101107,
          Actions = {
            {

              PlatName = "plat4",
              IsMove = true,
              Anim = "4loop",
              IsAutoSave = false,
              Type = 18,
              Timeout = 0.0,
              TimeoutKey = "1"
            }
          },
          FinishMarkVariable = "is_down",
          ValidInTower = true
        }
      },
      Type = 6,
      ConditionVariable = "is_authorized",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Type = 12,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline1_3_GZCSJ",
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 9,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10130401,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10130402,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "win",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 3.0,
              TimeoutKey = "zQBXZPFi"
            }
          },
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          descStoryId = 1002003,
          str = "文本剧情id",
          Actions = {
            {

              StoryId = 201314,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          descStoryId = 1002004,
          str = "文本剧情id",
          Actions = {
            {

              StoryId = 201315,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 11,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOX10101",
      Actions = {
        {

          TreasureChestId = 10101,
          PosKey = "BOX1",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10101",
          Type = 124,
          Timeout = 1.5,
          TimeoutKey = "cAdRFYWP"
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.5,
          TimeoutKey = "mhEQdAEu"
        },
        {

          PosKey = "BOX1",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 2.0,
          Type = 62,
          Timeout = 2.5,
          TimeoutKey = "vQJjxBco"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOXEND10101",
      Actions = {
        {

          Variable = "10101",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10101CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10101OPEN",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101_2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101_3",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10101",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10101CLOSE",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101_2",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101_3",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "BOXFIGHT",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 5,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10130404,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "BOX10101",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "10101",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "win",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10101OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "is_authorized",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10101CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 40,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    }
  },
  MonsterRefreshCfg = {
    Weight = 100,
    MonsterLockEnemyCount = 0,
    MonsterGroupId = 0,
    MonsterWave = 0,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0,
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = empty,
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 14,
    MonsterInfo = {
      [ 20101501 ] = 9,
      [ 20104001 ] = 3,
      [ 20104003 ] = 1,
      [ 20101401 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}