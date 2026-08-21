local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          CustomEventName = "场景切换到战斗状态",
          Type = 19,
          Timeout = 0.0
        },
        {

          PlayBgm = "BGM_TIMELINE7_2_1_0",
          Type = 76,
          Timeout = 0.0
        },
        {

          Intensity = 0.07,
          Type = 105,
          Timeout = 0.0
        },
        {

          StartDistance = 25.0,
          Type = 123,
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

      NoPassCamera = 2010540101,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = true,
      PassCamera = 2010540101,
      PassCameraIsNewConfig = true,
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
                Id = 2104403,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.5,
          TimeoutKey = "hqpnSrvr"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = empty,
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "Right_claw",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear",
      Actions = {
        {

          ChangeTime = 0.0,
          Type = 75,
          Timeout = 0.0
        },
        {

          Group = 1070801001,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "bkbPqgya"
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 2.0,
          TimeoutKey = "VLpsNCZY"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "场景切换到战斗状态",
      Actions = {
        {

          ObjName = "/Root/Scene/sc0602_area_common/sc0605_area02_long_pre/sc0605_area02_long01_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/sc0605_area02_long_pre/sc0605_area02_long03a_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/sc0605_area02_long_pre/sc0605_area02_long03b_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/sc0605_area02_long_pre/sc0605_area02_long03c_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/prop/sc0605_prop_40_pre/sc0605_prop_40_m6",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/prop/sc0605_prop_40_pre/sc0605_prop_40_m7",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_02a/build/sc0602_area_02a_boss_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_02a/build/sc0602_area_02a_boss_pre (1)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/nature/sc0602_area02_dong/sc06_T4_stone_03j_pre14 (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/nature/sc0602_area02_dong/sc06_T4_stone_03j_pre9 (20)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/nature/sc0602_area02_dong/sc06_T4_stone_03j_pre9 (22)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/nature/sc0602_area02_dong/sc06_T4_stone_03j_pre9 (23)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/nature/sc0602_area02_dong/sc06_T4_stone_03i_pre13 (17)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/nature/sc0602_area02_dong/sc06_T4_stone_03i_pre13 (15)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_02g/sc0605_area_02g_pre/sc0605_area_02g_m16",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_02g/sc0605_area_02g_pre/sc0605_area_02g_m25",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_02g/sc0605_area_02g_pre/sc0605_area_02g_m24",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_02g/sc0605_area_02g_pre/sc0605_area_02g_coll",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc0602_area_common/prop/sc0605_prop_41_pre",
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
      [ 20105401 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}