local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "TimeLine_jeuse_319010101",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          PosKey = "N1",
          Rotation = 0,
          NPCId = 301901,
          NPCName = "居民1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N2",
          Rotation = 0,
          NPCId = 301902,
          NPCName = "居民2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N3",
          Rotation = -90,
          NPCId = 301903,
          NPCName = "居民3",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N4",
          Rotation = 0,
          NPCId = 301904,
          NPCName = "居民4",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N5",
          Rotation = 0,
          NPCId = 301905,
          NPCName = "居民5",
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

      NoPassCamera = 117,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 117,
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

          TimelineName = "TimeLine_319010101",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = true,
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

          StoryId = 3219101,
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

          TaskGroupId = 31901,
          Type = 21,
          Timeout = 0.0
        },
        {

          StoryId = 32019101,
          BarrageStyle = 2,
          Alpha = 0.0,
          Speed = 200,
          Type = 113,
          Timeout = 0.0
        },
        {

          LineCount = 5,
          StateInfos = {
            {
              KeyName = "N1",
              IsOpen = true
            },
            {
              KeyName = "N2",
              IsOpen = true
            },
            {
              KeyName = "N3",
              IsOpen = true
            },
            {
              KeyName = "N4",
              IsOpen = true
            },
            {
              KeyName = "N5",
              IsOpen = true
            }
          },
          Type = 98,
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

          Key = "camera1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 117,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 113,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 111,
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2219101,
          Actions = {
            {

              CondId = 31901011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "N1",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219102,
          Actions = {
            {

              CondId = 31901011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "N2",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219103,
          Actions = {
            {

              CondId = 31901011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "N3",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219104,
          Actions = {
            {

              CondId = 31901011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "N4",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219105,
          Actions = {
            {

              CondId = 31901011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "N5",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 3219101,
          Actions = {
            {

              StoryId = 32019101,
              BarrageStyle = 2,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
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

          NPCId = 301901,
          Actions = {
            {

              StoryId = 2219101,
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
        },
        {

          NPCId = 301902,
          Actions = {
            {

              StoryId = 2219102,
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
        },
        {

          NPCId = 301903,
          Actions = {
            {

              StoryId = 2219103,
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
        },
        {

          NPCId = 301904,
          Actions = {
            {

              StoryId = 2219104,
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
        },
        {

          NPCId = 301905,
          Actions = {
            {

              StoryId = 2219105,
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
      Type = 6,
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
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TaskId = 3190101,
          Actions = {
            {

              StoryId = 3219102,
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

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
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
      Type = 14,
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