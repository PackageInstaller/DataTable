local empty = {}
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

          Seconds = 120,
          Text = "挑战倒计时",
          EventName = "lose",
          Type = 66,
          Timeout = 0.0
        },
        {

          Key = "overload_target",
          SyncValType = 1,
          Value = 2.0,
          selectIdx = 1,
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
                Id = 2400301,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "lose",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
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

      EventName = "win",
      Actions = {
        {

          Tips = "1082",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          Type = 69,
          Timeout = 0.0,
          TimeoutKey = "WGmWnDYv"
        },
        {

          Type = 68,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 2.0,
          TimeoutKey = "rdaJswvq"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "lose",
      Actions = {
        {

          isVictory = false,
          isPopConfirmTips = false,
          Type = 20,
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
      [ 20105501 ] = 1
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}