local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 118,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 118,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_11_mod",
          Visible = false,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_18_mod",
          Visible = false,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_23_mod",
          Visible = false,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_15_mod",
          Visible = false,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomPlat",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          Point = "center",
          Type = 3,
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

          Type = 49,
          Timeout = 0.0
        },
        {

          Type = 22,
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

      Actions = {
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_11_mod",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_23_mod",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_18_mod",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_15_mod",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
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

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 6,
            SendWave = false,
            WaveStyle = 0,
            WallObjPath = "emptywall",
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10129902,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 10129903,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 1,
            WallObjPath = "emptywall2",
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10129901,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Type = 48,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          StatisticsIndex = 0,
          StatisticsType = 0,
          ManualCount = 0,
          FinishNotAdd = false,
          ChangeRoomReset = true,
          UnitIdStr = "",
          Type = 99,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 18,
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 7,
    MonsterInfo = {
      [ 20103001 ] = 3,
      [ 20101401 ] = 3,
      [ 20101201 ] = 1
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}