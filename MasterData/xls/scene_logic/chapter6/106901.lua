return
{
  Events = {
    {

      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 3,
            MonsterCount = 19,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10690101,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 10690102,
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
                Id = 10690103,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "enemydead",
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

          PlayBgm = "bgm_chapter6_elite",
          Type = 76,
          Timeout = 0.0
        },
        {

          TaskGroupId = 1068,
          Type = 21,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 17,
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

      NoPassCamera = 106000,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 106000,
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

          Key = "cancel_born_skill",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "enemydead",
      Actions = {
        {

          StoryId = 1001061402,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 1.0,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.0,
          StopStayTime = 0.0,
          StopFadeOutTime = 0.0,
          NoSkipStory = false,
          IsSettleStory = true,
          Type = 10,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          Type = 37,
          Timeout = 1.0,
          TimeoutKey = "iqOpYEDP"
        },
        {

          TaskId = 106801,
          Type = 5,
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
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 1001061402,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 19,
    MonsterInfo = {
      [ 20204601 ] = 3,
      [ 20204301 ] = 3,
      [ 20204401 ] = 4,
      [ 20104501 ] = 3,
      [ 20205201 ] = 2,
      [ 20105201 ] = 1,
      [ 20204901 ] = 2,
      [ 20104901 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}