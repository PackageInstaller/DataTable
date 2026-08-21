local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 60103,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 60103,
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
    },
    {

      Actions = {
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
                Id = 6020301,
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
          Timeout = 0.0
        },
        {

          Key = "WaterOn",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          PosKey = "npc1",
          Rotation = 0,
          NPCId = 104101,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "npc2",
          Rotation = 0,
          NPCId = 104103,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "npc3",
          Rotation = 0,
          NPCId = 104104,
          Type = 0,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 104101,
          Actions = {
            {

              NPCId = 104103,
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 104104,
              Type = 1,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "mac1off",
          ValidInTower = false
        },
        {

          NPCId = 104103,
          Actions = {
            {

              NPCId = 104101,
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 104104,
              Type = 1,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "mac2off",
          ValidInTower = false
        },
        {

          NPCId = 104104,
          Actions = {
            {

              NPCId = 104101,
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 104103,
              Type = 1,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "mac3off",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "summon",
      Actions = {
        {

          CustomEventName = "summon1",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "summon2",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "summon3",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "summon4",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "summon5",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "summon6",
          Type = 19,
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

      EventName = "summon1",
      Actions = {
        {

          CustomEventName = "summon1_1",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "mac2off",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "summon2",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "summon3",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "summon4",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "summon5",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "summon6",
      Actions = empty,
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 3,
    MonsterInfo = {
      [ 3001040 ] = 1,
      [ 3001048 ] = 1,
      [ 3001049 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}