local empty = {}
return
{
  Events = {
    {

      StoryID = 1001080601,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 1001080601,
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
    },
    {

      Actions = {
        {

          GroupId = 10804101,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "vigilador",
          Rotation = 180,
          NPCId = 10804101,
          NPCName = "监视者",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          Rotation = 180,
          NPCId = 10804102,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 0,
          NPCId = 10804103,
          NPCName = "2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M3",
          Rotation = 180,
          NPCId = 10804104,
          NPCName = "3",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M4",
          Rotation = 0,
          NPCId = 10804105,
          NPCName = "4",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M5",
          Rotation = 90,
          NPCId = 10804106,
          NPCName = "5",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M6",
          Rotation = -90,
          NPCId = 10804107,
          NPCName = "6",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Cheat1",
          Rotation = 45,
          NPCId = 10804108,
          NPCName = "假人群1",
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

      NoPassCamera = 1,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
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

          TaskGroupId = 10804,
          Type = 21,
          Timeout = 0.0
        },
        {

          StoryId = 4080601,
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
          TimeoutKey = "kCNLUEpd"
        },
        {

          Target = "Hero",
          MagicId = 1080401,
          Level = 1,
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

          Key = "vigilancia",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Target = "Hero",
              MagicId = 1080410302,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410901,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "aBGGzdVf"
            },
            {

              Target = "Hero",
              MagicId = 1080410301,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "KcfGHeQH"
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

          Key = "vigilancia",
          Actions = {
            {

              Target = "Hero",
              MagicId = 1080410901,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410301,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410302,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410201,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410202,
              Type = 103,
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

          Key = "estatua",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 4080602,
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

              PosKey = "look",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 1,
              OTSDuration = -1.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              Point = "look",
              Type = 3,
              Timeout = 0.0,
              TimeoutKey = "iMOGqVBS"
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

          StoryId = 4080601,
          StepId = 0,
          Actions = {
            {

              PosKey = "vigiladorCmr",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 1,
              OTSDuration = -1.0,
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
    },
    {

      ConditionActions = {
        {

          StoryId = 4080601,
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

              GroupId = 10804,
              Type = 42,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080602,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
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

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 35,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "found",
      Actions = {
        {

          Key = "gameOver",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1080410901,
          Type = 103,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1080410301,
          Type = 103,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1080410302,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_10804_vigilador1",
          Fadein = 1.0,
          Fadeout = 0.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = false,
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
        },
        {

          NPCId = 10804101,
          NPCName = "监视者",
          Type = 1,
          Timeout = 0.0
        },
        {

          StoryId = 4080613,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.0,
          PlayStayTime = 0.0,
          PlayFadeOutTime = 0.0,
          StopFadeInTime = 0.3,
          StopStayTime = 1.0,
          StopFadeOutTime = 0.3,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 1.0,
          TimeoutKey = "CFZRdGdC"
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

          StoryId = 4080613,
          Actions = {
            {

              NPC = "Hero",
              Point = "bornpoint",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.5,
              TimeoutKey = "oEFQhMuU"
            },
            {

              Target = "Hero",
              MagicId = 1080410201,
              Type = 103,
              Timeout = 0.5,
              TimeoutKey = "MWMhgics"
            },
            {

              Target = "Hero",
              MagicId = 1080410202,
              Type = 103,
              Timeout = 0.5,
              TimeoutKey = "HhCBZaBJ"
            },
            {

              TimelineName = "timeline_10804_vigilador1",
              Type = 7,
              Timeout = 0.5,
              TimeoutKey = "SkmXAGrV"
            },
            {

              Target = "Hero",
              MagicId = 1080410302,
              Type = 103,
              Timeout = 0.6,
              TimeoutKey = "cKBEtmUP"
            },
            {

              PosKey = "vigilador",
              Rotation = 180,
              NPCId = 10804101,
              NPCName = "监视者",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "QGUKdVfv"
            },
            {

              Key = "gameOver",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 1.1,
              TimeoutKey = "jFKQzDJx"
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

      Actions = {
        {

          TaskId = 1080401,
          Type = 5,
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}