local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M1",
          Rotation = 90,
          NPCId = 3031311,
          NPCName = "族人1",
          Type = 0,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_331_aldeanos",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_331_aldeano",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Level_02/331/eggs",
          Visible = true,
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

      NoPassCamera = 113,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = true,
      PassCamera = 113,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
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

          IsSkip = true,
          Type = 36,
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

          StoryId = 100231301,
          Actions = {
            {

              StoryId = 2231301,
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
              Timeout = 0.0,
              TimeoutKey = ""
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2231301,
          Actions = {
            {

              FadeIn = 0.3,
              Hold = 0.5,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPCId = 3031311,
              NPCName = "族人1",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "OkYWLmWc"
            },
            {

              PosKey = "look1",
              NPCName = "除蛇1",
              NpcParams = {
                InteractionArea = 3.0,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638714167727628681,
              IsRemove = true,
              CustomEventName = "egg1",
              Type = 92,
              Timeout = 0.5,
              TimeoutKey = "EGabNqgk"
            },
            {

              PosKey = "down2",
              NPCName = "除蛇2",
              NpcParams = {
                InteractionArea = 3.0,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638715168226971949,
              IsRemove = true,
              CustomEventName = "egg2",
              Type = 92,
              Timeout = 0.5,
              TimeoutKey = "yDaaiXeV"
            },
            {

              PosKey = "down3",
              NPCName = "除蛇3",
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
              NpcId = 638715168423208882,
              IsRemove = true,
              CustomEventName = "egg3",
              Type = 92,
              Timeout = 0.5,
              TimeoutKey = "vTRFlGyY"
            },
            {

              TaskGroupId = 33103,
              Type = 21,
              Timeout = 0.3,
              TimeoutKey = "TqrucJjr"
            },
            {

              Camera = 113,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.3,
              TimeoutKey = "mWekfDyU"
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.3,
              TimeoutKey = "dggnfACp"
            },
            {

              IsCameraModeLocked = false,
              Type = 135,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2231302,
          Actions = {
            {

              CondId = 33103011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_331_egg1",
              Type = 7,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "talk1",
          ValidInTower = false
        },
        {

          StoryId = 2231303,
          Actions = {
            {

              CondId = 33103012,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_02/331/eggs/sc06_prp_54b_pre (2)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_02/331/eggs/sc06_prp_54a_pre (1)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_331_aldeano",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_331_egg2",
              Type = 7,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "talk2",
          ValidInTower = false
        },
        {

          StoryId = 2231304,
          Actions = {
            {

              CondId = 33103013,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "talk3",
          ValidInTower = false
        },
        {

          StoryId = 2231305,
          Actions = {
            {

              TimelineName = "timeline_331_snakeShowUp",
              Fadein = 1.5,
              Fadeout = 0.0,
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
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2231306,
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
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "egg1",
      Actions = {
        {

          StoryId = 2231302,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.0,
          PlayStayTime = 0.0,
          PlayFadeOutTime = 0.0,
          StopFadeInTime = 0.0,
          StopStayTime = 0.0,
          StopFadeOutTime = 0.0,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0,
          TimeoutKey = "RAGBSTQi"
        },
        {

          TimelineName = "timeline_331_egg1",
          Fadein = 1.0,
          Fadeout = 1.0,
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
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "egg2",
      Actions = {
        {

          StoryId = 2231303,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.3,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.3,
          StopFadeInTime = 0.3,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.3,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        },
        {

          Point = "look2",
          Type = 3,
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

      EventName = "egg3",
      Actions = {
        {

          StoryId = 2231304,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.3,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.3,
          StopFadeInTime = 0.3,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.3,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        },
        {

          Point = "look3",
          Type = 3,
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

      EventName = "defeatSnake",
      Actions = {
        {

          FadeIn = 0.5,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.5,
          TimeoutKey = "xRgYiwEG"
        },
        {

          TaskId = 3310302,
          Type = 5,
          Timeout = 1.0,
          TimeoutKey = "FAltbRnB"
        },
        {

          ObjName = "/Root/Level/Level_02/331/eggs",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.1,
          TimeoutKey = "qoRGLRNJ"
        },
        {

          NPC = "Hero",
          Point = "M1",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.3,
          TimeoutKey = "XJUrMyOm"
        },
        {

          PosKey = "bornpoint",
          Rotation = -90,
          NPCId = 3031311,
          NPCName = "族人2",
          Type = 0,
          Timeout = 1.3,
          TimeoutKey = "DbUqXKkM"
        },
        {

          StoryId = 2231306,
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
          TimeoutKey = "IbaIBsaG"
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

          StoryId = 2231301,
          StepId = 7,
          Actions = {
            {

              PosKey = "look3",
              IsOpen = true,
              CameraStyle = 1,
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

          StoryId = 2231301,
          StepId = 8,
          Actions = {
            {

              Camera = 104,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "look2",
              IsOpen = true,
              CameraStyle = 1,
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

          StoryId = 2231301,
          StepId = 9,
          Actions = {
            {

              Camera = 113,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "down1",
              IsOpen = true,
              CameraStyle = 1,
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

          StoryId = 2231301,
          StepId = 10,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
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
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2231303,
          StepId = 0,
          Actions = {
            {

              TimelineName = "timeline_331_egg2",
              Fadein = 1.0,
              Fadeout = 1.0,
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
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2231303,
          StepId = 5,
          Actions = {
            {

              ObjName = "/Root/Level/Level_02/331/eggs/sc06_prp_54a_pre (1)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Level_02/331/eggs/sc06_prp_54b_pre (2)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_331_aldeano",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0,
              TimeoutKey = "cTlmZfLU"
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

          TaskId = 3310301,
          Actions = {
            {

              FadeIn = 0.3,
              Hold = 1.0,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 0.5,
              TimeoutKey = "KPPdtITS"
            },
            {

              NPC = "Hero",
              Point = "bornpoint",
              Rotate = -90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "AhLLErIU"
            },
            {

              PosKey = "M1",
              Rotation = 90,
              NPCId = 3031311,
              NPCName = "族人1",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "LLbUlfxR"
            },
            {

              StoryId = 2231305,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.3,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.3,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 2.0,
              TimeoutKey = "BZztXVoq"
            }
          },
          ValidInTower = false
        }
      },
      Type = 14,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_331_snakeShowUp",
          Actions = {
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "M2",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "ZleHPfAG"
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 1.1,
              TimeoutKey = "VWxEYwmH"
            },
            {

              NPCId = 3031311,
              NPCName = "族人1",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "qjhItiSj"
            },
            {

              TimelineName = "scene_timeline_331_aldeanos",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "XdyVreLQ"
            },
            {

              TimelineName = "timeline_331_snakeShowUp",
              Type = 7,
              Timeout = 4.5,
              TimeoutKey = "iwPNxCBm"
            },
            {

              FadeIn = 0.3,
              Hold = 0.5,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 4.0,
              TimeoutKey = "YXFKHfyE"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 1,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 31311,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "defeatSnake",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 4.4,
              TimeoutKey = "woMQcYmX"
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

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Level_02/331/jaula",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      StoryID = 100231301,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 100231301,
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
      Type = 37,
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
    MonsterCount = 1,
    MonsterInfo = {
      [ 20104901 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}