local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Type = 48,
          Timeout = 2.0,
          TimeoutKey = "jeOYIPcQ"
        },
        {

          Seconds = 2.0,
          Type = 50,
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
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 3,
            MonsterCount = 9,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 108001,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 108002,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear1",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 108003,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 2.0,
          TimeoutKey = "RIyoipkX"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear1",
      Actions = {
        {

          PlayBgm = "bgm_chapter5_Boss",
          Type = 76,
          Timeout = 0.0
        },
        {

          Camera = 1081401,
          IsNewConfig = true,
          IsForceDepressCameraMode = false,
          Type = 11,
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

      EventName = "clear2",
      Actions = {
        {

          Type = 49,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.0,
          TimeoutKey = "hdIppDpQ"
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
    MonsterCount = 9,
    MonsterInfo = {
      [ 20105701 ] = 2,
      [ 20205501 ] = 2,
      [ 20105501 ] = 1,
      [ 20205601 ] = 3,
      [ 20103401 ] = 1
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}