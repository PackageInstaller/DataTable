local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Target = "Hero",
          Type = 37,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_32902_coming",
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
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
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

      NoPassCamera = 118,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 118,
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

          Key = "pass1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = empty,
          FinishMarkVariable = "3",
          ValidInTower = false
        },
        {

          Key = "pass2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = empty,
          FinishMarkVariable = "4",
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

          TimelineName = "timeline_32902_coming",
          Actions = {
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              PosKey = "M1",
              Rotation = 180,
              NPCId = 3029311,
              NPCName = "薪",
              Type = 0,
              Timeout = 0.0
            },
            {

              StoryId = 2229213,
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

          ConditionVariableList = {
            "3",
            "4"
          },
          Actions = {
            {

              StoryId = 2229214,
              EnableBlackFade = false,
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
            }
          },
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_32902_coming",
          Actions = {
            {

              TimelineName = "timeline_32902_coming",
              Type = 7,
              Timeout = 2.5,
              TimeoutKey = "SrmVSaIy"
            },
            {

              NPC = "Hero",
              Point = "tp1",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
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
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 2229214,
      Name = "6.剧情开始"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}