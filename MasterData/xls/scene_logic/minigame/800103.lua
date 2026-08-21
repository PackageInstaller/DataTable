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

          ObjName = "/Root/LevelObj/RogueSpecial/RhythmPlat3",
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

          CustomEventName = "平台组1",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "平台组2",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "平台组3",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "平台组4",
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

          Key = "death",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              CustomEventName = "尝试传送0",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "sNEjAhic"
            },
            {

              CustomEventName = "尝试传送1",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "duUdizlK"
            },
            {

              CustomEventName = "尝试传送2",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "ckrUVTMy"
            },
            {

              CustomEventName = "尝试传送3",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "nlvlrkDA"
            },
            {

              Target = "Hero",
              MagicId = 3220004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
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
              TimeoutKey = "VlBBPkmT"
            },
            {

              Target = "Hero",
              MagicId = 3220004,
              Level = 0,
              Type = 16,
              Timeout = 1.5,
              TimeoutKey = "eRNdGJVI"
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 1.5,
              TimeoutKey = "XbTGtuMo"
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
              TaskId = 8001033,
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

          Key = "3RhythmPlatD1-1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD1-1/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD1-1"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D1-1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D1-1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "uMBssZjH"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D1-1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD1-2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD1-2/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD1-2"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D1-2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D1-2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "tRJjzJpD"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D1-2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD1-3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD1-3/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD1-3"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D1-3",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D1-3",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "AeOxNypj"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D1-3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD1-4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD1-4/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD1-4"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D1-4",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D1-4",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "QGvhUvld"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D1-4",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD2-1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD2-1/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD2-1"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D2-1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D2-1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "VcMOHuNL"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D2-1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD2-2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD2-2/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD2-2"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D2-2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D2-2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "aZDusnlP"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D2-2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD2-3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD2-3/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD2-3"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D2-3",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D2-3",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "mKYSTtEB"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D2-3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD2-4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD2-4/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD2-4"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D2-4",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D2-4",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "QbZXFPxI"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D2-4",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD2-5",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD2-5/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD2-5"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D2-5",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D2-5",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "IFCxdVXV"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D2-5",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD2-6",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD2-6/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD2-6"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D2-6",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D2-6",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "dgeepePF"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D2-6",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD2-7",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD2-7/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD2-7"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D2-7",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D2-7",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "vhXELPjN"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D2-7",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD3-1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD3-1/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD3-1"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D3-1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D3-1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "jFMokRLt"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D3-1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD3-2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD3-2/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD3-2"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D3-2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D3-2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "SKfvSVlP"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D3-2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD3-3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD3-3/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD3-3"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D3-3",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D3-3",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "bsNQLWGA"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D3-3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD3-4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD3-4/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD3-4"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D3-4",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D3-4",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "TULShycI"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D3-4",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD3-5",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD3-5/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD3-5"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D3-5",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D3-5",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "kLpWWgxj"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D3-5",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-1/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-1"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-1",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "MYlarrpC"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-2/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-2"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-2",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "qKbCYVHZ"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-3/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-3"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-3",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-3",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "qzPInknV"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-4/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-4"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-4",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-4",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "AoCzCtkk"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-4",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-5",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-5/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-5"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-5",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-5",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "lckwRGmo"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-5",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-6",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-6/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-6"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-6",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-6",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "NaJgFpwp"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-6",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-7",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-7/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-7"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-7",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-7",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "MSucxVBf"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-7",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-8",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-8/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-8"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-8",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-8",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "KxwQtfBS"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-8",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-9",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-9/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-9"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-9",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-9",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "BCNCRkkU"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-9",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-10",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-10/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-10"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-10",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-10",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "zoSHdfNb"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-10",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-11",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-11/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-11"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-11",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-11",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "HMAejoLh"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-11",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-12",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-12/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-12"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-12",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-12",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "oMDoqqit"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-12",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-13",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-13/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-13"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-13",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-13",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "bhaaHVTI"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-13",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-14",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-14/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-14"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-14",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-14",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "xQIHpxGX"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-14",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-15",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-15/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-15"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-15",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-15",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "BsykOvFJ"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-15",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-16",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-16/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-16"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-16",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-16",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "anRewJIP"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-16",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-17",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-17/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-17"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-17",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-17",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "gllhBNHt"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-17",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "3RhythmPlatD4-18",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlatD4-18/scene_timeline_RhythmPlat_down2",
              PlatCount = 1,
              PlatList = {
                "3RhythmPlatD4-18"
              },
              Type = 96,
              Timeout = 0.0
            },
            {

              Key = "D4-18",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Key = "D4-18",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.5,
              TimeoutKey = "lazabeap"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "D4-18",
      IsNotCondition = true,
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
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          Key = "save2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "save2",
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

              ProgressValue = 1,
              TaskId = 8001031,
              Type = 126,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Destination/scene_fx_RhythmPlat_dest1/timeline_dest_disappear",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
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

              Key = "save2",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Destination/scene_fx_RhythmPlat_dest2/timeline_dest_disappear",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ProgressValue = 1,
              TaskId = 8001032,
              Type = 126,
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

      EventName = "失败",
      Actions = {
        {

          Tips = "983",
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
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.1,
          TimeoutKey = "DqlIQWme"
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
          TimeoutKey = "neOoNcpu"
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
          TimeoutKey = "XTqEixFE"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "save1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "尝试传送2",
      Actions = {
        {

          NPC = "Hero",
          Point = "savePoint2",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "savePoint2",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.2,
          TimeoutKey = "gMhGUvzp"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "save2",
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
          TimeoutKey = "LfCVSYgy"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "save3",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "平台组1",
      Actions = {
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat2-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat2-1"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat2-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat2-2"
          },
          Type = 96,
          Timeout = 2.0,
          TimeoutKey = "bgRWFzAa"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat2-3/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat2-3"
          },
          Type = 96,
          Timeout = 4.0,
          TimeoutKey = "ZJyNyKeN"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat2-4/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat2-4"
          },
          Type = 96,
          Timeout = 2.0,
          TimeoutKey = "bJpYNefS"
        },
        {

          CustomEventName = "平台组1",
          Type = 19,
          Timeout = 6.0,
          TimeoutKey = "RvxtckiJ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "平台组2",
      Actions = {
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat3-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat3-1"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat3-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat3-2"
          },
          Type = 96,
          Timeout = 2.0,
          TimeoutKey = "dLnNqlgm"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat3-3/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat3-3"
          },
          Type = 96,
          Timeout = 2.0,
          TimeoutKey = "pdpSQAUy"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat3-4/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat3-4"
          },
          Type = 96,
          Timeout = 2.0,
          TimeoutKey = "aQcdlqRE"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat3-5/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat3-5"
          },
          Type = 96,
          Timeout = 4.0,
          TimeoutKey = "XBeoohZY"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat3-6/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat3-6"
          },
          Type = 96,
          Timeout = 4.0,
          TimeoutKey = "NlKMwwSk"
        },
        {

          CustomEventName = "平台组2",
          Type = 19,
          Timeout = 6.0,
          TimeoutKey = "PZfgtPsE"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "平台组3",
      Actions = {
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-1/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-1"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-2/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-2"
          },
          Type = 96,
          Timeout = 1.0,
          TimeoutKey = "OIfnUOqL"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-3/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-3"
          },
          Type = 96,
          Timeout = 2.0,
          TimeoutKey = "qnFWSqbn"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-4/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-4"
          },
          Type = 96,
          Timeout = 3.0,
          TimeoutKey = "JuPdlVwZ"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-5/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-5"
          },
          Type = 96,
          Timeout = 4.0,
          TimeoutKey = "GXviKpQU"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-6/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-6"
          },
          Type = 96,
          Timeout = 5.0,
          TimeoutKey = "VtCcxmXM"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-7/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-7"
          },
          Type = 96,
          Timeout = 6.0,
          TimeoutKey = "dNeCGxDu"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-8/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-8"
          },
          Type = 96,
          Timeout = 7.0,
          TimeoutKey = "uKGAhZur"
        },
        {

          CustomEventName = "平台组3",
          Type = 19,
          Timeout = 8.0,
          TimeoutKey = "kQfvABaG"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "平台组4",
      Actions = {
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-9/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-9"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-10/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-10"
          },
          Type = 96,
          Timeout = 1.5,
          TimeoutKey = "KhWTHCFc"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-11/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-11"
          },
          Type = 96,
          Timeout = 3.0,
          TimeoutKey = "JQNCfsKw"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-12/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-12"
          },
          Type = 96,
          Timeout = 4.5,
          TimeoutKey = "agnbVBfX"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-13/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-13"
          },
          Type = 96,
          Timeout = 0.0,
          TimeoutKey = "CBKijbFX"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-14/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-14"
          },
          Type = 96,
          Timeout = 1.5,
          TimeoutKey = "JxGjxlpy"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-15/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-15"
          },
          Type = 96,
          Timeout = 3.0,
          TimeoutKey = "FBlUMZNq"
        },
        {

          Path = "/Root/LevelObj/RogueSpecial/RhythmPlat3/Plat/3RhythmPlat4-16/scene_timeline_RhythmPlat_down2",
          PlatCount = 1,
          PlatList = {
            "3RhythmPlat4-16"
          },
          Type = 96,
          Timeout = 4.5,
          TimeoutKey = "IkXghyzk"
        },
        {

          CustomEventName = "平台组4",
          Type = 19,
          Timeout = 6.0,
          TimeoutKey = "eanfgxOS"
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