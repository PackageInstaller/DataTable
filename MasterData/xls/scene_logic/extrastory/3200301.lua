return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "Change_/Change_Day/sc06_area_03/prop/sc06_prop_01_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_Day/sc06_area_03/prop/sc06_prop_01_pre (11)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Level_01/shengjaiti/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Level_01/shengjaiti/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate",
          Visible = true,
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

          PosKey = "npc1",
          Rotation = 90,
          NPCId = 302006,
          NPCName = "害怕的居民",
          Type = 0,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_320030101",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.5,
          Hold = 1.0,
          BlackOut = 0.5,
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

          StoryId = 3220301,
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
          Timeout = 1.0,
          TimeoutKey = "DdEsaxBu"
        },
        {

          CustomEventName = "电梯升起",
          Type = 19,
          Timeout = 2.5,
          TimeoutKey = "oOCFDeZU"
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

          TaskGroupId = 32003,
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

          NPCId = 302013,
          Actions = {
            {

              StoryId = 2220301,
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

              TaskId = 3200301,
              Type = 5,
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

          KeyName = "tp1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
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

      EventName = "电梯升起",
      Actions = {
        {

          PlatName = "Plat1",
          IsMove = true,
          Anim = "Sc06_plat1",
          IsAutoSave = false,
          Type = 18,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "plat",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "plat",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "clear",
      Actions = {
        {

          NPCId = 302006,
          NPCName = "害怕的居民",
          Type = 1,
          Timeout = 1.0,
          TimeoutKey = "EmAxhhTy"
        },
        {

          PosKey = "npc2",
          Rotation = 90,
          NPCId = 302013,
          NPCName = "不害怕的居民",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "ebSNzJTR"
        },
        {

          KeyName = "npc2",
          IsOpen = false,
          IsContinue = false,
          Type = 70,
          Timeout = 1.0,
          TimeoutKey = "CmuFXpls"
        },
        {

          ObjName = "/Root/Level/Level_01/sc06_build_31a_pre (2)/TL_door1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          PosKey = "npc2",
          IsOpen = true,
          CameraStyle = 0,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
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

          TimelineName = "timeline_320030101",
          Actions = {
            {

              CustomEventName = "电梯升起",
              Type = 19,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 4,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 20002,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "clear",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.5,
              TimeoutKey = "yRRDbhbZ"
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

      StoryID = 100220401,
      Actions = {
        {

          StoryId = 100220401,
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
      Type = 37,
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
  FinishiConditionDict = {
    [ 4 ] = {
      StoryId = 2220301,
      Name = "剧情结束"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 4,
    MonsterInfo = {
      [ 20104301 ] = 4
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}