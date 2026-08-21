local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M3",
          Rotation = 0,
          NPCId = 301201,
          NPCName = "怪物",
          Type = 0,
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

      NoPassCamera = 10401,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10401,
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

          PlatName = "plat1",
          IsMove = false,
          Anim = "loop",
          IsAutoSave = false,
          Type = 18,
          Timeout = 0.0
        },
        {

          PlatName = "plat2",
          IsMove = false,
          Anim = "2down",
          IsAutoSave = false,
          Type = 18,
          Timeout = 0.0
        },
        {

          GroupId = 1101,
          Type = 27,
          Timeout = 0.0
        },
        {

          Target = "1_1101_0",
          MagicId = 3012101011,
          Level = 0,
          Type = 16,
          Timeout = 0.5,
          TimeoutKey = "oPltRjAJ"
        },
        {

          Target = "1_1101_0",
          MagicId = 3012101012,
          Level = 0,
          Type = 16,
          Timeout = 0.6,
          TimeoutKey = "MaMNDFiC"
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/Fx_Pickable",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "Scene_timeline_312010601",
          IsPlay = true,
          Type = 110,
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
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "M3",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 3.0,
              Type = 62,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2212114,
          Actions = {
            {

              Group = 1101,
              Type = 65,
              Timeout = 0.0
            },
            {

              GroupId = 1102,
              Type = 27,
              Timeout = 0.0
            },
            {

              PosKey = "M1",
              Rotation = 0,
              NPCId = 301205,
              NPCName = "抽气机",
              Type = 0,
              Timeout = 0.0
            },
            {

              Target = "1_1102_0",
              MagicId = 3012101011,
              Level = 0,
              Type = 16,
              Timeout = 0.5,
              TimeoutKey = "NFoRtTnr"
            },
            {

              Target = "1_1102_0",
              MagicId = 3012101012,
              Level = 0,
              Type = 16,
              Timeout = 0.6,
              TimeoutKey = "lIfEzJDS"
            },
            {

              Target = "1_1102_0",
              MagicId = 3012101013,
              Level = 0,
              Type = 16,
              Timeout = 0.7,
              TimeoutKey = "EsoZKIMT"
            },
            {

              Target = "1_1102_0",
              MagicId = 3010101012,
              Level = 0,
              Type = 16,
              Timeout = 0.7,
              TimeoutKey = "vNOkzNyv"
            },
            {

              TaskId = 31205,
              Type = 5,
              Timeout = 1.0,
              TimeoutKey = "xcrVvyjj"
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

          StoryId = 2212115,
          Actions = {
            {

              Group = 1102,
              Type = 65,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              TaskId = 31206,
              Type = 5,
              Timeout = 0.0,
              TimeoutKey = "GssmxjNe"
            },
            {

              PosKey = "M1",
              Rotation = 0,
              NPCId = 301209,
              NPCName = "收藏品",
              Type = 0,
              Timeout = 0.0,
              TimeoutKey = "gcWDGqvr"
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

          NPCId = 301201,
          Actions = {
            {

              StoryId = 2212114,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 1.0,
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

          NPCId = 301205,
          Actions = {
            {

              StoryId = 2212115,
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
              Timeout = 6.0,
              TimeoutKey = "ZvOsTSfa"
            },
            {

              PosKey = "M2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 5.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 5.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 4.5,
              TimeoutKey = "MsVcTDAW"
            },
            {

              Group = 1102,
              Type = 65,
              Timeout = 5.0,
              TimeoutKey = "cbgXgtBH"
            },
            {

              PosKey = "M1",
              Rotation = 0,
              NPCId = 301209,
              NPCName = "收藏品",
              Type = 0,
              Timeout = 5.0,
              TimeoutKey = "JMGvBsRQ"
            },
            {

              PosKey = "M4",
              Rotation = 45,
              NPCId = 301213,
              NPCName = "表演怪",
              Type = 0,
              Timeout = 5.0,
              TimeoutKey = "EFoKbxjX"
            },
            {

              TimelineName = "Scene_timeline_312010602",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              TimelineName = "Scene_timeline_312010601",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
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

          CollectionId = 560106,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.5,
              TimeoutKey = "UhRvhYUc"
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