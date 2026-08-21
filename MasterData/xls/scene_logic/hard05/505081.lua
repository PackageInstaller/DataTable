local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 105901,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 105901,
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

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 2,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 50508101,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 1.5,
          TimeoutKey = "pMKctMJy"
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 120,
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

          Key = "bear",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Type = 69,
          Timeout = 1.5,
          TimeoutKey = "kJmHSlPH"
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.5,
          TimeoutKey = "XDjPktGI"
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "bear",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 35,
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
    MonsterCount = 2,
    MonsterInfo = {
      [ 300100504 ] = 1,
      [ 20204705 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}