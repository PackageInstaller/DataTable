local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 102,
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

          TimelineName = "Timeline_AirWall1090202",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TaskId = 1090502,
          Type = 5,
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

          Key = "barrierLen",
          SyncValType = 1,
          Value = 25.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1090202002,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "zqdgeqkw"
        },
        {

          GroupId = 1090202003,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "SrkQsZer"
        },
        {

          GroupId = 1090202004,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "TynaeDWJ"
        },
        {

          GroupId = 1090502001,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 1090502002,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 1090502003,
          Type = 27,
          Timeout = 0.0
        },
        {

          Key = "shunxukaiqi",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "dangqianwancheng",
          SyncValType = 1,
          Value = 0.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
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

      Actions = {
        {

          StoryId = 35010902,
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
          TimeoutKey = "JySutTkU"
        },
        {

          Key = "3001086Complete",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
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
                Id = 109050201,
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
          Timeout = 1.5,
          TimeoutKey = "bukQddvO"
        },
        {

          Key = "Complete",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Camera = 117,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.5,
          TimeoutKey = "oMogmkvL"
        },
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 0.0
        },
        {

          TipsId = 10905011,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "3001086Complete",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.0,
          TimeoutKey = "axjADzjn"
        },
        {

          StoryId = 35010903,
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
          TimeoutKey = "MIZitdYt"
        },
        {

          GroupID = 1,
          Type = 87,
          Timeout = 0.0
        },
        {

          PosKey = "tp4",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 2.0,
          Type = 62,
          Timeout = 0.5,
          TimeoutKey = "kJQntcvl"
        },
        {

          TimelineName = "Timeline_AirWall1090202",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        },
        {

          TaskId = 1090503,
          Type = 5,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 1.0,
          TimeoutKey = "JNlCDBeH"
        },
        {

          IsCameraModeLocked = false,
          Type = 135,
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

      EventName = "ObjComplete30010861",
      Actions = {
        {

          Group = 1090202003,
          Type = 65,
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

      EventName = "ObjComplete30010862",
      Actions = {
        {

          Group = 1090202002,
          Type = 65,
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

      EventName = "ObjComplete30010863",
      Actions = {
        {

          Group = 1090202002,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090202003,
          Type = 65,
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

      EventName = "Finish1",
      Actions = {
        {

          Group = 1090202004,
          Type = 65,
          Timeout = 1.9,
          TimeoutKey = "POVgfrpP"
        },
        {

          GroupId = 1090202001,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "wDyoyEbo"
        },
        {

          Group = 1090502002,
          Type = 65,
          Timeout = 0.0
        },
        {

          GroupId = 1090502005,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "rhqfSQSO"
        },
        {

          GroupId = 1090502004,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "xnInOqqK"
        },
        {

          PosKey = "Orb2",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 0.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 2.0,
          TimeoutKey = "eZIZnXUp"
        },
        {

          PosKey = "center",
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
          Timeout = 4.0,
          TimeoutKey = "OpTvKXWP"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "Finish2",
      Actions = {
        {

          GroupId = 1090502006,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "spDaEPqs"
        },
        {

          Group = 1090502005,
          Type = 65,
          Timeout = 0.0
        },
        {

          PosKey = "Orb3",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 0.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 0.0
        },
        {

          PosKey = "center",
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
          Timeout = 2.0,
          TimeoutKey = "rHzXccLy"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "Finish3",
      Actions = {
        {

          Group = 1090502006,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090202001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090502003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090502004,
          Type = 65,
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

      EventName = "FAIL",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 16,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 109050202,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 109050202,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "清理障碍",
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "清理障碍",
      Actions = {
        {

          Group = 1090202002,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090202003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Key = "LockOrb",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Group = 1090202004,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090202001,
          Type = 65,
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

          Key = "Enter",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              GroupID = 1,
              Type = 86,
              Timeout = 0.0
            },
            {

              StoryId = 34010903,
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
              Timeout = 5.0,
              TimeoutKey = "VxQJMPjM"
            },
            {

              Camera = 1090901,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "Focus1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 5.0,
              TimeoutKey = "AvEjtNqQ"
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              PosKey = "Focus2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 3.0,
              TimeoutKey = "LnYFDedh"
            },
            {

              Camera = 1090002,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 5.0,
              TimeoutKey = "iYaOHjpd"
            },
            {

              TipsId = 10905011,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 5.0,
              TimeoutKey = "zYNWAdWO"
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

          Key = "Enter2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "center",
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
    EventCount = 2,
    MonsterCount = 24,
    MonsterInfo = {
      [ 20106101 ] = 2,
      [ 20106001 ] = 4,
      [ 20106201 ] = 6,
      [ 20105801 ] = 4,
      [ 20105901 ] = 4,
      [ 20205501 ] = 4
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}