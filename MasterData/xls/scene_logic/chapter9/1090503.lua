local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "Timeline_AirWall109020102",
          IsPlay = true,
          Type = 110,
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

      NoPassCamera = 210,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 104,
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
          Value = 18.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1090503001,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "EbOAeaqi"
        },
        {

          GroupId = 1090503002,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 1090503004,
          Type = 27,
          Timeout = 0.0
        },
        {

          Key = "shunxukaiqi",
          SyncValType = 1,
          Value = 2.0,
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
        },
        {

          Key = "youxu",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1090503006,
          Type = 27,
          Timeout = 0.0
        },
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 14.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "WYxetkIi"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "30010861Complete",
      Actions = {
        {

          StoryId = 35010904,
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

          Group = 1090503004,
          Type = 65,
          Timeout = 0.0
        },
        {

          GroupId = 1090503005,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "Earth",
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

          PosKey = "Focus",
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
          Timeout = 3.0,
          TimeoutKey = "pDfUxsvR"
        },
        {

          GroupId = 1090503007,
          Type = 27,
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

      EventName = "30010862Complete",
      Actions = {
        {

          StoryId = 35010906,
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
          Timeout = 4.0,
          TimeoutKey = "dmKsUqXz"
        },
        {

          Key = "ShowShadow",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 4.0,
          TimeoutKey = "DylreOVi"
        },
        {

          Group = 1090503003,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "LkvUOIHW"
        },
        {

          Group = 1090503001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090503004,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090503005,
          Type = 65,
          Timeout = 0.0
        },
        {

          TaskId = 1090505,
          Type = 5,
          Timeout = 0.0
        },
        {

          Group = 1090503006,
          Type = 65,
          Timeout = 0.0
        },
        {

          Key = "3001086Complete",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
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

          TimelineName = "Timeline_Sc09_Shadow_5",
          IsPlay = true,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "ZeDNtjRW"
        },
        {

          Camera = 118,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 3.0,
          TimeoutKey = "flOJzOuf"
        },
        {

          FadeIn = 0.3,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 2.0,
          TimeoutKey = "uOjITfut"
        },
        {

          PosKey = "shadow1",
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
          Timeout = 4.0,
          TimeoutKey = "XFCFfbPW"
        },
        {

          KeyName = "shadow1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 4.0,
          TimeoutKey = "hkDLExNn"
        },
        {

          Group = 1090503007,
          Type = 65,
          Timeout = 0.0
        },
        {

          TipsId = 10905031,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          PosKey = "shadow1",
          Rotation = 0,
          NPCId = 1090001,
          NPCName = "1",
          Type = 0,
          Timeout = 4.0,
          TimeoutKey = "UEORIhnV"
        },
        {

          IsCameraModeLocked = false,
          Type = 135,
          Timeout = 3.0,
          TimeoutKey = "khLarwvd"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "SunWrong",
      Actions = {
        {

          StoryId = 35010905,
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

          PosKey = "Sun",
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

          PosKey = "Focus",
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
          Timeout = 3.0,
          TimeoutKey = "UyakUlai"
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
      Actions = empty,
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

          Group = 1090503003,
          Type = 65,
          Timeout = 0.0
        },
        {

          GroupId = 1090503003,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "yWupKihZ"
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
            MonsterCount = 10,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 109050301,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 109050301,
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

          Group = 1090503001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090503003,
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

              PosKey = "Focus2",
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
              Timeout = 0.5,
              TimeoutKey = "nBBNzQxU"
            },
            {

              PosKey = "Focus",
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
              TimeoutKey = "dUdrtJAf"
            },
            {

              Camera = 1090901,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              StoryId = 34010904,
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
              TimeoutKey = "WQupPgZe"
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 5.0,
              TimeoutKey = "XLiloVES"
            },
            {

              Type = 61,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Enter2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "Focus",
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

      ConditionActions = {
        {

          StoryId = 34010905,
          Actions = {
            {

              StoryId = 1003010902,
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
            },
            {

              TaskId = 1090506,
              Type = 5,
              Timeout = 0.0
            },
            {

              TimelineName = "Timeline_Sc09_Shadow_5",
              IsPlay = false,
              Type = 110,
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

          StoryId = 34010904,
          Actions = {
            {

              TaskId = 1090504,
              Type = 5,
              Timeout = 0.0
            },
            {

              TipsId = 10905031,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.5,
              TimeoutKey = "yDNXzSuA"
            },
            {

              GroupId = 10905031,
              Type = 42,
              Timeout = 0.5,
              TimeoutKey = "vuuIdSoo"
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
    },
    {

      ConditionActions = {
        {

          StoryId = 1003010902,
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
    },
    {

      ConditionActions = {
        {

          NPCId = 1090001,
          Actions = {
            {

              StoryId = 34010905,
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

              PosKey = "shadow1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
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
    MonsterCount = 10,
    MonsterInfo = {
      [ 20105801 ] = 2,
      [ 20105901 ] = 2,
      [ 20106001 ] = 2,
      [ 20106101 ] = 2,
      [ 20106201 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}