local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          TaskId = 107503,
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
        },
        {

          PosKey = "N1",
          Rotation = 0,
          NPCId = 107050201,
          NPCName = "渊泉",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N1",
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

          StoryId = 4071105,
          Actions = {
            {

              TimelineName = "timeline_10705_yuanquan",
              Fadein = 0.0,
              Fadeout = 1.0,
              IsCanSkip = true,
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
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_10705_yuanquan",
              Type = 7,
              Timeout = 3.0,
              TimeoutKey = "nLHxBSqs"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 15,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 107050201,
                    param = 1,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 107050202,
                    param = 1,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 107050203,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb",
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

              NPCId = 107050201,
              NPCName = "渊泉",
              Type = 1,
              Timeout = 1.5,
              TimeoutKey = "jcyRHvdz"
            },
            {

              PosKey = "N2",
              Rotation = 180,
              NPCId = 107050202,
              NPCName = "npc",
              Type = 0,
              Timeout = 1.5,
              TimeoutKey = "BFctMfbM"
            },
            {

              GroupID = 1,
              Type = 86,
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

          NPCId = 107050201,
          Actions = {
            {

              StoryId = 4071105,
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

              TaskId = 107504,
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

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          TaskId = 107505,
          Type = 5,
          Timeout = 0.0
        },
        {

          TimelineName = "TIMELINE7_3_1_0",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.5,
          BeforeHold = 1.0,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          Group = 107050203,
          Type = 65,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          Type = 37,
          Timeout = 0.0
        },
        {

          ChangeTime = 0.5,
          Type = 75,
          Timeout = 0.0
        },
        {

          NPCId = 107050202,
          NPCName = "npc",
          Type = 1,
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

          TimelineName = "TIMELINE7_3_1_0",
          Actions = {
            {

              StoryId = 1001071102,
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
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 1001071102,
          StepId = 0,
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
      Type = 12,
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
    MonsterCount = 15,
    MonsterInfo = {
      [ 20205001 ] = 11,
      [ 20204901 ] = 2,
      [ 20105001 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}