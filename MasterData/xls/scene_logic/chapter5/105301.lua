local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M4",
          Rotation = 180,
          NPCId = 10530107,
          NPCName = "工程师",
          Type = 0,
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
      NoPassForceDepressCameraMode = false,
      PassCamera = 113,
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

          GroupId = 10530101,
          Type = 27,
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

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530101",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TaskGroupId = 1053,
          Type = 21,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
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
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "Z2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "TimeLne_10530102",
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

              StoryId = 5050501,
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

              Type = 71,
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

          StoryId = 4050502,
          Actions = {
            {

              PosKey = "M1",
              NPCName = "XTBfBBQE",
              NpcParams = {
                InteractionArea = 3.3,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = false,
                LongPress = true,
                LongPressTime = 3.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5,
                PlayInteractSoundName = "Sound_Sc04_12"
              },
              Rotation = 0,
              NpcId = 638302171916498913,
              IsRemove = true,
              CustomEventName = "XX",
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

          StoryId = 4050503,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
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

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (14)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "WbbhYvrl"
            },
            {

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (15)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "pMlCkuAm"
            },
            {

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (13)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "HwuYwtJn"
            },
            {

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (18)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "zRUikzuP"
            },
            {

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (20)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "SBdEvyDQ"
            },
            {

              ObjName = "/Root/Scene/sc05_area_52/Prop/sc05_prp_20a_pre (19)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "JWCOkEpr"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 1.5,
              TimeoutKey = "AmeedJJI"
            },
            {

              TaskId = 105304,
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

          StoryId = 1001050501,
          Actions = {
            {

              TaskId = 105301,
              Type = 5,
              Timeout = 1.5,
              TimeoutKey = "AOCjrCKJ"
            },
            {

              KeyName = "N1",
              IsOpen = true,
              IsContinue = true,
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

          NPCId = 300601,
          Actions = {
            {

              StoryId = 4050503,
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

          NPCId = 10560104,
          Actions = {
            {

              StoryId = 4050502,
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

          NPCId = 10560102,
          Actions = {
            {

              StoryId = 4050501,
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
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "QB",
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

          Type = 22,
          Timeout = 0.0
        },
        {

          PosKey = "N1",
          Rotation = 0,
          NPCId = 10560104,
          NPCName = "检查水管",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "BJybFaKZ"
        },
        {

          TaskId = 105302,
          Type = 5,
          Timeout = 2.5,
          TimeoutKey = "HZTuTesI"
        },
        {

          PosKey = "N1",
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
          Timeout = 1.5,
          TimeoutKey = "VtDIvYch"
        },
        {

          NPC = "Hero",
          Point = "N3",
          Rotate = 330.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "ZEdfikAS"
        },
        {

          NPCId = 10530107,
          NPCName = "工程师",
          Type = 1,
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

      EventName = "XX",
      Actions = {
        {

          PosKey = "M2",
          Rotation = 0,
          NPCId = 300601,
          NPCName = "路障",
          Type = 0,
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

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530101",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao/TimeLine_guandao_10530103",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TaskId = 105303,
          Type = 5,
          Timeout = 0.0
        },
        {

          KeyName = "M2",
          IsOpen = true,
          IsContinue = true,
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

      ConditionActions = {
        {

          TimelineName = "TimeLne_10530101",
          Actions = empty,
          ValidInTower = false
        },
        {

          TimelineName = "TimeLne_10530102",
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
                    Id = 10530102,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "QB",
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
      [ 20204301 ] = 2,
      [ 20204601 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}