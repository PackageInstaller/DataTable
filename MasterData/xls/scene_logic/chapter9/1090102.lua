local empty = {}
return
{
  Events = {
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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupId = 1090102001,
          Type = 27,
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

          PosKey = "Orb",
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

          StoryId = 34010301,
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
          TimeoutKey = "VHcoEzVa"
        },
        {

          TimelineName = "Timeline_AirWall1090102",
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

      EventName = "OrbStartFollow",
      Actions = {
        {

          GuideId = 10901021,
          Type = 41,
          Timeout = 0.0
        },
        {

          Type = 14,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "OrbStartFollow",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "OrbStartFollow",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          GuideID = 10901021,
          Actions = {
            {

              StoryId = 35010304,
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
              TimeoutKey = "YWSvXHSF"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 7,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 109010201,
                    param = 1,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 109010202,
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

              PosKey = "Fight",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 1.0,
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
        },
        {

          GuideID = 10901022,
          Actions = {
            {

              StoryId = 35010305,
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

          GuideID = 10901023,
          Actions = {
            {

              StoryId = 34010302,
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
              TimeoutKey = "kueBbRKm"
            }
          },
          ValidInTower = false
        }
      },
      Type = 15,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "OrbExplode",
      Actions = empty,
      FinishMarkVariable = "OrbExplode",
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

          Key = "qb",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          PosKey = "Orb",
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

          GuideId = 10901023,
          Type = 41,
          Timeout = 0.5,
          TimeoutKey = "jUpOpeiQ"
        },
        {

          Type = 71,
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

          StoryId = 34010302,
          Actions = {
            {

              GroupId = 10901021,
              Type = 42,
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

          GroupId = 10901021,
          Actions = {
            {

              StoryId = 34010303,
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
              TimeoutKey = "vKUTWwKe"
            },
            {

              Group = 1090102001,
              Type = 65,
              Timeout = 0.0
            },
            {

              GroupId = 1090102002,
              Type = 27,
              Timeout = 0.0
            },
            {

              PosKey = "Orb2",
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
              Timeout = 0.5,
              TimeoutKey = "iCRsekuo"
            },
            {

              GroupID = 1,
              Type = 87,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "Tips1",
          ValidInTower = false
        }
      },
      Type = 8,
      ConditionVariable = "Tips1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          GroupId = 10901022,
          Actions = {
            {

              TipsId = 10901022,
              Visible = true,
              Flip = false,
              Type = 15,
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
              Timeout = 2.0,
              TimeoutKey = "eyXfyhYq"
            },
            {

              Camera = 1090901,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
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
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "Tips2",
          ValidInTower = false
        }
      },
      Type = 8,
      ConditionVariable = "Tips2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 34010301,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              KeyName = "Orb",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              TaskId = 1090101,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 34010303,
          Actions = {
            {

              KeyName = "Orb2",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 35010307,
          Actions = {
            {

              PosKey = "Guide2",
              NPCName = "FBFOIzlF",
              NpcParams = {
                InteractionArea = 3.3,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638809384455528086,
              IsRemove = true,
              CustomEventName = "能量门交互",
              Type = 92,
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

              StoryId = 35010306,
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

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 4,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 109010203,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb2",
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

              TipsId = 10901021,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              TaskId = 1090102,
              Type = 5,
              Timeout = 0.0
            },
            {

              Camera = 117,
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

      EventName = "qb2",
      Actions = {
        {

          StoryId = 35010307,
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
          TimeoutKey = "WQQPESOM"
        },
        {

          PosKey = "Guide2",
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
          Timeout = 0.0
        },
        {

          TaskId = 1090103,
          Type = 5,
          Timeout = 0.0
        },
        {

          Group = 1090102002,
          Type = 65,
          Timeout = 0.0
        },
        {

          TipsId = 10901021,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          KeyName = "Guide2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

      EventName = "能量门交互",
      Actions = {
        {

          StoryId = 34010306,
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

          GroupId = 1090102002,
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

      ConditionActions = {
        {

          StoryId = 34010306,
          Actions = {
            {

              GroupId = 1090102003,
              Type = 27,
              Timeout = 0.0
            },
            {

              PosKey = "Target",
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

              StoryId = 34010307,
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
              TimeoutKey = "QkNmwkUz"
            },
            {

              TaskId = 1090104,
              Type = 5,
              Timeout = 0.0
            },
            {

              KeyName = "Target",
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

          StoryId = 34010307,
          Actions = {
            {

              GroupId = 10901022,
              Type = 42,
              Timeout = 1.0,
              TimeoutKey = "tpLNgsqZ"
            },
            {

              KeyName = "Orb2",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              Camera = 117,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
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

      Actions = {
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

          StoryId = 34010308,
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
          Timeout = 3.0,
          TimeoutKey = "lbEHwyDj"
        },
        {

          GroupID = 2,
          Type = 87,
          Timeout = 3.0,
          TimeoutKey = "KPWETnOl"
        },
        {

          Group = 1090102002,
          Type = 65,
          Timeout = 0.0
        },
        {

          PosKey = "Guide2",
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
          Timeout = 2.0,
          TimeoutKey = "mXPMvqxQ"
        },
        {

          TimelineName = "Timeline_AirWall1090102",
          IsPlay = false,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "ggcUZcZG"
        },
        {

          TipsId = 10901022,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          TaskId = 1090105,
          Type = 5,
          Timeout = 2.0,
          TimeoutKey = "AXcUUxGx"
        },
        {

          Camera = 117,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 2.0,
          TimeoutKey = "AcUrPKtm"
        },
        {

          KeyName = "M1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 3.0,
          TimeoutKey = "OjihXlaX"
        },
        {

          IsCameraModeLocked = false,
          Type = 135,
          Timeout = 2.0,
          TimeoutKey = "zDivtQGd"
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "3001086Complete",
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

          Key = "Exit",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 1003010302,
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

              TaskId = 1090106,
              Type = 5,
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

          StoryId = 1003010302,
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
    EventCount = 2,
    MonsterCount = 11,
    MonsterInfo = {
      [ 20106201 ] = 1,
      [ 20105901 ] = 8,
      [ 20106001 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}