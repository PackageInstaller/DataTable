local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 2,
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

      Actions = {
        {

          PosKey = "npc1",
          Rotation = -70,
          NPCId = 302019,
          NPCName = "接任务居民4",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "npc2",
          Rotation = 200,
          NPCId = 302021,
          NPCName = "蹦跳小孩",
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

          ObjName = "Level/Level_02/320/32002/3200204",
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

      NoPassCamera = 32004,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 32004,
      PassCameraIsNewConfig = true,
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
        },
        {

          PosKey = "npc1",
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

          KeyName = "npc1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Level_02/320/32001/3200102/Rock",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Level_01/320/32001/3200102/Plat/plat_loop",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          Key = "cam0",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 32004,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "cam1-1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 32004,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "cam1-2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 32004,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "cam2-1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 111,
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

          Key = "BrokenPath1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Path = "Level/Level_01/320/32002/3200204/Path/scenetimeline_BrokenPath1",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            },
            {

              Target = "God",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 1.0,
              TimeoutKey = "XHLLELeS"
            },
            {

              ObjName = "Level/Level_01/FX_Sc0101_break_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Level/Level_01/FX_Sc0101_break_1 (1)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Level/Level_01/FX_Sc0101_break_1 (2)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              StoryId = 3220203,
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
              TimeoutKey = "baGPAqbe"
            },
            {

              KeyName = "npc2",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "BrokenPath2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 2220206,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 1.0,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "hero",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "fKJfEkMb"
            },
            {

              Type = 71,
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

          StoryId = 2220205,
          Actions = {
            {

              GroupID = 2,
              Type = 87,
              Timeout = 0.0
            },
            {

              KeyName = "tp1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2220206,
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

              TimelineName = "scene_timeline_320020401",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "suaakmsJ"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 1.0,
              TimeoutKey = "IntHzANW"
            },
            {

              KeyName = "tp1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 1.0,
              TimeoutKey = "zuoROLZP"
            },
            {

              PosKey = "npc3",
              Rotation = 210,
              NPCId = 302022,
              NPCName = "知错小孩",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "SNMVetrK"
            },
            {

              TaskId = 3200208,
              Type = 5,
              Timeout = 1.0,
              TimeoutKey = "ujHKkgZx"
            },
            {

              NPCId = 302021,
              NPCName = "蹦跳小孩",
              Type = 1,
              Timeout = 0.6,
              TimeoutKey = "kAfEmUeI"
            },
            {

              Path = "Level/Level_01/320/32002/3200204/Path/scenetimeline_BrokenPath2",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.5,
              TimeoutKey = "ydOguLEC"
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

          NPCId = 302019,
          Actions = {
            {

              StoryId = 2220205,
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

              Type = 71,
              Timeout = 0.0
            },
            {

              TaskId = 3200207,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302021,
          Actions = empty,
          ValidInTower = false
        },
        {

          NPCId = 302012,
          Actions = {
            {

              ObjName = "Level/Level_02/320/32002/3200204/Path/sc06_nature_07a_pre",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              KeyName = "tp1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
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

          StoryId = 2220206,
          StepId = 20,
          Actions = {
            {

              TimelineName = "scene_timeline_320020401",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              NPCId = 302021,
              NPCName = "蹦跳小孩",
              Type = 1,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_01/320/32002/3200204/Path/scenetimeline_BrokenPath2",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0,
              TimeoutKey = "KNvMUyRE"
            },
            {

              ObjName = "Level/Level_01/FX_Sc0101_break_1 (3)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0,
              TimeoutKey = "vcPXQCym"
            },
            {

              ObjName = "Level/Level_01/FX_Sc0101_break_1 (4)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0,
              TimeoutKey = "nkpDYbTy"
            },
            {

              ObjName = "Level/Level_01/FX_Sc0101_break_1 (5)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0,
              TimeoutKey = "oRMAaZgX"
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