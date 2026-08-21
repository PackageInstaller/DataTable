local empty = {}
return
{
  Events = {
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
            MonsterCount = 6,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 109040401,
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

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_AirWall1090404",
          IsPlay = true,
          Type = 110,
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
          Value = 11.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1090404001,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "OFcVjytT"
        },
        {

          GroupId = 1090404002,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 1090404005,
          Type = 27,
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

      Actions = {
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

          CustomEventName = "星1完成",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "星2完成",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "3001086Complete",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "星2开启",
      Actions = {
        {

          GroupId = 1090404003,
          Type = 27,
          Timeout = 1.1,
          TimeoutKey = "hYoJhIaN"
        },
        {

          GroupId = 1090404004,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "WXFVfvtG"
        },
        {

          GroupId = 1090404006,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "MdRautou"
        },
        {

          Camera = 1091801,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.5,
          TimeoutKey = "oCFgiphf"
        },
        {

          PosKey = "GuideLine1",
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
          Timeout = 1.0,
          TimeoutKey = "hTJVBxBC"
        },
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 11.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.5,
          TimeoutKey = "MOjefzuI"
        },
        {

          GroupId = 1090404001,
          Type = 27,
          Timeout = 0.6,
          TimeoutKey = "yGcDplvS"
        },
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 20.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "gDVjGMsa"
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          TipsId = 10904021,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "Teleport",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "IfKUnDKU"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "星1完成",
      Actions = {
        {

          Group = 1090404005,
          Type = 65,
          Timeout = 0.0
        },
        {

          Key = "uranis",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.5,
          TimeoutKey = "PoUgdutW"
        },
        {

          StoryId = 34010704,
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
          TimeoutKey = "aeUfLuRi"
        },
        {

          Key = "ShowShadow1",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 4.0,
          TimeoutKey = "GILTCOJX"
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 2.0,
          TimeoutKey = "zncFpxDd"
        },
        {

          KeyName = "Story1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 4.0,
          TimeoutKey = "LEULecPP"
        },
        {

          TaskId = 1090406,
          Type = 5,
          Timeout = 2.0,
          TimeoutKey = "joCybOLE"
        },
        {

          PosKey = "Story1",
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
          Timeout = 4.0,
          TimeoutKey = "LJXfIwqk"
        },
        {

          TimelineName = "Timeline_Sc09_Shadow_3",
          IsPlay = true,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "UXGoZnZj"
        },
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 3.0,
          TimeoutKey = "FmvMQllY"
        },
        {

          Camera = 118,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 3.0,
          TimeoutKey = "mONnSYhn"
        },
        {

          Group = 1090404001,
          Type = 65,
          Timeout = 0.0
        },
        {

          TipsId = 10904021,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          PosKey = "Story1",
          Rotation = 0,
          NPCId = 1090001,
          NPCName = "1",
          Type = 0,
          Timeout = 3.0,
          TimeoutKey = "yMNAlsCa"
        },
        {

          IsCameraModeLocked = false,
          Type = 135,
          Timeout = 3.0,
          TimeoutKey = "LiYksjzY"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "uranis",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "星2完成",
      Actions = {
        {

          GroupID = 1,
          Type = 87,
          Timeout = 0.0
        },
        {

          Group = 1090404006,
          Type = 65,
          Timeout = 0.0
        },
        {

          Key = "ShowShadow2",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 3.0,
          TimeoutKey = "DaeYPMtI"
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 2.0,
          TimeoutKey = "awmUajhA"
        },
        {

          KeyName = "Story2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 4.0,
          TimeoutKey = "cWSwUJMh"
        },
        {

          TaskId = 1090408,
          Type = 5,
          Timeout = 2.0,
          TimeoutKey = "SyjivUTS"
        },
        {

          PosKey = "Story2",
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
          Timeout = 4.0,
          TimeoutKey = "wgaWDInj"
        },
        {

          TimelineName = "Timeline_Sc09_Shadow_4",
          IsPlay = true,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "iGnLnRSd"
        },
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 3.0,
          TimeoutKey = "CvuoeJmx"
        },
        {

          Camera = 118,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 3.0,
          TimeoutKey = "UduULOiE"
        },
        {

          IsCameraModeLocked = false,
          Type = 135,
          Timeout = 3.0,
          TimeoutKey = "xQsAqYyR"
        },
        {

          Group = 1090404001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090404003,
          Type = 65,
          Timeout = 0.0
        },
        {

          TipsId = 10904021,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          PosKey = "Story2",
          Rotation = 0,
          NPCId = 1090002,
          NPCName = "2",
          Type = 0,
          Timeout = 3.0,
          TimeoutKey = "JhFOMGfN"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "uranis",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          KeyName = "GuideLine1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 3.0,
          TimeoutKey = "LNXsEBLJ"
        },
        {

          GroupID = 2,
          Type = 87,
          Timeout = 0.0
        },
        {

          StoryId = 34010703,
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
          Timeout = 1.5,
          TimeoutKey = "rqtGSqEw"
        },
        {

          Camera = 210,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 2.0,
          TimeoutKey = "DEdjHWrM"
        },
        {

          TimelineName = "Scene_Timeline_109040401",
          Fadein = 1.0,
          Fadeout = 2.0,
          IsCanSkip = true,
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
          Timeout = 0.5,
          TimeoutKey = "lEebSmPF"
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
            MonsterCount = 12,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 109040402,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 109040403,
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

          Group = 1090404001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1090404003,
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

          StoryId = 34010703,
          Actions = {
            {

              TimelineName = "Scene_Timeline_109040401",
              Type = 7,
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

          Key = "ENTER",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              GroupID = 1,
              Type = 86,
              Timeout = 0.0
            },
            {

              TaskId = 1090405,
              Type = 5,
              Timeout = 0.0
            },
            {

              Camera = 1091801,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "GuideLine1",
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
              Timeout = 0.5,
              TimeoutKey = "mvYnqxOL"
            },
            {

              TipsId = 10904021,
              Visible = true,
              Flip = false,
              Type = 15,
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

          StoryId = 34010705,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              StoryId = 34010706,
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
              Timeout = 2.0,
              TimeoutKey = "PfyAzovv"
            },
            {

              TaskId = 1090407,
              Type = 5,
              Timeout = 0.0
            },
            {

              TimelineName = "Timeline_Sc09_Shadow_3",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "nnemntdg"
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 1.0,
              TimeoutKey = "ZplEhTpP"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 34010706,
          Actions = {
            {

              CustomEventName = "星2开启",
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

      ConditionActions = {
        {

          StoryId = 34010707,
          Actions = {
            {

              StoryId = 1003010702,
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

              TimelineName = "Timeline_AirWall1090404",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              TaskId = 1090409,
              Type = 5,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
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

          StoryId = 1003010702,
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

              StoryId = 34010705,
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

              PosKey = "Story1",
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
    },
    {

      ConditionActions = {
        {

          NPCId = 1090002,
          Actions = {
            {

              StoryId = 34010707,
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

              PosKey = "Story2",
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
    EventCount = 2,
    MonsterCount = 18,
    MonsterInfo = {
      [ 20105501 ] = 1,
      [ 20205501 ] = 2,
      [ 20105601 ] = 1,
      [ 20205601 ] = 2,
      [ 20105801 ] = 4,
      [ 20105901 ] = 2,
      [ 20106201 ] = 2,
      [ 20106101 ] = 2,
      [ 20106001 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}