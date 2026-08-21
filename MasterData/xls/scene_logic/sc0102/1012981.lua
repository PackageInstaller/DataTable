local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 9904,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 9904,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = empty,
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Type = 12,
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
    MonsterWave = 3,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0,
    EndPerform = true,
    Conditions = {
      {
        RefreshCondition = 1,
        Id = 10129811,
        param = 3,
        Name = "剩余",
        Timeout = 0.0,
        AIGroupId = 0,
        AIGroup = 0,
        AIDiffcultyTag = 0
      },
      {
        RefreshCondition = 1,
        Id = 10129812,
        param = 2,
        Name = "剩余",
        Timeout = 0.0,
        AIGroupId = 0,
        AIGroup = 0,
        AIDiffcultyTag = 0
      },
      {
        RefreshCondition = 0,
        Id = 10129813,
        param = 0,
        Name = "全部杀死",
        Timeout = 0.0,
        AIGroupId = 0,
        AIGroup = 0,
        AIDiffcultyTag = 0
      }
    },
  },
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}