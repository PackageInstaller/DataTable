local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Key = "qian_night",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Intensity = 0.03,
          Type = 105,
          Timeout = 0.0
        },
        {

          StartDistance = 30.0,
          Type = 123,
          Timeout = 0.0
        },
        {

          StatisticsIndex = 1,
          StatisticsType = 2,
          ManualCount = 60,
          FinishNotAdd = true,
          ChangeRoomReset = true,
          EventName = "qb",
          UnitIdStr = "",
          Type = 99,
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

      NoPassCamera = 40101,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 40101,
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

          Enable = true,
          Type = 120,
          Timeout = 0.0
        },
        {

          Type = 48,
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          GroupId = 401101,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 401102,
          Type = 27,
          Timeout = 10.0,
          TimeoutKey = "mlPksDHj"
        },
        {

          GroupId = 401103,
          Type = 27,
          Timeout = 20.0,
          TimeoutKey = "KJAGjlRP"
        },
        {

          GroupId = 401104,
          Type = 27,
          Timeout = 30.0,
          TimeoutKey = "OLmJplZs"
        },
        {

          GroupId = 401105,
          Type = 27,
          Timeout = 40.0,
          TimeoutKey = "gmQmHVkT"
        },
        {

          GroupId = 401106,
          Type = 27,
          Timeout = 50.0,
          TimeoutKey = "FaEKvPva"
        },
        {

          Tips = "961",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 8.0,
          TimeoutKey = "qwUgBXnP"
        },
        {

          Tips = "961",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 18.0,
          TimeoutKey = "UxTlcxuD"
        },
        {

          Tips = "961",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 28.0,
          TimeoutKey = "rpMavdiI"
        },
        {

          Tips = "961",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 38.0,
          TimeoutKey = "pQbswVqG"
        },
        {

          Tips = "961",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 48.0,
          TimeoutKey = "vzIPMLzB"
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
                Id = 4011001,
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
          Timeout = 30.0,
          TimeoutKey = "mAWtWMkc"
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
                Id = 4011002,
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
          Timeout = 40.0,
          TimeoutKey = "XgXhmiKi"
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 3,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4011003,
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
          Timeout = 50.0,
          TimeoutKey = "NuTJUSln"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          isVictory = true,
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
    },
    {

      ConditionActions = {
        {

          TimelineName = "TimeLine_4011",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = empty,
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
    EventCount = 3,
    MonsterCount = 6,
    MonsterInfo = {
      [ 20104301 ] = 2,
      [ 20104401 ] = 2,
      [ 20104601 ] = 2
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = true
}