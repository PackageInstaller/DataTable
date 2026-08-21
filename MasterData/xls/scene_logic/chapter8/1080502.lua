return
{
  Events = {
    {

      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 3,
            SendWave = false,
            WaveStyle = 0,
            WallObjPath = "emptywall",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10805201,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "investigate",
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

          StoryId = 5080801,
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
          TimeoutKey = "HzxdgCjR"
        },
        {

          ObjName = "/Root/Scene/Zone_03/Building_03/sc08_build_27a_pre/sc08_build_27b_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_03/Building_03/sc08_build_27a_pre/Transparent",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      NoPassCamera = 102,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 102,
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

          PosKey = "M4",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = true,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 2.0,
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

      EventName = "investigate",
      Actions = {
        {

          PosKey = "I1",
          NPCName = "交互点",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638745244189731019,
          IsRemove = true,
          CustomEventName = "play4080801",
          Type = 92,
          Timeout = 0.0
        },
        {

          TaskId = 1080503,
          Type = 5,
          Timeout = 1.5,
          TimeoutKey = "nBJErJlq"
        },
        {

          TimelineName = "timeline_10805_prismGuide",
          Fadein = 0.0,
          Fadeout = 3.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = true,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.2,
          BeforeHold = 0.3,
          BeforeBlackOut = 0.2,
          IsWhite = false,
          Type = 6,
          Timeout = 1.5,
          TimeoutKey = "KTRUJUYw"
        },
        {

          StoryId = 4080802,
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
          TimeoutKey = "hYRSVQPO"
        },
        {

          NPC = "Hero",
          Point = "lookUp",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.8,
          TimeoutKey = "oYIzWMWr"
        },
        {

          Point = "I2",
          Type = 3,
          Timeout = 1.8,
          TimeoutKey = "MdUFDZAB"
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

          Key = "cmr2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 102,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "I2",
              IsOpen = true,
              CameraStyle = 0,
              Duration = -1.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 2.0,
              Type = 62,
              Timeout = 0.5,
              TimeoutKey = "LOXkhDLz"
            },
            {

              GroupID = 2,
              Type = 86,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Cam3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
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

      EventName = "play4080801",
      Actions = {
        {

          StoryId = 4080801,
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
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4080801,
          Actions = {
            {

              TimelineName = "timeline_10805_prism",
              Fadein = 0.0,
              Fadeout = 1.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.3,
              BeforeHold = 0.5,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Scene/Zone_03/Building_03/sc08_build_27a_pre/sc08_build_27b_mod",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.5,
              TimeoutKey = "xLSGtvvR"
            },
            {

              NPCName = "光点",
              Type = 93,
              Timeout = 0.5,
              TimeoutKey = "EjoLkuLB"
            },
            {

              NPC = "Hero",
              Point = "tltp",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.5,
              TimeoutKey = "wKEujdJi"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 1001080802,
          Actions = {
            {

              TaskId = 1080505,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080802,
          Actions = {
            {

              KeyName = "I1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 1.0,
              TimeoutKey = "GXrvKumr"
            },
            {

              PosKey = "I2",
              NPCName = "NhhYQoXD",
              NpcParams = {
                InteractionArea = -1.0,
                UseEffect = "Fx_Investigate_weak|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638877558668095127,
              IsRemove = true,
              Type = 92,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_10805_prismGuide",
              Type = 7,
              Timeout = 1.5,
              TimeoutKey = "GtnQXIVz"
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

          TimelineName = "timeline_10805_prism",
          Actions = {
            {

              Point = "I3",
              Type = 3,
              Timeout = 3.5,
              TimeoutKey = "SOCLneRQ"
            },
            {

              StoryId = 5080802,
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
              Timeout = 5.5,
              TimeoutKey = "DmxKAyef"
            },
            {

              PosKey = "I3",
              NPCName = "pYTEMsQD",
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
              NpcId = 638745261990102607,
              IsRemove = true,
              CustomEventName = "end",
              Type = 92,
              Timeout = 5.5,
              TimeoutKey = "ZYaQNdHh"
            },
            {

              TimelineName = "timeline_10805_prism",
              Type = 7,
              Timeout = 6.5,
              TimeoutKey = "RMDIsjuK"
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

      EventName = "end",
      Actions = {
        {

          StoryId = 1001080802,
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

          TimelineName = "timeline_10805_prism",
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              TaskId = 1080504,
              Type = 5,
              Timeout = 0.0
            },
            {

              KeyName = "I3",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              IsCameraModeLocked = false,
              Type = 135,
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

          Key = "Cam3",
          Actions = {
            {

              Camera = 102,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
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
      StoryId = 1001080802,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 3,
    MonsterInfo = {
      [ 20105501 ] = 1,
      [ 20105701 ] = 1,
      [ 20105601 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}