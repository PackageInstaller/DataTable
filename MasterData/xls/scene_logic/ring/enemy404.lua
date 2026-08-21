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
              MonsterCount = 6,
              SendWave = false,
              WaveStyle = 0,
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 24201,
                  param = 0,
                  Name = "全部杀死",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                },
                {
                  RefreshCondition = 0,
                  Id = 24202,
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
                  Id = 24211,
                  param = 0,
                  Name = "全部杀死",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                },
                {
                  RefreshCondition = 0,
                  Id = 24212,
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
              MonsterCount = 6,
              SendWave = false,
              WaveStyle = 0,
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 24221,
                  param = 0,
                  Name = "全部杀死",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                },
                {
                  RefreshCondition = 0,
                  Id = 24222,
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
        },
        {

          GroupId = 241001,
          Type = 27,
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

      NoPassCamera = 118,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 118,
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