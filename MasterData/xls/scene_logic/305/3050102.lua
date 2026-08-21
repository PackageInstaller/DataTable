local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 3050103,
          NPCName = "M1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 0,
          NPCId = 3050104,
          NPCName = "M2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M3",
          Rotation = 0,
          NPCId = 3050105,
          NPCName = "M3",
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

      NoPassCamera = 10403,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10403,
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

          ObjName = "Scene/07_DDG/sc01_area_07/Building/sc01_com_07_pre/sc01_com_07_07_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/07_DDG/sc01_area_07/Building/sc01_bld_15a_pre(421)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/07_DDG/sc01_area_07/Building/sc01_bld_15a_pre(422)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/07_DDG/sc01_area_07/Building/sc01_bld_16a_pre(51)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/305/3050102",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/Cube (2)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/07_DDG/sc01_area_07/sc01_com_07_coll_General/sc01_com_07_ground_02",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Target = "1001019",
          MagicId = 4032189,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/07_DDG/sc01_area_07/wall/wall_box_01 (20)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/07_DDG/sc01_area_07/wall/wall_box_01 (21)",
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

          StoryId = 2205105,
          Actions = {
            {

              Target = "God",
              MagicId = 305302,
              Type = 103,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              TimelineName = "tl305121",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "M1",
          ValidInTower = false
        },
        {

          StoryId = 2205106,
          Actions = {
            {

              Target = "God",
              MagicId = 305302,
              Type = 103,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              TimelineName = "tl305122",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "M2",
          ValidInTower = false
        },
        {

          StoryId = 2205107,
          Actions = {
            {

              Target = "God",
              MagicId = 305302,
              Type = 103,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 1,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 3050101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "1",
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

              TimelineName = "tl305123",
              IsPlay = false,
              Type = 110,
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

          StoryId = 2205108,
          Actions = {
            {

              PosKey = "tp4",
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
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              GroupId = 30501,
              Type = 42,
              Timeout = 4.0,
              TimeoutKey = "6128963"
            },
            {

              TipsId = 30501,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 4.0,
              TimeoutKey = "jWwxiBTM"
            }
          },
          FinishMarkVariable = "GUIDE",
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

          NPCId = 3050103,
          Actions = {
            {

              Target = "God",
              MagicId = 305302,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              PosKey = "M1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
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

              StoryId = 2205105,
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

              TimelineName = "tl305121",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 3050104,
          Actions = {
            {

              Target = "God",
              MagicId = 305302,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              PosKey = "M2",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
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

              StoryId = 2205106,
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

              TimelineName = "tl305122",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 3050105,
          Actions = {
            {

              Target = "God",
              MagicId = 305302,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
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

              StoryId = 2205107,
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

              TimelineName = "tl305123",
              IsPlay = true,
              Type = 110,
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

          Type = 12,
          Timeout = 1.0,
          TimeoutKey = "MkeHTpcV"
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

          Target = "1001019",
          MagicId = 30502,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "M3",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          TipsId = 30501,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            "M1",
            "M2",
            "M3"
          },
          Actions = {
            {

              StoryId = 2205108,
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

              TaskId = 305103,
              Type = 5,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "BAD",
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "BAD",
      IsNotCondition = true,
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
    EventCount = 1,
    MonsterCount = 1,
    MonsterInfo = {
      [ 20101101 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}