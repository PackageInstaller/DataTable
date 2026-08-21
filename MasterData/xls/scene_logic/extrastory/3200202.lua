local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "npc1",
          Rotation = -75,
          NPCId = 302004,
          NPCName = "接任务居民2",
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

      Actions = {
        {

          ObjName = "Level/Level_02/320/32002/3200202",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      Actions = {
        {

          ObjName = "Change_/Change_Day/sc06_area_03/prop",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_03/sc06_area_03b/prop/sc06_prop_26b_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_03/sc06_area_03b/scenes_rock_02/scenes_rock_02g_pre0",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      NoPassCamera = 113,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 113,
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

          Key = "cancel_born_skill",
          SyncValType = 2,
          Value = true,
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

          Key = "cmrTrigger",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 116,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
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

          Key = "cmrTrigger",
          Actions = {
            {

              Camera = 113,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2220203,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              PosKey = "interact",
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
              Timeout = 0.0
            },
            {

              PosKey = "interact",
              Rotation = 0,
              NPCId = 302012,
              NPCName = "水井交互",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "NhaBiGfb"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2220204,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              KeyName = "tp1",
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

          NPCId = 302004,
          Actions = {
            {

              StoryId = 2220203,
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

              TaskId = 3200204,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302012,
          Actions = {
            {

              ObjName = "Level/Level_01/sc06_build_40_pre/TL_WaterWell",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 3.0,
              TimeoutKey = "yWZVFFUw"
            },
            {

              ObjName = "/Root/Level/Level_02/320/32002/3200202/Water/sc06_prop_31d_pre/scenes_nature_15b_pre (1)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 4.0,
              TimeoutKey = "QcszpWVI"
            },
            {

              NPCId = 302004,
              NPCName = "接任务居民2",
              Type = 1,
              Timeout = 4.0,
              TimeoutKey = "XjJdWYCX"
            },
            {

              PosKey = "npc1",
              Rotation = 180,
              NPCId = 302005,
              NPCName = "交任务居民2",
              Type = 0,
              Timeout = 4.0,
              TimeoutKey = "FgUPbgRs"
            },
            {

              TaskId = 3200205,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302005,
          Actions = {
            {

              StoryId = 2220204,
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

              TaskId = 3200206,
              Type = 5,
              Timeout = 0.0
            },
            {

              Point = "npc1",
              Type = 3,
              Timeout = 0.5,
              TimeoutKey = "wvHMSEVJ"
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

          Direction = 1,
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

          StoryId = 2220203,
          StepId = 1,
          Actions = {
            {

              PosKey = "focus2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2220203,
          StepId = 2,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2220204,
          StepId = 1,
          Actions = {
            {

              PosKey = "focus2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
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