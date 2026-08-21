local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Camera = 10203,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          CustomEventName = "Enter2",
          Type = 19,
          Timeout = 0.0
        },
        {

          ResId = 20111401,
          PosKey = "M15",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 2,
          Level = 100,
          NPCName = "萨尔维斯",
          AutoSave = true,
          Type = 2,
          Timeout = 0.0
        },
        {

          Key = "201114_TargetPosX",
          SyncValType = 1,
          Value = 189.6557,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "201114_TargetPosY",
          SyncValType = 1,
          Value = -6.000408,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "201114_TargetPosZ",
          SyncValType = 1,
          Value = -54.67278,
          selectIdx = 1,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Target = "萨尔维斯",
          MagicId = 4032188,
          Level = 0,
          Type = 16,
          Timeout = 1.0,
          TimeoutKey = "jRASEjfQ"
        },
        {

          IsOpen = false,
          Type = 79,
          Timeout = 0.0
        },
        {

          Point = 4,
          Type = 109,
          Timeout = 0.0
        },
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Key = "S2ARRIVE",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
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

          ObjName = "/Root/Change_/Change_bright/Level_3/FX_C2_SEWShenji",
          Visible = true,
          IsAutoSave = true,
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

          Key = "henji",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "henji",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "gate2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "gate2",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "gate1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 2021205,
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
              TimeoutKey = "1"
            },
            {

              AreaName = "gate1",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline2-3gate",
              Fadein = 2.0,
              Fadeout = 1.0,
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
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "savedSEWS",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "gate1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TipsId = 10210003,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "savedSEWS",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "gate2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 2021401,
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

              Camera = 10203,
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
      ConditionVariable = "EnemyDead",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2021401,
          Actions = {
            {

              Key = "201114_TargetPosX",
              SyncValType = 1,
              Value = 188.9127,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "201114_TargetPosY",
              SyncValType = 1,
              Value = -9.908325,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "201114_TargetPosZ",
              SyncValType = 1,
              Value = -43.88203,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ResId = 10230101,
              PosKey = "CD1",
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Rotation = 0,
              Camp = 4,
              Level = 99,
              NPCName = "gate",
              AutoSave = false,
              Type = 2,
              Timeout = 0.0
            },
            {

              AreaName = "gate2",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              PosKey = "萨尔维斯",
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
              Timeout = 1.0,
              TimeoutKey = "eeTgHugG"
            },
            {

              Type = 61,
              Timeout = 0.0,
              TimeoutKey = "AlsHcJon"
            },
            {

              Point = "CD1",
              Type = 3,
              Timeout = 0.6,
              TimeoutKey = "fqwFkCsB"
            },
            {

              Type = 14,
              Timeout = 0.0,
              TimeoutKey = "PtnvAHsM"
            },
            {

              Key = "201114_gateTwoSwitch",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
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

              NPC = "Hero",
              Point = "S3",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.5,
              TimeoutKey = "eWeHTbDZ"
            },
            {

              Point = "CD1",
              Type = 3,
              Timeout = 1.6,
              TimeoutKey = "sSiyViDC"
            },
            {

              Camera = 10203,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.75,
              TimeoutKey = "NEsimrLS"
            },
            {

              Key = "S2ARRIVE",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              NPC = "萨尔维斯",
              Point = "S2",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "cWwmdOSL"
            },
            {

              Type = 14,
              Timeout = 2.0,
              TimeoutKey = "AwACixsQ"
            },
            {

              Type = 61,
              Timeout = 2.0,
              TimeoutKey = "csJmvsyz"
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

      EventName = "Enter2",
      Actions = {
        {

          Key = "enter2",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
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
                Id = 10230203,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "EnemyDead",
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

          ObjName = "/Root/Change_/Change_bright/Level_3/塔3-空气墙2",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "enter2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "EnemyDead",
      Actions = {
        {

          KeyName = "S1",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0,
          TimeoutKey = ""
        }
      },
      FinishMarkVariable = "EnemyDead",
      ValidInTower = true,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2021402,
          StepId = 2,
          Actions = {
            {

              Type = 60,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              Camera = 10203,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "JoyzGtfc"
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

      Actions = {
        {

          ObjName = "/Root/Change_/Change_bright/Level_3/FX_C2_SEWShenji",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
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

      Actions = empty,
      ValidInTower = false,
      Type = 21,
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
    [ 1 ] = {
      Name = "1.杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 6,
    MonsterInfo = {
      [ 20103001 ] = 4,
      [ 20102801 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}