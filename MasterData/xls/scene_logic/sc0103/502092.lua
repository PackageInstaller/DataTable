local empty = {}
return
{
  Events = {
    {

      Actions = empty,
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 113,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 113,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = empty,
      ValidInTower = true,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "empty",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 13,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 50209201,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 1002,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 50209202,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 1003,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 50209201,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "win",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.5,
              TimeoutKey = "PkdvLHEE"
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
    },
    {

      EventName = "win",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.5,
          TimeoutKey = "oyKbkGdx"
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
    MonsterCount = 13,
    MonsterInfo = {
      [ 20103503 ] = 4,
      [ 20103502 ] = 4,
      [ 20102701 ] = 2,
      [ 20102806 ] = 1,
      [ 20103001 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}