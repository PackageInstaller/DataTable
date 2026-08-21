local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          StoryId = 5060601,
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
          TimeoutKey = "zChhuruz"
        },
        {

          TimelineName = "TL_zhandao",
          Fadein = 0.0,
          Fadeout = 3.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.5,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          TaskGroupId = 1063,
          Type = 21,
          Timeout = 0.0
        },
        {

          ResId = 3001073,
          PosKey = "luoshi",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 4,
          Level = 0,
          NPCName = "大落石",
          AutoSave = true,
          Type = 2,
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

      NoPassCamera = 10640101,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10640101,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
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

          Key = "enemy1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "",
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 10640103,
                    param = 1,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10640104,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              Key = "StopFallenStone",
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
        },
        {

          Key = "TL2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              ObjName = "/Root/Level/Level_01/FX_Sc0101_break_1 (3)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_01/FX_Sc0101_break_1 (4)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_01/FX_Sc0101_break_1 (5)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 10560103,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Level_01/TL_breakpath2",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "TL1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              ObjName = "/Root/Level/Level_01/FX_Sc0101_break_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_01/FX_Sc0101_break_1 (1)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_01/FX_Sc0101_break_1 (2)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Target = "God",
              MagicId = 10560103,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.0,
              TimeoutKey = "aQsmjrtS"
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 1.0,
              TimeoutKey = "njZxVmla"
            },
            {

              StoryId = 5060602,
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

              ResId = 3001072,
              PosKey = "center",
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Rotation = 0,
              Camp = 4,
              Level = 99,
              NPCName = "落石",
              AutoSave = false,
              Type = 2,
              Timeout = 0.0,
              TimeoutKey = "mxjmAjAa"
            },
            {

              Path = "/Root/Level/Level_01/TL_breakpath1",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            },
            {

              PlayBgm = "bgm_chapter6_elite",
              Type = 76,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "TL4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              PlatName = "plat4",
              IsMove = true,
              Anim = "Sc06_plat4",
              IsAutoSave = true,
              Type = 18,
              Timeout = 0.0
            },
            {

              Target = "God",
              MagicId = 1068004,
              Level = 0,
              Type = 16,
              Timeout = 1.9,
              TimeoutKey = "bxOALqyA"
            },
            {

              PosKey = "npc1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 1.0,
              StopLuaScript = true,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 1.0,
              Type = 62,
              Timeout = 0.5,
              TimeoutKey = "OHdEgBLY"
            },
            {

              StoryId = 5060604,
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

              Target = "God",
              MagicId = 1068004,
              Type = 103,
              Timeout = 5.3,
              TimeoutKey = "gEYXyoAI"
            },
            {

              Key = "TL_luoshi_end",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 4.7,
              TimeoutKey = "UYXfmYiO"
            },
            {

              CustomEventName = "1",
              Type = 19,
              Timeout = 6.0,
              TimeoutKey = "joAXCsmR"
            },
            {

              Path = "/Root/Level/Level_01/luoshi/TL_luoshi",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "enemy2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "TL3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              ObjName = "/Root/Level/Level_01/FX_Sc0101_break_1 (6)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_01/FX_Sc0101_break_1 (7)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_01/FX_Sc0101_break_1 (8)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 10560103,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Level_01/TL_breakpath3",
              PlatCount = 0,
              Type = 96,
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

          Key = "cam1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1060451,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "cam2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 10640102,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "cam3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 10640102,
              IsNewConfig = true,
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

          Key = "cam2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 5,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10640101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "monkey",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10640102,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "enter1",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "enter1",
      IsNotCondition = true,
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

      EventName = "1",
      Actions = {
        {

          StoryId = 5060608,
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "luoshi_hit",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "monkey",
      Actions = {
        {

          StoryId = 5060603,
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
          TimeoutKey = "UeuqgftQ"
        }
      },
      ValidInTower = false,
      Type = 9,
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
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 8,
    MonsterInfo = {
      [ 20105201 ] = 1,
      [ 20204901 ] = 7,
      [ 20205001 ] = 4
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}