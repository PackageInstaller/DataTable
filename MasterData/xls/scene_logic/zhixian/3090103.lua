local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 300707,
          NPCName = "duizhang",
          Type = 0,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Scenemodel/sc02_bld_10u_pre (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level_1/Plat5_",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Path = "Change_/Change_bright/Level_1/TimeLine_309010301",
          PlatCount = 1,
          PlatList = {
            "plat5"
          },
          Type = 96,
          Timeout = 0.1,
          TimeoutKey = "RocnnXHS"
        },
        {

          TimelineName = "scene_timeline_juese_3090102",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
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

          ObjName = "/Root/Change_/Change_bright/Level_3/塔3-石门1",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc02_zone_07/Building/sc02_bld_04a4_pre (3)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc02_zone_07/Building/sc02_bld_02a3_pre (27)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc02_zone_07/Building/sc02_bld_02a4_pre (43)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc02_zone_07/Wall/Wall_box (4)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.0,
          IsWhite = false,
          Type = 59,
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

              KeyName = "M1",
              IsOpen = false,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Z2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              KeyName = "M1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              AreaName = "Z3",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "Z4",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "Z5",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Z3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              KeyName = "M1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              AreaName = "Z2",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "Z4",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "Z5",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Z4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              KeyName = "M1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              AreaName = "Z2",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "Z3",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "Z5",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Z5",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              KeyName = "M1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              AreaName = "Z2",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "Z3",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "Z4",
              RemoveForever = false,
              Type = 9,
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

          StoryId = 2209107,
          Actions = {
            {

              TaskId = 30904,
              Type = 5,
              Timeout = 0.0
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              StoryId = 2209109,
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
              Timeout = 2.5,
              TimeoutKey = "dIewhePA"
            },
            {

              TimelineName = "scene_timeline_juese_3090102",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "zuJukSCX"
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

          StoryId = 2209110,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.5,
              TimeoutKey = "LoZDXQQB"
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
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

          StoryId = 2209109,
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

              ObjName = "/Root/Change_/Change_bright/Scenemodel/sc02_bld_03a1_pre (1)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "jePJIlrb"
            },
            {

              PosKey = "M1",
              Rotation = 0,
              NPCId = 300601,
              NPCName = "npc",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "BOYeUkAc"
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

          NPCId = 300707,
          Actions = {
            {

              StoryId = 2209107,
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

          NPCId = 300601,
          Actions = {
            {

              StoryId = 2209110,
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