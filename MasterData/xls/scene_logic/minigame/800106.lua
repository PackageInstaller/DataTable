local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_com_c2_03_mod (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_com_c2_03_mod (2)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_bld_15d_pre (3)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_com_c2_03_mod (3)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_com_c2_03_mod (4)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/Wall",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_bld_14a_pre (255)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_bld_14a_pre (256)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_bld_14a_pre (257)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_bld_14a_pre (258)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_area_13/Building(12)/sc01_bld_14b_pre (744)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/13_SQBJ/sc01_area_13/Building(12)/sc01_bld_14b_pre (743)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/13_SQBJ/sc01_bld_15d_pre (2)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/RogueSpecial/RhythmPlat2",
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

      Actions = {
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
          ObjectName = "TeamHeads",
          IsShow = false,
          Type = 32,
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

      NoPassCamera = 66603,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 66603,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Key = "save0",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Seconds = 180,
          Text = "",
          EventName = "失败",
          Type = 66,
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

      NoPassCamera = 66603,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 66603,
      PassCameraIsNewConfig = true,
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

          CustomEventName = "机关组1",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "机关组2",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "机关组3",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "机关组4",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "移动平台组",
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

          Key = "save1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "save1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save0",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlatM1/2RhythmPlatM1_/scene_fx_RhythmPlat_dest1/timeline_dest_disappear",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ProgressValue = 1,
              TaskId = 8001021,
              Type = 126,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          Key = "save2-1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "save2-1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save2-2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save0",
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

          Key = "save2-2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "save2-2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save2-1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save0",
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

          Key = "save3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "save3",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save2-1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save2-2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlatM3/2RhythmPlatM3_/scene_fx_RhythmPlat_dest2/timeline_dest_disappear",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ProgressValue = 1,
              TaskId = 8001022,
              Type = 126,
              Timeout = 0.0
            },
            {

              Key = "save0",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "save1",
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
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "death",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              CustomEventName = "尝试传送1",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "kkviPHPh"
            },
            {

              CustomEventName = "尝试传送2-1",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "SbXUKbPs"
            },
            {

              CustomEventName = "尝试传送2-2",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "PUBzeqIn"
            },
            {

              CustomEventName = "尝试传送3",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "vUXWIKer"
            },
            {

              CustomEventName = "尝试传送0",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "sNEjAhic"
            },
            {

              Target = "Hero",
              MagicId = 3220004,
              Level = 0,
              Type = 16,
              Timeout = 0.0,
              TimeoutKey = "tUOevyvd"
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 1.5,
              TimeoutKey = "EiAEkAkO"
            },
            {

              Target = "Hero",
              MagicId = 3220004,
              Level = 0,
              Type = 16,
              Timeout = 1.5,
              TimeoutKey = "LlWYnRwk"
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 1.5,
              TimeoutKey = "HVVDZmOb"
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

          Key = "end",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              ProgressValue = 1,
              TaskId = 8001023,
              Type = 126,
              Timeout = 0.0
            },
            {

              Type = 68,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Destination/scene_fx_RhythmPlat_dest3/timeline_dest_disappear",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.1,
              TimeoutKey = "jbJlNzQr"
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

      EventName = "失败",
      Actions = {
        {

          Tips = "计时结束，挑战失败",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          AreaName = "end",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        },
        {

          IsSkip = true,
          Type = 36,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          isVictory = false,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.1,
          TimeoutKey = "vNTKxjIa"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "尝试传送0",
      Actions = {
        {

          NPC = "Hero",
          Point = "startPoint",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "startPoint",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.2,
          TimeoutKey = "NCzNvifo"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "save0",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "尝试传送1",
      Actions = {
        {

          NPC = "Hero",
          Point = "savePoint1",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "savePoint1",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.2,
          TimeoutKey = "KyjpfiGo"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "save1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "尝试传送2-1",
      Actions = {
        {

          NPC = "Hero",
          Point = "savePoint2-1",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "savePoint2-1",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.2,
          TimeoutKey = "WjfNBIbS"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "save2-1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "尝试传送2-2",
      Actions = {
        {

          NPC = "Hero",
          Point = "savePoint2-2",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "savePoint2-2",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.2,
          TimeoutKey = "YIfyikXW"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "save2-2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "尝试传送3",
      Actions = {
        {

          NPC = "Hero",
          Point = "savePoint3",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "savePoint3",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.2,
          TimeoutKey = "lVjdhiti"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "save3",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "机关组1",
      Actions = {
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat1-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat1-1"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat1-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat1-2"
          },
          Type = 96,
          Timeout = 0.75,
          TimeoutKey = "DfqkKWUg"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat1-3/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat1-3"
          },
          Type = 96,
          Timeout = 1.5,
          TimeoutKey = "dGdZnzck"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat1-4/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat1-4"
          },
          Type = 96,
          Timeout = 2.25,
          TimeoutKey = "XHuBbGyO"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat1-5/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat1-5"
          },
          Type = 96,
          Timeout = 3.0,
          TimeoutKey = "hQHNBWwV"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat1-6/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat1-6"
          },
          Type = 96,
          Timeout = 3.75,
          TimeoutKey = "WJmQYCQZ"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat1-7/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat1-7"
          },
          Type = 96,
          Timeout = 4.5,
          TimeoutKey = "rYgZAfWH"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat1-8/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat1-8"
          },
          Type = 96,
          Timeout = 5.25,
          TimeoutKey = "QGJxguZf"
        },
        {

          CustomEventName = "机关组1",
          Type = 19,
          Timeout = 6.0,
          TimeoutKey = "rKJuKevR"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "机关组2",
      Actions = {
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat2-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat2-1"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat2-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat2-2"
          },
          Type = 96,
          Timeout = 0.625,
          TimeoutKey = "LQhTYEkf"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat2-3/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat2-3"
          },
          Type = 96,
          Timeout = 1.25,
          TimeoutKey = "VZPfgOaK"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat2-4/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat2-4"
          },
          Type = 96,
          Timeout = 1.875,
          TimeoutKey = "liftDRsl"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat2-5/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat2-5"
          },
          Type = 96,
          Timeout = 2.5,
          TimeoutKey = "MRzMtHaT"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat2-6/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat2-6"
          },
          Type = 96,
          Timeout = 3.125,
          TimeoutKey = "zatetqDC"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat2-7/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat2-7"
          },
          Type = 96,
          Timeout = 3.75,
          TimeoutKey = "ziPWZoBO"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat2-8/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat2-8"
          },
          Type = 96,
          Timeout = 4.375,
          TimeoutKey = "xhnFGhRV"
        },
        {

          CustomEventName = "机关组2",
          Type = 19,
          Timeout = 5.0,
          TimeoutKey = "uKJSzpPC"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "机关组3",
      Actions = {
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-1-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-1-1"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-1-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-1-2"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-1-3/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-1-3"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-1-4/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-1-4"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-1-4/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-1-4"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-2-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-2-1"
          },
          Type = 96,
          Timeout = 1.5,
          TimeoutKey = "ipsQTKHA"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-2-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-2-2"
          },
          Type = 96,
          Timeout = 1.5,
          TimeoutKey = "NEOSngdk"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-2-3/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-2-3"
          },
          Type = 96,
          Timeout = 1.5,
          TimeoutKey = "MQiOkPoh"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-2-4/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-2-4"
          },
          Type = 96,
          Timeout = 1.5,
          TimeoutKey = "aPFzDctR"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-3-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-3-1"
          },
          Type = 96,
          Timeout = 3.0,
          TimeoutKey = "SZnDZPdN"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat3-3-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat3-3-2"
          },
          Type = 96,
          Timeout = 3.0,
          TimeoutKey = "UCXbsnCY"
        },
        {

          CustomEventName = "机关组3",
          Type = 19,
          Timeout = 4.5,
          TimeoutKey = "SWmlPfJs"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "机关组4",
      Actions = {
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-1"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-2-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-2-1"
          },
          Type = 96,
          Timeout = 0.875,
          TimeoutKey = "OtLglFBE"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-2-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-2-2"
          },
          Type = 96,
          Timeout = 0.875,
          TimeoutKey = "UOrxoLpT"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-3-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-3-1"
          },
          Type = 96,
          Timeout = 1.75,
          TimeoutKey = "JGTthZeL"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-3-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-3-2"
          },
          Type = 96,
          Timeout = 1.75,
          TimeoutKey = "hGvNkiEA"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-4-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-4-1"
          },
          Type = 96,
          Timeout = 2.625,
          TimeoutKey = "pgzIpaex"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-4-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-4-2"
          },
          Type = 96,
          Timeout = 2.625,
          TimeoutKey = "kOxCHlEc"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-5-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-5-1"
          },
          Type = 96,
          Timeout = 3.5,
          TimeoutKey = "XosJyoRU"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-5-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-5-2"
          },
          Type = 96,
          Timeout = 3.5,
          TimeoutKey = "iuqoFTAF"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-6-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-6-1"
          },
          Type = 96,
          Timeout = 4.375,
          TimeoutKey = "dJmiPQdV"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-6-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-6-2"
          },
          Type = 96,
          Timeout = 4.375,
          TimeoutKey = "JcmXnGji"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-7/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-7"
          },
          Type = 96,
          Timeout = 5.25,
          TimeoutKey = "nUIcUbSJ"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlat4-8/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlat4-8"
          },
          Type = 96,
          Timeout = 6.125,
          TimeoutKey = "kwqfTgqc"
        },
        {

          CustomEventName = "机关组4",
          Type = 19,
          Timeout = 7.0,
          TimeoutKey = "UaeWztPo"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "移动平台组",
      Actions = {
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlatM1/scene_timeline_RhythmPlat_move1",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlatM1"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlatM2-1/scene_timeline_RhythmPlat_move2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlatM2-1"
          },
          Type = 96,
          Timeout = 2.25,
          TimeoutKey = "SkfpUOEV"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlatM2-2/scene_timeline_RhythmPlat_move2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlatM2-2"
          },
          Type = 96,
          Timeout = 2.25,
          TimeoutKey = "XKENLHai"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlatM3/scene_timeline_RhythmPlat_move2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlatM3"
          },
          Type = 96,
          Timeout = 3.5,
          TimeoutKey = "gkusxQcW"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlatM4-1/scene_timeline_RhythmPlat_move2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlatM4-1"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat2/Plat/2RhythmPlatM4-2/scene_timeline_RhythmPlat_move2",
          PlatCount = 1,
          PlatList = {
            "2RhythmPlatM4-2"
          },
          Type = 96,
          Timeout = 2.25,
          TimeoutKey = "PxwKQDeA"
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
  mDefaultStartTime = false,
  mDefaultEndTime = false
}