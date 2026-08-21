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

          ObjName = "Level/Level_01/sc06_prop_51_pre (2)/TL_PressPlate",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Level_01/sc06_prop_51_pre (2)/sc06_prop_51_m1/FX_Sc0601_PressurePlate",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupId = 2004,
          Type = 27,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_01_pre10",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_01_pre11",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_01_pre14",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_01_pre15",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Intensity = 0.05,
          Type = 105,
          Timeout = 0.0
        },
        {

          StartDistance = 5.0,
          Type = 123,
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

          ObjName = "Level/Level_02/320/32002/3200201",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Level_01/320",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Level_02/320/32002/3200201/Lamp/1/lamp_glitch",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Level_02/320/32002/3200201/Lamp/2/lamp_glitch",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.75,
          TimeoutKey = "RNzeZhnP"
        },
        {

          ObjName = "Level/Level_02/320/32002/3200201/Lamp/3/lamp_glitch",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.5,
          TimeoutKey = "CYQIplRT"
        },
        {

          ObjName = "Level/Level_02/320/32002/3200201/Lamp/4/lamp_glitch",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 2.5,
          TimeoutKey = "arGGolSf"
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

          StoryId = 2220403,
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

          PosKey = "npc3-1",
          Rotation = 165,
          NPCId = 302023,
          NPCName = "接任务npc",
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

      NoPassCamera = 102,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 102,
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
        },
        {

          KeyName = "npc3-1",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          TaskGroupId = 32004,
          Type = 21,
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

          Key = "dialog",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 2220404,
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 3220401,
          Actions = {
            {

              KeyName = "npc2",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2220401,
          Actions = {
            {

              KeyName = "npc2",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              ObjName = "Level/Level_01/sc06_build_31a_pre (1)/TL_door1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              TaskId = 3200401,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2220405,
          Actions = {
            {

              TaskId = 3200403,
              Type = 5,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = false,
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

          NPCId = 302012,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              StoryId = 2220401,
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

              PosKey = "npc2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.5,
              TimeoutKey = "FBDrxPJJ"
            },
            {

              PosKey = "npc2",
              Rotation = 0,
              NPCId = 302014,
              NPCName = "放置青灯",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "YIiirjtX"
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302014,
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
              Point = "tp",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "oRNzgsyl"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/ElectricBox/1/electricBox_normal",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "FJUfkmgB"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/ElectricBox/1/electricBox_warning",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "JteYSsvg"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/Lamp/1/lamp_normal",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "PeJhnSmP"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/Lamp/1/lamp_glitch",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "vaKdocKT"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/Lamp/2/lamp_normal",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "PGQnGdDe"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/Lamp/2/lamp_glitch",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "GFPnKKag"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/Lamp/3/lamp_normal",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "khFnxmYU"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/Lamp/4/lamp_normal",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "hSDuXtlh"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/Lamp/3/lamp_glitch",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "fFQSeWpM"
            },
            {

              ObjName = "Level/Level_02/320/32002/3200201/Lamp/4/lamp_glitch",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "pYLbkNSx"
            },
            {

              TimelineName = "scene_timeline_320040101",
              IsPlay = true,
              Type = 110,
              Timeout = 1.5,
              TimeoutKey = "LNnSDrJT"
            },
            {

              GroupId = 2013,
              Type = 27,
              Timeout = 1.5,
              TimeoutKey = "FuppIPjn"
            },
            {

              TaskId = 3200402,
              Type = 5,
              Timeout = 1.0,
              TimeoutKey = "HQlPIMtR"
            },
            {

              NPCId = 302023,
              NPCName = "接任务居民",
              Type = 1,
              Timeout = 11.0,
              TimeoutKey = "CcOXfuYW"
            },
            {

              PosKey = "npc3-2",
              Rotation = 165,
              NPCId = 302024,
              NPCName = "交任务npc",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "ZOMjDWTz"
            },
            {

              KeyName = "npc3-2",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 2.5,
              TimeoutKey = "AfjltbhH"
            },
            {

              Group = 2004,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "MNebKEHA"
            },
            {

              Target = "Hero",
              MagicId = 3001064002,
              Type = 103,
              Timeout = 1.2,
              TimeoutKey = "zYaiSweP"
            },
            {

              Target = "Hero",
              MagicId = 3001064003,
              Type = 103,
              Timeout = 1.2,
              TimeoutKey = "QGzYZYgd"
            },
            {

              Target = "Hero",
              MagicId = 3001064008,
              Type = 103,
              Timeout = 1.2,
              TimeoutKey = "YrkNYuBZ"
            },
            {

              Target = "Hero",
              MagicId = 3001064009,
              Type = 103,
              Timeout = 1.2,
              TimeoutKey = "ILrFZLri"
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302023,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              StoryId = 2220401,
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

              PosKey = "npc2",
              Rotation = 0,
              NPCId = 302014,
              NPCName = "放置青灯",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "mAOBrtEw"
            },
            {

              PosKey = "npc2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.5,
              TimeoutKey = "WsQmyfen"
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 302024,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              StoryId = 2220405,
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