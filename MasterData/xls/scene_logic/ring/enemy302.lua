local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          RandomCount = 3,
          RandomMonsterCfgList = {
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 2,
              MonsterCount = 10,
              SendWave = false,
              WaveStyle = 0,
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 23101,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                },
                {
                  RefreshCondition = 0,
                  Id = 23302,
                  param = 0,
                  Name = "全部杀死",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 2,
              MonsterCount = 8,
              SendWave = false,
              WaveStyle = 0,
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 23111,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                },
                {
                  RefreshCondition = 0,
                  Id = 23312,
                  param = 0,
                  Name = "全部杀死",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            },
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 2,
              MonsterCount = 12,
              SendWave = false,
              WaveStyle = 0,
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 23121,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                },
                {
                  RefreshCondition = 0,
                  Id = 23322,
                  param = 0,
                  Name = "全部杀死",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            }
          },
          Type = 84,
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

          Point = "center",
          Type = 3,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/air_block_obj",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_15_mod",
          Visible = true,
          IsAutoSave = false,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_23_mod",
          Visible = true,
          IsAutoSave = false,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_18_mod",
          Visible = true,
          IsAutoSave = false,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_11_mod",
          Visible = true,
          IsAutoSave = false,
          SaveType = 1,
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

      Actions = {
        {

          Group = 31131,
          Type = 65,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
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
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 0,
    MonsterInfo = empty,
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}