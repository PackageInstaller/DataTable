local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Change_/Change_Day/sc06_area_03/sc06_area_03a/build/sc06_area_03_build_pre/sc06_area_03_m1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_Day/sc06_area_03/sc06_area_03a/build/sc06_area_03_build_pre/sc06_area_03_build_03_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_03/sc06_area_03a/build/sc06_area_03_build_pre/build_03",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_03/sc06_area_03a/build/sc06_area_03_build_pre/sc06_area_03_m1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_03/sc06_area_03a/sc06_area_03a1_pre/wall",
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
          Value = 7.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "lamp1",
          SyncValType = 2,
          Value = true,
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
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "lamp4",
          SyncValType = 2,
          Value = true,
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
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "lamp7",
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

          ObjName = "Level/Level_02/320/32001/3200104",
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

          GroupId = 2012,
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

      Actions = {
        {

          TimelineName = "timeline_320010402",
          Fadein = 0.0,
          Fadeout = 2.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.5,
          BeforeHold = 1.0,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          Camera = 111,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 1.0,
          TimeoutKey = "UUHjAvsL"
        },
        {

          ObjName = "/Root/Level/Level_02/320/32001/3200104/Gate/sc06_build_31a_pre/TL_door1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.5,
          TimeoutKey = "emuRHzSw"
        },
        {

          CustomEventName = "机关停止运转",
          Type = 19,
          Timeout = 0.0,
          TimeoutKey = "hfDSQynF"
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 2.5,
          TimeoutKey = "oZPizsZB"
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
          Timeout = 1.0,
          TimeoutKey = "LlmBgmkV"
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

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/1/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/1_On/lamp_switch_off",
              Rewind = 0.0,
              CustomEventName = "",
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/2_Off/lamp_switch_on",
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

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/2/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/1_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/3_Off/lamp_switch_on",
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

          Key = "Plate3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/3/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/2_Off/lamp_switch_on",
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

              Path = "Level/Level_02/320/32001/3200104/Lamp/4_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
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
          ValidInTower = false
        },
        {

          Key = "Plate4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/4/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/3_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp3",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/4_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
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
          ValidInTower = false
        },
        {

          Key = "Plate5",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/5/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/4_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp4",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/5_Off/lamp_switch_on",
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

          Key = "Plate6",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/6/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/4_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp4",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/6_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
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
          ValidInTower = false
        },
        {

          Key = "Plate7",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/7/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/5_Off/lamp_switch_on",
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
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/7_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp7",
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

          Key = "Plate8",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/8/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/6_Off/lamp_switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp6",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Level_02/320/32001/3200104/Lamp/7_On/lamp_switch_off",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Key = "lamp7",
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

          Key = "tips",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "timeline_320010401",
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
              Timeout = 0.5,
              TimeoutKey = "BZbJqMKr"
            },
            {

              Camera = 32003,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.5,
              TimeoutKey = "OLRqwAyn"
            },
            {

              TipsId = 32001,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 2.0,
              TimeoutKey = "NoXYhdZR"
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

          Key = "Plate1",
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/1/pressed",
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

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/2/pressed",
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

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/3/pressed",
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

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/4/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate5",
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/5/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate6",
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/6/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate7",
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/7/pressed",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Plate8",
          Actions = {
            {

              Path = "Level/Level_02/320/32001/3200104/PressurePlate/8/pressed",
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

          AreaName = "Plate5",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          AreaName = "Plate6",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          AreaName = "Plate7",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          AreaName = "Plate8",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          Path = "Level/Level_02/320/32001/3200104/PressurePlate/1/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "LwKmBSIz"
        },
        {

          Path = "Level/Level_02/320/32001/3200104/PressurePlate/2/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "JKPeFkoF"
        },
        {

          Path = "Level/Level_02/320/32001/3200104/PressurePlate/3/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "pDTrXahN"
        },
        {

          Path = "Level/Level_02/320/32001/3200104/PressurePlate/4/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "ZbZHrwjq"
        },
        {

          Path = "Level/Level_02/320/32001/3200104/PressurePlate/5/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "LqSYoNLS"
        },
        {

          Path = "Level/Level_02/320/32001/3200104/PressurePlate/6/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "RQOSidAL"
        },
        {

          Path = "Level/Level_02/320/32001/3200104/PressurePlate/7/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "fImFoeYk"
        },
        {

          Path = "Level/Level_02/320/32001/3200104/PressurePlate/8/pressed",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "RLQccxRx"
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

          TimelineName = "Level/Level_02/320/32001/3200104/Lamp/1_On/lamp_switch_off",
          Actions = {
            {

              Key = "lamp1",
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

          TimelineName = "Level/Level_02/320/32001/3200104/Lamp/2_Off/lamp_switch_on",
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

          TimelineName = "Level/Level_02/320/32001/3200104/Lamp/3_Off/lamp_switch_on",
          Actions = {
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

          TimelineName = "Level/Level_02/320/32001/3200104/Lamp/4_On/lamp_switch_off",
          Actions = {
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
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          TimelineName = "Level/Level_02/320/32001/3200104/Lamp/5_Off/lamp_switch_on",
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

          TimelineName = "Level/Level_02/320/32001/3200104/Lamp/6_Off/lamp_switch_on",
          Actions = {
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
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          TimelineName = "Level/Level_02/320/32001/3200104/Lamp/7_On/lamp_switch_off",
          Actions = {
            {

              Key = "lamp7",
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