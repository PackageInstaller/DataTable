local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          StoryId = 5061601,
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
          Timeout = 7.0,
          TimeoutKey = "gJuWePVy"
        },
        {

          Target = "God",
          MagicId = 1068004,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          TimelineName = "TL_DamBreak",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.5,
          Hold = 0.5,
          BlackOut = 0.5,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.5,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
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

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
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

          StoryId = 1001061601,
          Actions = {
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              PlayBgm = "bgm_chapter6_elite",
              Type = 76,
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

          StoryId = 4061601,
          Actions = {
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

          NPCId = 1061004,
          Actions = {
            {

              Target = "God",
              MagicId = 1068001,
              Type = 103,
              Timeout = 1.0,
              TimeoutKey = "lNuCDvZc"
            },
            {

              NPCId = 106100101,
              NPCActionName = "idle",
              Type = 100,
              Timeout = 0.0
            },
            {

              PosKey = "npc2",
              Rotation = 0,
              NPCId = 1061005,
              NPCName = "2",
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 1061005,
          Actions = {
            {

              Target = "God",
              MagicId = 1068002,
              Type = 103,
              Timeout = 1.0,
              TimeoutKey = "gYZqRepb"
            },
            {

              PosKey = "npc3",
              Rotation = 0,
              NPCId = 1061006,
              NPCName = "3",
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 1061006,
          Actions = {
            {

              Target = "God",
              MagicId = 1068003,
              Type = 103,
              Timeout = 1.0,
              TimeoutKey = "nNdwAIgK"
            },
            {

              NPCId = 106100104,
              NPCActionName = "idle",
              Type = 100,
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

      ConditionActions = {
        {

          TimelineName = "TL_DamBreak",
          Actions = {
            {

              PosKey = "npc1",
              Rotation = 0,
              NPCId = 1061004,
              NPCName = "1",
              Type = 0,
              Timeout = 0.0
            },
            {

              TaskGroupId = 1069,
              Type = 21,
              Timeout = 0.0
            },
            {

              PosKey = "npc7",
              Rotation = -120,
              NPCId = 106100104,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "npc6",
              Rotation = 120,
              NPCId = 106100103,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "npc5",
              Rotation = -120,
              NPCId = 106100102,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "npc4",
              Rotation = 120,
              NPCId = 106100101,
              Type = 0,
              Timeout = 0.0
            },
            {

              Target = "God",
              MagicId = 1068001,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "God",
              MagicId = 1068002,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "God",
              MagicId = 1068003,
              Level = 0,
              Type = 16,
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
    },
    {

      ConditionActions = {
        {

          NPCCount = 3,
          FuncNpcList = {
            "1",
            "2",
            "3"
          },
          Actions = {
            {

              StoryId = 4061601,
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

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              TaskId = 106901,
              Type = 5,
              Timeout = 0.0
            },
            {

              Target = "God",
              MagicId = 1068004,
              Type = 103,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 24,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      StoryID = 1001061601,
      Actions = {
        {

          Target = "Hero",
          Type = 37,
          Timeout = 0.0
        },
        {

          StoryId = 1001061601,
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
  FinishiConditionDict = empty,
  mDefaultStartTime = true,
  mDefaultEndTime = true
}