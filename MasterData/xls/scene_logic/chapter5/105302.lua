local empty = {}
return
{
  Events = {
    {

      Actions = empty,
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

          GroupId = 10530201,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 10530202,
          Type = 27,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L2"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level_/luzhuang2/FX_luzhuang_1（2.1）",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530201",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530204",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/jiejing_G/sc05_prp_60b_pre",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10505",
          Type = 19,
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

          Key = "Z1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "TimeLne_10530201",
              Fadein = 1.0,
              Fadeout = 1.0,
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

              StoryId = 5050502,
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

          Key = "Z2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "TimeLne_10530202",
              Fadein = 1.0,
              Fadeout = 1.0,
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

          StoryId = 4050506,
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

              NPCId = 10560104,
              NPCName = "司机",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "hejcLXuR"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 2.0,
              TimeoutKey = "BncMeJbB"
            },
            {

              TaskId = 105312,
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

      ConditionActions = {
        {

          StoryId = 4050504,
          Actions = {
            {

              PosKey = "M2",
              NPCName = "水管2",
              NpcParams = {
                InteractionArea = 3.3,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = true,
                LongPressTime = 2.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5,
                PlayInteractSoundName = "Sound_Sc04_12"
              },
              Rotation = 0,
              NpcId = 638302317279444458,
              IsRemove = true,
              CustomEventName = "water2",
              Type = 92,
              Timeout = 0.1,
              TimeoutKey = "fMLZCuJY"
            },
            {

              PosKey = "M1",
              NPCName = "水管1",
              NpcParams = {
                InteractionArea = 3.3,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = true,
                LongPressTime = 2.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5,
                PlayInteractSoundName = "Sound_Sc04_12"
              },
              Rotation = 0,
              NpcId = 638302317279454191,
              IsRemove = true,
              CustomEventName = "water1",
              Type = 92,
              Timeout = 0.1,
              TimeoutKey = "HJQWPbDT"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2105305,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 4050505,
          Actions = {
            {

              PosKey = "N2",
              Rotation = 0,
              NPCId = 300604,
              NPCName = "路障",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "nJmtvWkQ"
            },
            {

              KeyName = "N2",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 3.0,
              TimeoutKey = "UTadnJUx"
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

          NPCId = 300604,
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

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (7)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "ZefLJMzV"
            },
            {

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (9)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "RzEVxRlw"
            },
            {

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (6)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "jjNrIRtx"
            },
            {

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (5)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "CTXMUQCz"
            },
            {

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (8)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "towXIVoa"
            },
            {

              PosKey = "N3",
              Rotation = 135,
              NPCId = 10560104,
              NPCName = "司机",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "bBjyCXko"
            },
            {

              Type = 71,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 10560104,
          Actions = {
            {

              StoryId = 4050506,
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

      ConditionActions = {
        {

          NPCId = 300601,
          Actions = {
            {

              StoryId = 4050504,
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

              NPCId = 300601,
              NPCName = "水管剧情1",
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 300602,
              NPCName = "水管剧情2",
              Type = 1,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 300602,
          Actions = {
            {

              StoryId = 4050504,
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

              NPCId = 300602,
              NPCName = "水管剧情2",
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 300601,
              NPCName = "水管剧情1",
              Type = 1,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 300603,
          Actions = empty,
          ValidInTower = false
        },
        {

          NPCId = 10530104,
          Actions = {
            {

              ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530204",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530206",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 1.0,
              TimeoutKey = "DMEdpliO"
            },
            {

              TimelineName = "TimeLne_10530203",
              Fadein = 0.0,
              Fadeout = 1.0,
              IsCanSkip = true,
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
              Timeout = 2.5,
              TimeoutKey = "CvaJPcAt"
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530206",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 7.0,
              TimeoutKey = "mobizdME"
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530205",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 7.0,
              TimeoutKey = "apKuCmjp"
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530202",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 5.0,
              TimeoutKey = "kmSpKFgG"
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530203",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 5.0,
              TimeoutKey = "pDPobRXL"
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530103",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 3.0,
              TimeoutKey = "wAWTnvZd"
            },
            {

              PosKey = "N2",
              Rotation = 0,
              NPCId = 300604,
              NPCName = "路障",
              Type = 0,
              Timeout = 7.0,
              TimeoutKey = "YVTDbxLj"
            },
            {

              Camera = 113,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 7.0,
              TimeoutKey = "dYohtdSI"
            },
            {

              TaskId = 105311,
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

      EventName = "BOXSTORYBUG",
      Actions = {
        {

          StoryId = 6050302,
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

          CustomEventName = "BOX10505",
          Type = 19,
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

      EventName = "water2",
      Actions = {
        {

          Key = "water2",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10510312,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb2",
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

          NPCName = "水管2",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "水管1",
          Type = 93,
          Timeout = 0.0
        },
        {

          TaskId = 105306,
          Type = 5,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/weixiuwanchengSound",
          Visible = true,
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

      EventName = "BOXEND10505",
      Actions = {
        {

          Variable = "10505",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10505CLOSE",
          Type = 19,
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

      EventName = "fix",
      Actions = {
        {

          Key = "fixover",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupID = 5,
          Type = 87,
          Timeout = 0.0
        },
        {

          GroupID = 8,
          Type = 87,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L1"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.5,
          TimeoutKey = "XHBLQmrQ"
        },
        {

          Type = 69,
          Timeout = 1.0,
          TimeoutKey = "rSsbtMCV"
        },
        {

          PosKey = "N1",
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
          Timeout = 1.5,
          TimeoutKey = "oRGYStjt"
        },
        {

          StoryId = 5050504,
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
          TimeoutKey = "XuNQpGbO"
        },
        {

          ObjName = "/Root/Level_/luzhuang1/FX_luzhuang_1（2.1） (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 2.5,
          TimeoutKey = "qsKhblAR"
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530201",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530203",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          IsNeedAnimation = true,
          Type = 106,
          Timeout = 0.5,
          TimeoutKey = "TzdpNWAa"
        },
        {

          TaskId = 105308,
          Type = 5,
          Timeout = 0.0
        },
        {

          NPCId = 10530106,
          NPCName = "维修",
          Type = 1,
          Timeout = 0.0
        },
        {

          Type = 22,
          Timeout = 0.5,
          TimeoutKey = "oaPKhBdD"
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
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

      EventName = "PREBOX10505",
      Actions = {
        {

          PosKey = "BOX1",
          Rotation = 0,
          NPCId = 105051,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level_/sc05_prp_07a_pre (2)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10505",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "water2result",
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

          GroupID = 5,
          Type = 86,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
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
          Timeout = 2.0,
          TimeoutKey = "jRqksWQS"
        },
        {

          TaskId = 105307,
          Type = 5,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          Rotation = -90,
          NPCId = 10530106,
          NPCName = "维修",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "wjwTsRLb"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "water2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb2",
      Actions = {
        {

          CustomEventName = "water1result",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "water2result",
          Type = 19,
          Timeout = 0.0
        },
        {

          StyleIndex = 1,
          InitValue = 0,
          UpInterval = 1,
          UpSpeed = 800,
          CurrRoomFinalValue = 24000,
          AllRoomFinalValue = 24000,
          IsNeedAnimation = true,
          RichEventName = "fix",
          Type = 101,
          Timeout = 4.0,
          TimeoutKey = "DZUThiUO"
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 1,
                Id = 10510317,
                param = 1,
                Name = "剩余",
                CustomEventName = "loop1",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 4.0,
          TimeoutKey = "RtTIThnE"
        },
        {

          StoryId = 5050503,
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
          TimeoutKey = "TuzQhYZX"
        },
        {

          NPC = "Hero",
          Point = "fixtp",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "isCuJnib"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb3",
      Actions = {
        {

          PosKey = "M3",
          Rotation = 0,
          NPCId = 10530104,
          NPCName = "小游戏",
          Type = 0,
          Timeout = 0.0
        },
        {

          TaskId = 105310,
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

      EventName = "loop1",
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
            EndPerform = false,
            ActionTag = "",
            Conditions = {
              {
                RefreshCondition = 1,
                Id = 10510318,
                param = 1,
                Name = "剩余",
                CustomEventName = "loop2",
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "fixover",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "water3",
      Actions = {
        {

          PosKey = "N1",
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
        },
        {

          ContainerName = "Level",
          Names = {
            "L1"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 1.0,
          TimeoutKey = "yrKcnITF"
        },
        {

          StoryId = 3105303,
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

          ObjName = "/Root/Level_/luzhuang1/FX_luzhuang_1（2.1） (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "dFAwLzSo"
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530201",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530203",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx",
          Visible = false,
          IsAutoSave = true,
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

      EventName = "water1",
      Actions = {
        {

          Key = "water1",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10510312,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb2",
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

          NPCName = "水管1",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "水管2",
          Type = 93,
          Timeout = 0.0
        },
        {

          TaskId = 105306,
          Type = 5,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/weixiuwanchengSound",
          Visible = true,
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

      EventName = "qb1",
      Actions = {
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 300601,
          NPCName = "水管剧情1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 0,
          NPCId = 300602,
          NPCName = "水管剧情2",
          Type = 0,
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

      EventName = "water4",
      Actions = {
        {

          PosKey = "N1",
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
          Timeout = 0.5,
          TimeoutKey = "RoGYeXpc"
        },
        {

          ContainerName = "Level",
          Names = {
            "L1"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 1.0,
          TimeoutKey = "QYgFsJUC"
        },
        {

          StoryId = 3105303,
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

          ObjName = "/Root/Level_/luzhuang1/FX_luzhuang_1（2.1） (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "sbyPaSAr"
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530203",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530201",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/tx",
          Visible = false,
          IsAutoSave = true,
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

      EventName = "BOX10505",
      Actions = {
        {

          TreasureChestId = 10505,
          PosKey = "BOX2",
          Rotation = -115,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10505",
          Type = 124,
          Timeout = 1.0,
          TimeoutKey = "MpOiBFJf"
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

          ObjName = "/Root/Level_/sc05_prp_07a_pre (2)",
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

      EventName = "water1result",
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

          GroupID = 8,
          Type = 86,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
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
          Timeout = 2.0,
          TimeoutKey = "rtZpXwdk"
        },
        {

          TaskId = 105307,
          Type = 5,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = -45,
          NPCId = 10530106,
          NPCName = "维修",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "JoLFRgAe"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "water1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOXSTORY",
      Actions = {
        {

          PosKey = "BOX1",
          NPCName = "PChAxqus",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = true,
            LongPressTime = 2.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638647618946896277,
          IsRemove = true,
          CustomEventName = "BOXSTORY1",
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

      EventName = "loop2",
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
            EndPerform = false,
            ActionTag = "",
            Conditions = {
              {
                RefreshCondition = 1,
                Id = 10510317,
                param = 1,
                Name = "剩余",
                CustomEventName = "loop1",
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "fixover",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "BOXSTORY1",
      Actions = {
        {

          CustomEventName = "BOX10505",
          Type = 19,
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

      EventName = "GBOX10505CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level_/BoxGuideFx/Fx_Common_BoxGuide10505",
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

      EventName = "GBOX10505OPEN",
      Actions = {
        {

          ObjName = "/Root/Level_/BoxGuideFx/Fx_Common_BoxGuide10505",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10505",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          TimelineName = "TimeLne_10530201",
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
                EndPerform = false,
                ActionTag = "",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10510311,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb1",
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

              TaskId = 105305,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "TimeLne_10530202",
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
                EndPerform = true,
                ActionTag = "",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10510313,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb3",
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

              TaskId = 105309,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "TimeLne_10530203",
          Actions = {
            {

              StoryId = 4050505,
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
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10505OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10505CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 40,
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
    EventCount = 7,
    MonsterCount = 27,
    MonsterInfo = {
      [ 20204601 ] = 8,
      [ 20204301 ] = 8,
      [ 20204401 ] = 6,
      [ 20104501 ] = 2,
      [ 20304402 ] = 1,
      [ 20104601 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}