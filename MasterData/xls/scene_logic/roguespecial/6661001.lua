local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Key = "retreat_time",
          SyncValType = 1,
          Value = 6.0,
          selectIdx = 1,
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(125)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/sc03_bld_30b_pre(5)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(103)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(104)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(105)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/sc03_bld_30b_pre(6)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(161)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(162)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(163)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(142)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(143)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(144)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/sc03_area_06_pre/sc03_cpn_06_ground_01",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/RogueSpecial/TargetPractice-Hexagon",
          Visible = true,
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

          Intensity = 0.01,
          Type = 105,
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

          CustomEventName = "单起点顺序",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "MHXwxpYz"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "单起点顺序",
      Actions = {
        {

          GroupId = 6661001,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661002,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "zTDHAdcp"
        },
        {

          GroupId = 6661003,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "ITulPzVb"
        },
        {

          GroupId = 6661004,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "eUdCWXbU"
        },
        {

          GroupId = 6661005,
          Type = 27,
          Timeout = 4.0,
          TimeoutKey = "FRtORJav"
        },
        {

          GroupId = 6661006,
          Type = 27,
          Timeout = 5.0,
          TimeoutKey = "vmZDldpB"
        },
        {

          GroupId = 6661007,
          Type = 27,
          Timeout = 6.0,
          TimeoutKey = "kGrgvmdq"
        },
        {

          GroupId = 6661008,
          Type = 27,
          Timeout = 7.0,
          TimeoutKey = "qVUKwGVu"
        },
        {

          GroupId = 6661009,
          Type = 27,
          Timeout = 8.0,
          TimeoutKey = "zDjJXccA"
        },
        {

          GroupId = 6661010,
          Type = 27,
          Timeout = 9.0,
          TimeoutKey = "qfZbHptl"
        },
        {

          GroupId = 6661011,
          Type = 27,
          Timeout = 10.0,
          TimeoutKey = "MaktiFIg"
        },
        {

          GroupId = 6661012,
          Type = 27,
          Timeout = 11.0,
          TimeoutKey = "AiGgIMey"
        },
        {

          CustomEventName = "单起点顺序",
          Type = 19,
          Timeout = 12.0,
          TimeoutKey = "LfbYdYWS"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "双起点顺序",
      Actions = {
        {

          GroupId = 6661001,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661002,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "dmBPUqjS"
        },
        {

          GroupId = 6661003,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "NzyupaZR"
        },
        {

          GroupId = 6661004,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "AaGWdypz"
        },
        {

          GroupId = 6661005,
          Type = 27,
          Timeout = 4.0,
          TimeoutKey = "lUyfLtuA"
        },
        {

          GroupId = 6661006,
          Type = 27,
          Timeout = 5.0,
          TimeoutKey = "YbImYqdj"
        },
        {

          GroupId = 6661007,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "hojkrKSy"
        },
        {

          GroupId = 6661008,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "OpbxakCh"
        },
        {

          GroupId = 6661009,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "OnUIuHCl"
        },
        {

          GroupId = 6661010,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "eTeoKtfc"
        },
        {

          GroupId = 6661011,
          Type = 27,
          Timeout = 4.0,
          TimeoutKey = "zbtWZsWg"
        },
        {

          GroupId = 6661012,
          Type = 27,
          Timeout = 5.0,
          TimeoutKey = "MwjjXBZi"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "六角",
      Actions = {
        {

          GroupId = 6661001,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661003,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661005,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661007,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661009,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661011,
          Type = 27,
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

      EventName = "六边",
      Actions = {
        {

          GroupId = 6661002,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661004,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661006,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661008,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661010,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661012,
          Type = 27,
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}