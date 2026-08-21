local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 3050215,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M4",
          Rotation = 0,
          NPCId = 3050231,
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

      NoPassCamera = 10403,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10403,
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

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Building/sc01_bld_14c_pre(65)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Building/sc01_bld_14b_pre(133)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Building/sc01_bld_14b_pre(134)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Building/sc01_bld_14a_pre(23)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Building/sc01_bld_14d_pre (60)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/3050203_1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Building/sc01_bld_14b_pre(132)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Building/sc01_bld_14b_pre(131)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Building/sc01_bld_14b_pre (131)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Prop/sc01_prp_07a_pre(8)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Prop/sc01_prp_07a_pre(7)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Sc01_complete/sc01_area_01/Building/sc01_area_01_pre/Prop/sc01_prp_07a_pre(6)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Sc01_complete/01_BJYXS/sc01_area_01/Prop/sc01_prp_07a_pre(7)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Sc01_complete/01_BJYXS/sc01_area_01/Building/sc01_bld_14c_pre(62)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj2/3050203_1/sc01_prp_34a_pre/sc01_prp_13a_pre (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          Key = "30533",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "LevelObj2/3050203_1/30533_Plat/305_Plat_Ani",
              Plat = "30533",
              Rewind = 1.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "30534",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "LevelObj2/3050203_1/30534_Plat/305_Plat_Ani",
              Plat = "30534",
              Rewind = 1.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "30535",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "LevelObj2/3050203_1/30535_Plat/305_Plat_Ani",
              Plat = "30535",
              Rewind = 1.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "30536",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "LevelObj2/3050203_1/30536_Plat/305_Plat_Ani",
              Plat = "30536",
              Rewind = 1.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "30537",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "LevelObj2/3050203_1/30537_Plat/305_Plat_Ani",
              Plat = "30537",
              Rewind = 1.0,
              IsSaveState = false,
              Type = 56,
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

          Key = "BACK",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NPC = "Hero",
              Point = "M3",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            },
            {

              FadeIn = 0.0,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
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

          Key = "UP",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
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

          Key = "WIN",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              Type = 22,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "WIN",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "CAM",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 101504,
              IsNewConfig = true,
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

          Key = "30532",
          Actions = {
            {

              Path = "LevelObj2/3050203_1/30532_Plat_loop",
              Plat = "30532",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
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

          Key = "CAM",
          Actions = {
            {

              Camera = 10403,
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

          StoryId = 2205224,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 305302,
              Type = 103,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 2,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 30502031,
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

              TimelineName = "tl305231",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2205225,
          Actions = {
            {

              StoryId = 2205226,
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

          StoryId = 2205227,
          Actions = {
            {

              TaskId = 305203,
              Type = 5,
              Timeout = 0.0
            },
            {

              PosKey = "interact",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 2.0,
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

              PosKey = "interact",
              NPCName = "synBUERH",
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
              NpcId = 638592533651466734,
              IsRemove = true,
              CustomEventName = "传送",
              Type = 92,
              Timeout = 0.0
            },
            {

              KeyName = "interact",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2205226,
          Actions = {
            {

              StoryId = 2205227,
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
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 3050215,
          Actions = {
            {

              StoryId = 2205224,
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

              Target = "Hero",
              MagicId = 305302,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              PosKey = "M1",
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

              TimelineName = "tl305231",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 3050216,
          Actions = {
            {

              StoryId = 2205225,
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

          NPCId = 3050218,
          Actions = {
            {

              Target = "God",
              MagicId = 305302,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              StoryId = 2205227,
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

              PosKey = "M3",
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
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 3050231,
          Actions = {
            {

              ObjName = "LevelObj2/3050203_1/FX_Sc01_door_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              PosKey = "CAM1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 2.0,
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

              KeyName = "CAM1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              TaskId = 305204,
              Type = 5,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "WIN",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "1",
      Actions = {
        {

          PosKey = "M2",
          Rotation = 0,
          NPCId = 3050216,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          IsOpen = true,
          CameraStyle = 0,
          Duration = 2.0,
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

          KeyName = "M2",
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

      EventName = "传送",
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

          NPC = "Hero",
          Point = "hero",
          Rotate = 30.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "DzeNRQBB"
        },
        {

          KeyName = "M4",
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
    MonsterCount = 2,
    MonsterInfo = {
      [ 20101101 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}