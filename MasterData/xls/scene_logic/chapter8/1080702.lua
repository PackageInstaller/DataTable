local empty = {}
return
{
  Events = {
    {

      EventName = "UIclose",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skil2",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill8",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "TeamHeads",
          IsShow = false,
          Type = 32,
          Timeout = 0.01,
          TimeoutKey = "jaIByrtr"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          PosKey = "M1",
          NPCName = "假光",
          NpcParams = {
            InteractionArea = -1.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638779112820578668,
          IsRemove = true,
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "真交互",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638779114373104592,
          IsRemove = true,
          CustomEventName = "prisma",
          Type = 92,
          Timeout = 0.0
        },
        {

          KeyName = "M2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_03/Transparent/sc08_area_03_transparent/Transparent9",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_03/Prop_03/sc08_prop_54_pre/Transparent",
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

      NoPassCamera = 1,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1,
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
          IsOpen = true,
          CameraStyle = 1,
          Duration = -1.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 1,
          OTSDuration = -1.0,
          Type = 62,
          Timeout = 0.0
        },
        {

          StoryId = 5080902,
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

          TaskId = 1080702,
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

      EventName = "prisma",
      Actions = {
        {

          Type = 46,
          Timeout = 0.0
        },
        {

          AreaName = "prisma",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          FadeIn = 1.5,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = true,
          Type = 59,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_10807_prisma",
          Fadein = 0.0,
          Fadeout = 2.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = true,
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
          Timeout = 1.8,
          TimeoutKey = "eqjhVRmX"
        },
        {

          ObjName = "/Root/Scene/Zone_03/Transparent/Transparent2",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          TimelineName = "timeline_10807_prisma",
          Actions = {
            {

              StoryId = 4080902,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = true,
              IsSettleStory = false,
              Type = 10,
              Timeout = 2.5,
              TimeoutKey = "GJwsnVPG"
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

      ConditionActions = {
        {

          StoryId = 4080902,
          StepId = 0,
          Actions = empty,
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

          StoryId = 4080902,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              GroupID = 1,
              Type = 87,
              Timeout = 0.0
            },
            {

              Camera = 117,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              IsCameraModeLocked = false,
              Type = 135,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Scene/Zone_03/Transparent/Transparent2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_10807_prisma",
              Type = 7,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
              NPCName = "假目标",
              NpcParams = {
                InteractionArea = 2.0,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638779120764185093,
              IsRemove = true,
              CustomEventName = "endTalk",
              Type = 92,
              Timeout = 0.0
            },
            {

              KeyName = "M3",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              TaskId = 1080703,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 5080902,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              Camera = 118,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080903,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080904,
          Actions = {
            {

              TimelineName = "timeline_10807_estatua2",
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

          Key = "downStair",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 4080903,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = true,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0,
              TimeoutKey = "DVmrInVN"
            },
            {

              PosKey = "M3",
              IsOpen = true,
              CameraStyle = 1,
              Duration = -1.0,
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
        },
        {

          Key = "prisma",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "M1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = -1.0,
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

          Key = "changeEstatua",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              TimelineName = "scene_timeline_10807_estatua1",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_Night/Zone_03/Prop_01",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
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

          Key = "prisma",
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
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
    },
    {

      EventName = "endTalk",
      Actions = {
        {

          TaskId = 1080704,
          Type = 5,
          Timeout = 0.0
        },
        {

          Type = 71,
          Timeout = 0.0
        },
        {

          StoryId = 4080904,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.3,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.3,
          StopFadeInTime = 0.3,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.3,
          NoSkipStory = true,
          IsSettleStory = true,
          Type = 10,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_10807_estatua2",
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
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 0.5,
          TimeoutKey = "dVzmhEnL"
        },
        {

          TimelineName = "scene_timeline_10807_estatua1",
          IsPlay = false,
          Type = 110,
          Timeout = 0.5,
          TimeoutKey = "pDURLetd"
        }
      },
      ValidInTower = false,
      Type = 9,
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
      StoryId = 4080904,
      Name = "6.剧情开始"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}