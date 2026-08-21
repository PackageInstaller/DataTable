local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "timeline_n1531-1",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 1.0,
          Hold = 1.0,
          BlackOut = 1.0,
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

          ObjName = "/Root/Change_/Change_bright/Level1/guandao",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
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

      NoPassCamera = 10404,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10404,
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

          ContainerName = "Level1",
          Names = {
            "L12"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level1",
          Names = {
            "L13"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
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

          Key = "C1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 1050203,
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
      Type = 3,
      ConditionVariable = "QQ",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 1050202,
          Actions = {
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
                    Id = 10510211,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "A",
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

              TaskGroupId = 1052,
              Type = 21,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          StoryId = 1050209,
          Actions = {
            {

              PosKey = "A7",
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

              BackToDefault = true,
              Type = 63,
              Timeout = 2.0,
              TimeoutKey = "TwaMcyhz"
            },
            {

              PosKey = "A7",
              NPCName = "aQnDKMET",
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
              NpcId = 638252948948838134,
              IsRemove = true,
              CustomEventName = "GG",
              Type = 92,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 1050210,
          Actions = {
            {

              TimelineName = "timeline_n1531-2",
              Fadein = 2.0,
              Fadeout = 2.0,
              IsCanSkip = false,
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
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 2.0,
              TimeoutKey = "tdJUIKvn"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 1050205,
          Actions = {
            {

              PosKey = "A8",
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
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 2.0,
              TimeoutKey = "DubwNHDP"
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

          Type = 12,
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

      EventName = "C1",
      Actions = {
        {

          PosKey = "A5",
          NPCName = "cdtSQkLC",
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
          NpcId = 638254606174260008,
          IsRemove = true,
          CustomEventName = "CC",
          Type = 92,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S4/FX_SC05_shuiguanpolie (2)",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S4/FX_SC05_shuiguanpolie (3)",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S4/FX_SC05_shuiguanpolie (4)",
          IsAutoSave = false,
          Type = 53,
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

      EventName = "EE",
      Actions = {
        {

          PosKey = "A6",
          NPCName = "iIKZoEyU",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 2.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638254604239861420,
          IsRemove = true,
          CustomEventName = "FF",
          Type = 92,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S5/FX_SC05_shuiguanpolie (5)",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S5/FX_SC05_shuiguanpolie",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S5/FX_SC05_shuiguanpolie (1)",
          IsAutoSave = false,
          Type = 53,
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

      EventName = "DD",
      Actions = {
        {

          PosKey = "A5",
          NPCName = "iIKZoE",
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
          NpcId = 638254603988838193,
          IsRemove = true,
          CustomEventName = "EE",
          Type = 92,
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

      EventName = "AA8",
      Actions = {
        {

          StoryId = 2050206,
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

          PosKey = "A3",
          NPCName = "UlofqfQQ",
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
          NpcId = 638252972446241815,
          IsRemove = true,
          CustomEventName = "BB",
          Type = 92,
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

      EventName = "B",
      Actions = {
        {

          StoryId = 1050205,
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

          PosKey = "A8",
          NPCName = "gjGNJpMM",
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
          NpcId = 638252971709780746,
          IsRemove = true,
          CustomEventName = "AA8",
          Type = 92,
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

      EventName = "GG",
      Actions = {
        {

          TimelineName = "timeline_n1531-4",
          Fadein = 3.0,
          Fadeout = 3.0,
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

      EventName = "CC",
      Actions = {
        {

          StoryId = 2050208,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 1.0,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 1.0,
          StopFadeInTime = 1.0,
          StopStayTime = 0.5,
          StopFadeOutTime = 1.0,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.5,
          TimeoutKey = "d"
        },
        {

          PosKey = "drop",
          NPCName = "EULtApAE",
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
          NpcId = 638254603482198192,
          IsRemove = true,
          CustomEventName = "DD",
          Type = 92,
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

      EventName = "BB",
      Actions = {
        {

          StoryId = 2050207,
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

          PosKey = "A4",
          NPCName = "AAgniYXB",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638254603707401819,
          IsRemove = true,
          CustomEventName = "C1",
          Type = 92,
          Timeout = 0.0
        },
        {

          Camera = 10403,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 3.0,
          TimeoutKey = "bWDMiK"
        },
        {

          TimelineName = "timeline_n1531-5",
          Fadein = 2.0,
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
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S3/FX_SC05_shuiguanpolie (3)",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S3/FX_SC05_shuiguanpolie (4)",
          IsAutoSave = false,
          Type = 53,
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

      EventName = "A",
      Actions = {
        {

          PosKey = "A1",
          NPCName = "EPoTbIdM",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638252926064362985,
          IsRemove = true,
          CustomEventName = "AA",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "A1",
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

          BackToDefault = true,
          Type = 63,
          Timeout = 2.0,
          TimeoutKey = "UcEwyEUJ"
        }
      },
      FinishMarkVariable = "QQ",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "FF",
      Actions = {
        {

          TimelineName = "timeline_n1531-3",
          Fadein = 2.0,
          Fadeout = 3.0,
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
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S6/FX_SC05_shuiguanpolie",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S6/FX_SC05_shuiguanpolie (1)",
          IsAutoSave = false,
          Type = 53,
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

      EventName = "BB",
      Actions = {
        {

          StoryId = 2050207,
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

          PosKey = "A4",
          NPCName = "msAUekfs",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638252936320985700,
          IsRemove = true,
          CustomEventName = "C1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "A5",
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
        },
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 3.0,
          TimeoutKey = "HMPnT"
        },
        {

          Camera = 10403,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 3.0,
          TimeoutKey = "bWDMiK"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "AA",
      Actions = {
        {

          PosKey = "A2",
          NPCName = "JSUydyHD",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638252926695583843,
          IsRemove = true,
          CustomEventName = "TX2",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "A3",
          NPCName = "jiassxrs",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 3.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638252926700355884,
          IsRemove = true,
          CustomEventName = "B",
          Type = 92,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S1/FX_SC05_shuiguanpolie",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S1/FX_SC05_shuiguanpolie (1)",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          TaskId = 105202,
          Type = 5,
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

      EventName = "TX2",
      Actions = {
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S2/FX_SC05_shuiguanpolie (2)",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S2/FX_SC05_shuiguanpolie (6)",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx/S2/FX_SC05_shuiguanpolie (5)",
          IsAutoSave = false,
          Type = 53,
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

          TimelineName = "timeline_n1531-1",
          Actions = {
            {

              StoryId = 1050202,
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
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          TimelineName = "timeline_n1531-3",
          Actions = {
            {

              StoryId = 1050209,
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

          TimelineName = "timeline_n1531-4",
          Actions = {
            {

              StoryId = 1050210,
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
      Type = 10,
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
    MonsterCount = 4,
    MonsterInfo = {
      [ 20204301 ] = 4
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}