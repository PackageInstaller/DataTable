local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          FadeIn = 0.0,
          Hold = 0.2,
          FadeOut = 0.1,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          HeroId = 1001024,
          Type = 29,
          Timeout = 0.0
        },
        {

          TaskId = 3290402,
          Type = 5,
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

          StoryId = 2229602,
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
          Timeout = 0.1,
          TimeoutKey = "wHrNciDm"
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

          StoryId = 2229602,
          Actions = {
            {

              Camera = 1,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              CustomEventName = "call",
              Type = 19,
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

      EventName = "win",
      Actions = {
        {

          TimelineName = "timeline_32904_deadlineEscape",
          Fadein = 0.0,
          Fadeout = 1.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.3,
          BeforeHold = 0.5,
          BeforeBlackOut = 0.3,
          IsWhite = false,
          Type = 6,
          Timeout = 1.0,
          TimeoutKey = "IAwagAHg"
        },
        {

          NPC = "Hero",
          Point = "M2",
          Rotate = 156.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.5,
          TimeoutKey = "UpENSzVZ"
        },
        {

          Target = "Hero",
          Type = 37,
          Timeout = 1.5,
          TimeoutKey = "rGVyuKMT"
        },
        {

          TaskId = 3290403,
          Type = 5,
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

      EventName = "call",
      Actions = {
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
                Id = 29413,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "win",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.5,
          TimeoutKey = "cVzGjyFy"
        }
      },
      FinishMarkVariable = "called",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "called",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2229602,
          StepId = 1,
          Actions = {
            {

              ObjName = "/Root/Level/libu_door5/D3_/close",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0,
              TimeoutKey = "HjsMKxWa"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229602,
          StepId = 5,
          Actions = {
            {

              CustomEventName = "call",
              Type = 19,
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

          TimelineName = "timeline_32904_deadlineEscape",
          Actions = {
            {

              StoryId = 2229603,
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
              Timeout = 0.3,
              TimeoutKey = "LjONyuxp"
            },
            {

              HeroId = 1001024,
              Type = 29,
              Timeout = 6.92,
              TimeoutKey = "LNmnkCdQ"
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 7.4,
              TimeoutKey = "GngKupBy"
            },
            {

              ObjName = "/Root/Level/libu_door2/D2_/open",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 6.95,
              TimeoutKey = "eguhtoSt"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 6.5,
              TimeoutKey = "MWKzMjGG"
            },
            {

              TimelineName = "timeline_32904_deadlineEscape",
              Type = 7,
              Timeout = 7.5,
              TimeoutKey = "MgQZbRmz"
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 7.5,
              TimeoutKey = "cPsUYPFw"
            }
          },
          ValidInTower = false
        }
      },
      Type = 32,
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
      Type = 35,
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
    MonsterCount = 1,
    MonsterInfo = {
      [ 20105105 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}