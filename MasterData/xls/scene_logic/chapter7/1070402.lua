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
        },
        {

          PosKey = "M1",
          Rotation = -45,
          NPCId = 107040201,
          NPCName = "阿紫",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 45,
          NPCId = 107040202,
          NPCName = "暝",
          Type = 0,
          Timeout = 0.0
        },
        {

          LineCount = 1,
          StateInfos = {
            {
              KeyName = "M1",
              IsOpen = true
            }
          },
          Type = 98,
          Timeout = 0.0
        },
        {

          LineCount = 1,
          StateInfos = {
            {
              KeyName = "M2",
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

          NPCId = 107040203,
          Actions = {
            {

              CustomEventName = "shuaguai",
              Type = 19,
              Timeout = 0.0
            },
            {

              GroupId = 107040201,
              Type = 27,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 107040204,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              Group = 107040201,
              Type = 65,
              Timeout = 0.0
            },
            {

              TaskId = 107401,
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

      ConditionActions = {
        {

          NPCId = 107040201,
          Actions = {
            {

              StoryId = 3105801,
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

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "M1",
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

          NPCId = 107040202,
          Actions = {
            {

              StoryId = 3105802,
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

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "M2",
                  IsOpen = false
                }
              },
              Type = 98,
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

      EventName = "shuaguai",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 8,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 107040201,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb",
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

          NPCId = 107040201,
          NPCName = "阿紫",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 107040202,
          NPCName = "暝",
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

      EventName = "qb",
      Actions = {
        {

          PosKey = "M3",
          Rotation = 0,
          NPCId = 107040204,
          NPCName = "龙柱2",
          Type = 0,
          Timeout = 1.5,
          TimeoutKey = "EKPRMAVc"
        },
        {

          PosKey = "M3",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 3.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
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

          NPCCount = 2,
          FuncNpcList = {
            "阿紫",
            "暝"
          },
          Actions = {
            {

              PosKey = "M3",
              Rotation = 0,
              NPCId = 107040203,
              NPCName = "龙柱1",
              Type = 0,
              Timeout = 1.5,
              TimeoutKey = "wJEykKpc"
            },
            {

              PosKey = "M3",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
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
    MonsterCount = 8,
    MonsterInfo = {
      [ 20204301 ] = 4,
      [ 20204601 ] = 4
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}