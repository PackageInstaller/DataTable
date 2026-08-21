local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "TimeLine_313010501",
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

          ObjName = "/Root/Scene/sc02_zone_15/Building/sc02_bld_03a1_pre (37)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc02_zone_15/Building/sc02_bld_02a_pre (256)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc02_zone_15/Prop/sc02_prp_11a_pre (114)",
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

          Key = "done",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

          Key = "Z1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 2213108,
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
      Type = 3,
      ConditionVariable = "done",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2213107,
          Actions = {
            {

              PosKey = "M3",
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

              PosKey = "M3",
              Rotation = 0,
              NPCId = 301305,
              NPCName = "笔记",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "HtNOgpBr"
            },
            {

              Key = "done",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
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

          StoryId = 2213109,
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

              NPC = "Hero",
              Point = "N1",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "oypoxCzc"
            },
            {

              StoryId = 2213110,
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
              Timeout = 2.0,
              TimeoutKey = "HjzJIBId"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2213110,
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

              PosKey = "N2",
              Rotation = 0,
              NPCId = 301304,
              NPCName = "收藏品",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "HOYKTniY"
            },
            {

              NPCId = 301308,
              NPCName = "古代艾弥安",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "ZyhffmqZ"
            },
            {

              TaskId = 31308,
              Type = 5,
              Timeout = 2.0,
              TimeoutKey = "YmGJaaZF"
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

          NPCId = 301308,
          Actions = {
            {

              StoryId = 2213107,
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

          NPCId = 301305,
          Actions = {
            {

              StoryId = 2213109,
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
              Timeout = 0.5,
              TimeoutKey = "HQVAMtRN"
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

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "TimeLine_313010501",
          Actions = {
            {

              PosKey = "M1",
              Rotation = -90,
              NPCId = 301308,
              NPCName = "古代艾弥安",
              Type = 0,
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

          CollectionId = 560211,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.5,
              TimeoutKey = "nJOdMqyJ"
            }
          },
          ValidInTower = false
        }
      },
      Type = 29,
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