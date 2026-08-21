local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Type = 33,
          Timeout = 0.0
        },
        {

          TaskId = 305303,
          Type = 5,
          Timeout = 0.0
        },
        {

          KeyName = "T1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

      NoPassCamera = 30503,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 30503,
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

          Key = "tp2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "tp44",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.5,
              TimeoutKey = "4168894"
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

              StoryId = 3205302,
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
              TimeoutKey = "cvsetrgd"
            }
          },
          ValidInTower = false
        },
        {

          Key = "tp3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "tp11",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.5,
              TimeoutKey = "8491984798"
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

              StoryId = 3205302,
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
              TimeoutKey = "xczAXGFTRS"
            }
          },
          ValidInTower = false
        },
        {

          Key = "tp4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "tp22",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.5,
              TimeoutKey = "84918798"
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

              StoryId = 3205302,
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
              TimeoutKey = "DVSDW3E"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "END",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 6,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 3050304,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "K1",
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

          StoryId = 2205305,
          Actions = {
            {

              ObjName = "LevelObj/305/tp2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "LevelObj/305/tp3",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "LevelObj/305/tp4",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              Direction = 1,
              TpName = "FX_Sc01_door_1",
              Type = 51,
              Timeout = 0.0
            },
            {

              TipsId = 30531,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "END",
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

          NPCId = 3050304,
          Actions = {
            {

              StoryId = 2205305,
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
              MagicId = 305302,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              TimelineName = "30534",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              TimelineName = "305344",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              Type = 22,
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

      EventName = "K1",
      Actions = {
        {

          PosKey = "T1",
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

          PosKey = "T1",
          Rotation = 0,
          NPCId = 3050304,
          Type = 0,
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

      Actions = {
        {

          ObjName = "LevelObj/305/tp1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/305/tp2",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/305/tp3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/305/tp4",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TipsId = 30531,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 305302,
          Type = 103,
          Timeout = 0.0
        },
        {

          TimelineName = "30534",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "305344",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
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
    EventCount = 1,
    MonsterCount = 6,
    MonsterInfo = {
      [ 20101201 ] = 1,
      [ 20101301 ] = 1,
      [ 20101101 ] = 1,
      [ 201055 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}