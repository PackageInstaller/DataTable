local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 10003,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10003,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Key = "story1304",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          Type = 38,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1000101,
          Level = 0,
          Type = 16,
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4100104,
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

          TimelineName = "timeline_100401",
          Fadein = 0.0,
          Fadeout = 1.25,
          IsCanSkip = false,
          NotPauseLua = true,
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
          Timeout = 0.75,
          TimeoutKey = "qyVYrZHs"
        },
        {

          BackToDefault = false,
          Type = 63,
          Timeout = 3.0,
          TimeoutKey = "NiGlEyPQ"
        },
        {

          Camera = 20104601,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.5,
          TimeoutKey = "VNhaPsep"
        },
        {

          Key = "boss",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StoryId = 1000010,
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
          TimeoutKey = "GvWXaGVM"
        },
        {

          PlayBgm = "storybgm_045",
          Type = 76,
          Timeout = 0.0
        },
        {

          CustomEventName = "挂闪避引导脚本",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "SkwDriuu"
        },
        {

          Camera = 10003,
          IsNewConfig = true,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 1.0,
          TimeoutKey = "CkjXlhkq"
        },
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 403210033,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill2",
          IsShow = false,
          Type = 32,
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

          StoryId = 1000010,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 1000006,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
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

          GroupId = 11333,
          Actions = {
            {

              Type = 22,
              Timeout = 0.0
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

      EventName = "1",
      Actions = {
        {

          Target = "Hero",
          Type = 37,
          Timeout = 2.5,
          TimeoutKey = "sdasdsdxcx"
        },
        {

          Target = "0_4100104_0",
          Type = 37,
          Timeout = 2.0,
          TimeoutKey = "cawefe"
        },
        {

          ChangeTime = 0.0,
          Type = 75,
          Timeout = 1.5,
          TimeoutKey = "anfnhHxR"
        },
        {

          TimelineName = "TIMELINE0_3_1_0",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.3,
          Hold = 0.5,
          BlackOut = 0.5,
          IsShowUI = false,
          DelayDestroy = true,
          BeforeBlackIn = 0.5,
          BeforeHold = 0.5,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
          Timeout = 1.5,
          TimeoutKey = "XLYZUFsZ"
        },
        {

          StoryId = 5000112,
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
          Timeout = 6.0,
          TimeoutKey = "KSLhITMu"
        },
        {

          StoryId = 5000111,
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
          Timeout = 10.5,
          TimeoutKey = "HNPQWONo"
        },
        {

          Target = "Hero",
          MagicId = 101547,
          Type = 103,
          Timeout = 1.5,
          TimeoutKey = "HmbKPvIu"
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu2/huanjing2/yun",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.5,
          TimeoutKey = "gFmqeQrN"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "挂闪避引导脚本",
      Actions = {
        {

          Target = "Hero",
          MagicId = 1000041,
          Level = 1,
          Type = 16,
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

      EventName = "闪避引导开始",
      Actions = {
        {

          Target = "Hero",
          MagicId = 1000042,
          Level = 1,
          Type = 16,
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

          TimelineName = "TIMELINE0_3_1_0",
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              Type = 46,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 10,
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
      [ 20103801 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}