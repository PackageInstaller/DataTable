local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 104,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 104,
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

          Target = "Hero",
          MagicId = 19991681,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          CustomEventName = "monster0",
          Type = 19,
          Timeout = 2.0,
          TimeoutKey = "PmxFSiFn"
        },
        {

          IsSkip = true,
          Type = 36,
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

          Type = 12,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_common",
          Type = 76,
          Timeout = 1.0,
          TimeoutKey = "clmGuJpC"
        }
      },
      FinishMarkVariable = "pass1111111",
      ValidInTower = true,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "monster0",
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
            WallObjPath = "",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10110105,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 1002,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 1,
                Id = 10110106,
                param = 2,
                Name = "剩余",
                CustomEventName = "",
                Timeout = 0.0,
                AIGroupId = 1002,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 50101201,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "win",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "monster0",
      ValidInTower = false,
      Type = 9,
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
          TimeoutKey = "OyGDpfId"
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
      [ 20101501 ] = 8,
      [ 20101401 ] = 2,
      [ 20104001 ] = 2,
      [ 20104004 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}