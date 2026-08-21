local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          GroupId = 106402,
          Type = 27,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          StoryId = 5060605,
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
          TimeoutKey = "oObIWPUp"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 1060451,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1060451,
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
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                ActionTag = "1",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10640201,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                ActionTag = "2",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10640202,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 2.0,
              TimeoutKey = "DBnycJsb"
            },
            {

              PosKey = "M1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              PosKey = "M5",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 2.5,
              TimeoutKey = "nKrzeQJQ"
            },
            {

              StoryId = 5060606,
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
              TimeoutKey = "OEuOOmBX"
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

          StoryId = 5060607,
          Actions = {
            {

              TimelineName = "TIMELINE6_1_1_0",
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
              BeforeBlackIn = 0.5,
              BeforeHold = 1.0,
              BeforeBlackOut = 0.5,
              IsWhite = false,
              Type = 6,
              Timeout = 2.0,
              TimeoutKey = "BKqsIrrb"
            },
            {

              ChangeTime = 0.0,
              Type = 75,
              Timeout = 2.0,
              TimeoutKey = "WntlHsab"
            },
            {

              Type = 69,
              Timeout = 2.75,
              TimeoutKey = "VBUWRMnW"
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 3.0,
              TimeoutKey = "BSbDxEFF"
            },
            {

              Group = 106402,
              Type = 65,
              Timeout = 2.75,
              TimeoutKey = "IbyjWqch"
            },
            {

              TaskId = 106301,
              Type = 5,
              Timeout = 2.0,
              TimeoutKey = "dBkPdzqI"
            },
            {

              Variable = "finished",
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 30,
              Timeout = 2.0,
              TimeoutKey = "ITCpTknj"
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

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          GroupId = 1060401,
          Actions = {
            {

              StoryId = 5060609,
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
              TimeoutKey = "dfvqookP"
            }
          },
          ValidInTower = false
        }
      },
      Type = 8,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear1",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 3,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10640201,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear1",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "finished",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "clear2",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 3,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10640202,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "finished",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "finish",
      Actions = {
        {

          StoryId = 1001060602,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = false,
          IsSettleStory = true,
          Type = 10,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          Type = 37,
          Timeout = 0.75,
          TimeoutKey = "gdOAbVNl"
        },
        {

          ChangeTime = 0.0,
          Type = 75,
          Timeout = 0.0
        },
        {

          Group = 106402,
          Type = 65,
          Timeout = 0.75,
          TimeoutKey = "DsRBBbjT"
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

          TimelineName = "TIMELINE6_1_1_0",
          Actions = {
            {

              PlayBgm = "bgm_chapter6_elite",
              Type = 76,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0,
              TimeoutKey = "UqDaWYKt"
            },
            {

              Pos = 3,
              SavePos = 0,
              IsGoOut = true,
              Type = 78,
              Timeout = 0.0,
              TimeoutKey = "CDpUgepj"
            },
            {

              HeroId = 1001022,
              Type = 29,
              Timeout = 0.1,
              TimeoutKey = "LZIPguEp"
            },
            {

              NPC = "Hero",
              Point = "hero",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.25,
              TimeoutKey = "CMhhpnbk"
            },
            {

              Tips = "958",
              Duration = 3.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.5,
              TimeoutKey = "tDLAlGIz"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 9,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 10640203,
                    param = 2,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10640204,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "finish",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0,
              TimeoutKey = "gxDlDSKf"
            },
            {

              GroupId = 106402,
              Type = 27,
              Timeout = 0.0
            },
            {

              Target = "1001022",
              MagicId = 4032992,
              Level = 0,
              Type = 16,
              Timeout = 0.5,
              TimeoutKey = "FUMIQnMz"
            },
            {

              GroupId = 1060401,
              Type = 42,
              Timeout = 1.0,
              TimeoutKey = "qAZKXZux"
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

      ConditionActions = {
        {

          ActionTagMap = {
            [ 1 ] = "1",
            [ 2 ] = "2"
          },
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10640201,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "clear1",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10640202,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "clear2",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              StoryId = 5060607,
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
          FinishMarkVariable = "first",
          ValidInTower = false
        }
      },
      Type = 28,
      ConditionVariable = "first",
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
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 1001060602,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 7,
    MonsterCount = 27,
    MonsterInfo = {
      [ 20205001 ] = 25,
      [ 20105001 ] = 8
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}