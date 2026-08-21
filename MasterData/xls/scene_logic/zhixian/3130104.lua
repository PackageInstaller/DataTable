local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "TimeLine_313010401",
          Fadein = 0.0,
          Fadeout = 1.0,
          IsCanSkip = true,
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

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
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

          PlatName = "plat3",
          IsMove = true,
          Anim = "up",
          IsAutoSave = true,
          Type = 18,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_haze/Scenemodel/sc02_bld_03b1_pre (4)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_haze/Scenemodel/sc02_bld_04a3_pre (4)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_haze/Scenemodel/sc02_bld_02a1_pre (2)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_haze/Wall/Wall_box (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupID = 5,
          Type = 86,
          Timeout = 0.0
        },
        {

          PosKey = "N1",
          Rotation = 0,
          NPCId = 301312,
          NPCName = "阿顿",
          Type = 0,
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

      ConditionActions = {
        {

          StoryId = 2213105,
          Actions = {
            {

              TimelineName = "TimeLine_313010402",
              Fadein = 1.0,
              Fadeout = 1.0,
              IsCanSkip = true,
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
            },
            {

              PosKey = "M2",
              Rotation = 0,
              NPCId = 301201,
              NPCName = "item1",
              Type = 0,
              Timeout = 3.0,
              TimeoutKey = "rWvYlHML"
            },
            {

              PosKey = "M3",
              Rotation = 0,
              NPCId = 301202,
              NPCName = "item2",
              Type = 0,
              Timeout = 2.0,
              TimeoutKey = "jrViZMym"
            },
            {

              PosKey = "M4",
              Rotation = 0,
              NPCId = 301203,
              NPCName = "item3",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "BbeElLHn"
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2213106,
          Actions = {
            {

              StoryId = 2213112,
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

          StoryId = 2213112,
          Actions = {
            {

              PosKey = "tp4",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              NPCId = 301307,
              NPCName = "古代艾弥安",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "RRbzCdbO"
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 1.0,
              TimeoutKey = "tytASFTH"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 1.0,
              TimeoutKey = "HBeoABUB"
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 301307,
          Actions = {
            {

              StoryId = 2213105,
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
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 301201,
          Actions = {
            {

              CondId = 31307,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 301202,
          Actions = {
            {

              CondId = 31307,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 301203,
          Actions = {
            {

              CondId = 31307,
              CondValue = 1,
              Type = 31,
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

          NPCId = 301310,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              GroupId = 1301,
              Type = 27,
              Timeout = 1.0,
              TimeoutKey = "iOCiglZQ"
            },
            {

              PosKey = "N1",
              Rotation = 0,
              NPCId = 301303,
              NPCName = "笔记",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "nMoprYKJ"
            },
            {

              NPCId = 301312,
              NPCName = "阿顿",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "QsvsCuAY"
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

          NPCId = 301303,
          Actions = {
            {

              StoryId = 2213106,
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
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Direction = 4,
          Type = 51,
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

          TimelineName = "TimeLine_313010401",
          Actions = {
            {

              PosKey = "N2",
              Rotation = -90,
              NPCId = 301307,
              NPCName = "古代艾弥安",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "jmXizxgi"
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

          TimelineName = "TimeLine_313010402",
          Actions = {
            {

              TaskId = 31306,
              Type = 5,
              Timeout = 0.0
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

          TaskId = 31307,
          Actions = {
            {

              PosKey = "N1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              PosKey = "N1",
              Rotation = 0,
              NPCId = 301310,
              NPCName = "模型",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "aIrvSETw"
            }
          },
          ValidInTower = false
        }
      },
      Type = 14,
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
    EndPerform = true
  },
  FinishiConditionDict = empty,
  mDefaultStartTime = true,
  mDefaultEndTime = true
}