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

          Key = "lantern_room",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "total_lantern_num",
          SyncValType = 1,
          Value = 4.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 10670701,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "JBtmSmvL"
        },
        {

          Key = "jinghua_num",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "reset_times",
          SyncValType = 1,
          Value = 0.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "show_tips",
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
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
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
                Id = 106704001,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 106707001,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "kill",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "restart",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 106000,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 106000,
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

          Key = "room_pass",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TipsId = 1067006,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          TipsId = 10670062,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          LineCount = 4,
          StateInfos = {
            {
              KeyName = "q1",
              IsOpen = false
            },
            {
              KeyName = "q2",
              IsOpen = false
            },
            {
              KeyName = "q3",
              IsOpen = false
            },
            {
              KeyName = "q4",
              IsOpen = false
            }
          },
          Type = 98,
          Timeout = 0.0
        },
        {

          Group = 10670702,
          Type = 65,
          Timeout = 0.0
        },
        {

          TaskId = 106601,
          Type = 5,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "fog_clear",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "room_pass",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "room_restart",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "回档",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "room_restart",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "show_tips",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1067062,
          Type = 42,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "show_tips",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "cam1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 106045,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "cam2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1060451,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "cam3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1060901,
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

          StoryId = 4061102,
          Actions = {
            {

              TaskId = 106701,
              Type = 5,
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

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "kill",
      Actions = {
        {

          Tips = "977",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.25,
          TimeoutKey = "ILBEOfPV"
        },
        {

          GroupId = 10670702,
          Type = 27,
          Timeout = 0.25,
          TimeoutKey = "KWnfrVfu"
        },
        {

          Camera = 10670701,
          IsNewConfig = true,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.0
        },
        {

          PosKey = "puzzle",
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
          Timeout = 0.25,
          TimeoutKey = "vbrzceDx"
        },
        {

          StoryId = 5061106,
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
          Timeout = 0.25,
          TimeoutKey = "URtNTXzY"
        },
        {

          TipsId = 1067006,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 0.25,
          TimeoutKey = "jHErLecl"
        },
        {

          LineCount = 4,
          StateInfos = {
            {
              KeyName = "q1",
              IsOpen = true
            },
            {
              KeyName = "q2",
              IsOpen = true
            },
            {
              KeyName = "q3",
              IsOpen = true
            },
            {
              KeyName = "q4",
              IsOpen = true
            }
          },
          Type = 98,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "enemy_kill",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "回档",
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

          Tips = "976",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 1.5,
          TimeoutKey = "blOjjNuG"
        },
        {

          Group = 10670701,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "MTMrcRts"
        },
        {

          Group = 10670702,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "kjCPNBzV"
        },
        {

          GroupId = 10670701,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "jYUoTkNx"
        },
        {

          GroupId = 10670702,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "SsDdGrQB"
        },
        {

          Key = "jinghua_num",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "TTTcLiXR"
        },
        {

          TipsId = 10670062,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 1.0,
          TimeoutKey = "sekiUzpc"
        },
        {

          TipsId = 1067006,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.5,
          TimeoutKey = "RPdpixof"
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

          StoryId = 4061102,
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

          ConditionVariableList = {
            "enemy_kill",
            "fog_clear"
          },
          Actions = {
            {

              Camera = 106000,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            },
            {

              StoryId = 4061102,
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
              Timeout = 1.0,
              TimeoutKey = "KrLQKjaP"
            }
          },
          ValidInTower = false
        }
      },
      Type = 31,
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
    MonsterCount = 7,
    MonsterInfo = {
      [ 20204901 ] = 4,
      [ 20205001 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}