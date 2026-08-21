local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_04_pre (7)/sc06_prop_09_pre 3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_04_pre (8)/sc06_prop_09_pre 3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_04_pre (9)/sc06_prop_09_pre 3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_04_pre (12)/sc06_prop_09_pre 3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_04_pre (11)/sc06_prop_09_pre 3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04c/prop/sc06_prop_04_pre (10)/sc06_prop_09_pre 3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Level_01/shengjaiti/Plat2_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate",
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

      Actions = {
        {

          Key = "total_num",
          SyncValType = 1,
          Value = 6.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "lamp1",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "lamp2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "lamp3",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "lamp4",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "lamp5",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "lamp6",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "over",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
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

          ObjName = "Level/Level_02/320/32001/3200102",
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

          GroupId = 2002,
          Type = 27,
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

          TimelineName = "timeline_320010201",
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

          StoryId = 3220103,
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
          TimeoutKey = "PfnUMExm"
        },
        {

          TaskId = 3200102,
          Type = 5,
          Timeout = 0.0
        },
        {

          TipsId = 32001,
          Visible = true,
          Flip = false,
          Type = 15,
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

          PosKey = "PlatFocus",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 1.5,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 1.5,
          Type = 62,
          Timeout = 0.0
        },
        {

          Path = "Level/Level_01/320/32001/3200102/Plat/plat_loop",
          PlatCount = 1,
          PlatList = {
            "Plat"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Type = 61,
          Timeout = 0.0
        },
        {

          CustomEventName = "机关停止运转",
          Type = 19,
          Timeout = 0.0
        },
        {

          StoryId = 3220105,
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

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          Type = 60,
          Timeout = 0.0
        },
        {

          Key = "over",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TipsId = 32001,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "over",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "Plate1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200102/PressurePlate/1/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200102/Lamp/1_Off/lamp_switch_on",
              Rewind = 0.0,
              CustomEventName = "",
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200102/Lamp/3_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp3",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200102/PressurePlate/2/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200102/Lamp/2_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200102/Lamp/4_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp4",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200102/PressurePlate/3/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200102/Lamp/3_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp3",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200102/Lamp/5_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp5",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200102/PressurePlate/4/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200102/Lamp/4_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp4",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200102/Lamp/6_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp6",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
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

          Key = "TargetChange",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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

          Key = "Camera",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 32002,
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

          Key = "Camera",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 3220104,
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
          FinishMarkVariable = "tips",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "tips",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "Plate1",
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200102/PressurePlate/1/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate2",
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200102/PressurePlate/2/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate3",
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200102/PressurePlate/3/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate4",
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200102/PressurePlate/4/pressed",
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

          Key = "Camera",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 32001,
              IsNewConfig = true,
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

      Actions = {
        {

          Direction = 1,
          Type = 51,
          Timeout = 0.0
        },
        {

          KeyName = "tp1",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          TaskId = 3200103,
          Type = 5,
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

      EventName = "机关停止运转",
      Actions = {
        {

          AreaName = "Plate1",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          AreaName = "Plate2",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          AreaName = "Plate3",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          AreaName = "Plate4",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          Path = "Level/Level_02/320/32001/3200102/PressurePlate/1/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "Level/Level_02/320/32001/3200102/PressurePlate/2/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "Level/Level_02/320/32001/3200102/PressurePlate/3/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "Level/Level_02/320/32001/3200102/PressurePlate/4/pressed",
          PlatCount = 0,
          Type = 96,
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

          TimelineName = "Level/Level_02/320/32001/3200102/Lamp/1_Off/lamp_switch_on",
          Actions = {
            {

              Key = "lamp1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "Level/Level_02/320/32001/3200102/Lamp/2_Off/lamp_switch_on",
          Actions = {
            {

              Key = "lamp2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "Level/Level_02/320/32001/3200102/Lamp/3_On/lamp_switch_off",
          Actions = {
            {

              Key = "lamp3",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "Level/Level_02/320/32001/3200102/Lamp/4_Off/lamp_switch_on",
          Actions = {
            {

              Key = "lamp4",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          TimelineName = "Level/Level_02/320/32001/3200102/Lamp/5_Off/lamp_switch_on",
          Actions = {
            {

              Key = "lamp5",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "Level/Level_02/320/32001/3200102/Lamp/6_On/lamp_switch_off",
          Actions = {
            {

              Key = "lamp6",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 23,
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}