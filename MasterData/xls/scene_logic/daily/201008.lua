return
{
  Events = {
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

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 10,
            SendWave = false,
            WaveStyle = 0,
            WallObjPath = "emptywall",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 20100801,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 20100802,
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
          Timeout = 0.0
        },
        {

          Type = 48,
          Timeout = 0.0
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
    EndPerform = true
  },
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 10,
    MonsterInfo = {
      [ 20103701 ] = 4,
      [ 20104101 ] = 1,
      [ 20103502 ] = 1,
      [ 20103501 ] = 1,
      [ 20103503 ] = 1,
      [ 20102701 ] = 2
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}