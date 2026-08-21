local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "NPC1",
          Rotation = 0,
          NPCId = 101201,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "item1",
          Rotation = 0,
          NPCId = 101203,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC2",
          Rotation = 0,
          NPCId = 101109,
          Type = 0,
          Timeout = 0.0
        },
        {

          PlatName = "plat7",
          IsMove = true,
          Anim = "7down",
          IsAutoSave = true,
          Type = 18,
          Timeout = 0.0
        },
        {

          TaskId = 101301,
          Type = 5,
          Timeout = 0.0
        },
        {

          StoryId = 201305,
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
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 104,
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

          ObjName = "LevelObj/Plat7_/FX_mark1_3_3",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "FX_mark_101305",
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

          TimelineName = "scene_fx1-14toDDG2",
          IsPlay = true,
          Type = 110,
          Timeout = 0.1,
          TimeoutKey = "WnhnFBul"
        },
        {

          Index = 4,
          Type = 72,
          Timeout = 0.25,
          TimeoutKey = "ALjJxrrd"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "focus",
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

          PlatName = "plat2",
          IsMove = true,
          Anim = "2loop",
          IsAutoSave = false,
          Type = 18,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "loop",
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

          StartRoomId = 10,
          TargetRoomId = 11,
          IsOpen = true,
          Type = 24,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "UnlockM2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "plat_loop2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PlatName = "plat2",
              IsMove = true,
              Anim = "2loop",
              IsAutoSave = false,
              Type = 18,
              Timeout = 0.0
            },
            {

              AreaName = "plat_loop2",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "loop",
          ValidInTower = false
        },
        {

          Key = "plat_up",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "plat_up",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "plat_up0",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 104,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              CustomEventName = "focus",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera7",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 117,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "plat_up0(Copy1)",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 102,
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

          Key = "book",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
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
                    Id = 10130503,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "1",
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

              Type = 35,
              Timeout = 0.0
            },
            {

              AreaName = "book",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "is_pass101305",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "camera7",
          Actions = {
            {

              Camera = 102,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
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
    },
    {

      ConditionActions = {
        {

          NPCId = 101201,
          Actions = {
            {

              StartRoomId = 9,
              TargetRoomId = 15,
              IsOpen = true,
              Type = 24,
              Timeout = 0.0
            },
            {

              StartRoomId = 10,
              TargetRoomId = 16,
              IsOpen = true,
              Type = 24,
              Timeout = 0.0
            },
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            },
            {

              Type = 46,
              Timeout = 0.0,
              TimeoutKey = "pjXztnOm"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              Type = 134,
              Timeout = 0.1,
              TimeoutKey = "kuCGjrRQ"
            }
          },
          FinishMarkVariable = "is_authorized",
          ValidInTower = true
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

          NPCId = 101203,
          Actions = {
            {

              CondId = 2014,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              storyId = 1002001,
              Type = 25,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10116,
              PosKey = "item1",
              Rotation = 90,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              Type = 124,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
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

          NPCId = 101109,
          Actions = {
            {

              PlatName = "plat7",
              IsMove = true,
              Anim = "7up",
              IsAutoSave = true,
              Type = 18,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "is_authorized",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101109,
          Actions = {
            {

              TipsId = 100161,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              PosKey = "NPC2",
              Rotation = 0,
              NPCId = 101109,
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "is_authorized",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Type = 12,
          Timeout = 0.0
        },
        {

          Index = 4,
          Type = 72,
          Timeout = 0.25,
          TimeoutKey = "iJTTxKNX"
        },
        {

          TimelineName = "scene_fx1-14toDDG2",
          IsPlay = true,
          Type = 110,
          Timeout = 0.1,
          TimeoutKey = "QcwrsCEz"
        }
      },
      FinishMarkVariable = "is_pass101305",
      ValidInTower = true,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "1",
      Actions = {
        {

          Type = 34,
          Timeout = 0.0
        },
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_common",
          Type = 76,
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

      EventName = "focus",
      Actions = {
        {

          PosKey = "NPC1",
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
          TimeoutKey = "VOpcYrCW"
        },
        {

          BackToDefault = false,
          Type = 63,
          Timeout = 4.0,
          TimeoutKey = "IWTCTtZx"
        }
      },
      FinishMarkVariable = "focus",
      ValidInTower = true,
      Type = 9,
      ConditionVariable = "focus",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "plat2",
      Actions = empty,
      FinishMarkVariable = "loop",
      ValidInTower = true,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10101CLOSE",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101_2",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101_3",
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

      EventName = "GBOX10101OPEN",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101_2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10101_3",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10101",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10108CLOSE",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10108",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10108_2",
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

      EventName = "GBOX10108OPEN",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10108",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10108_2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10108",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline1_3caozuotai",
          Actions = empty,
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

          descStoryId = 1002001,
          str = "文本剧情id",
          Actions = {
            {

              StoryId = 201312,
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
      Type = 11,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          ObjName = "LevelObj/Plat7_/FX_mark1_3_3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "FX_mark_101305",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          TimelineName = "timeline1_3caozuotai",
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
          Timeout = 1.0,
          TimeoutKey = "ZNcFoIzv"
        },
        {

          Camera = 111,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 2.0,
          TimeoutKey = "DgqueaEO"
        },
        {

          TaskId = 101302,
          Type = 5,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          PlatName = "plat7",
          IsMove = true,
          Anim = "7down",
          IsAutoSave = true,
          Type = 18,
          Timeout = 0.0
        },
        {

          PlatName = "plat2",
          IsMove = true,
          Anim = "2loop",
          IsAutoSave = false,
          Type = 18,
          Timeout = 0.0
        },
        {

          Key = "is_authorized",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Index = 4,
          Type = 72,
          Timeout = 0.0,
          TimeoutKey = "tLjMcPXD"
        },
        {

          TimelineName = "scene_fx1-14toDDG2",
          IsPlay = true,
          Type = 110,
          Timeout = 0.1,
          TimeoutKey = "PBpEslEE"
        },
        {

          StoryId = 101304,
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
          TimeoutKey = "hudEeVja"
        },
        {

          CustomEventName = "plat2",
          Type = 19,
          Timeout = 0.0
        },
        {

          Type = 134,
          Timeout = 0.1,
          TimeoutKey = "UOBVNbkt"
        }
      },
      FinishMarkVariable = "focus",
      ValidInTower = false,
      Type = 21,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10101CLOSE",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10108CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 40,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10101OPEN",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10108OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "is_authorized",
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
      [ 20101301 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}