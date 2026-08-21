local empty = {}
return {
  Events = {
    {
      ConditionActions = {
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              PosKey = "BOX1",
              Rotation = 0,
              NPCId = 104133,
              NPCName = "1",
              Type = 0,
              Timeout = 0.0
            },
            {
              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 0,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104604,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "标记BS03",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0
                  }
                }
              },
              Type = 8,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = true
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              PosKey = "BOX1",
              Rotation = 0,
              NPCId = 104137,
              NPCName = "1",
              Type = 0,
              Timeout = 0.0
            },
            {
              CustomEventName = "标记BS04",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = true
        }
      },
      Type = 22,
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
    MonsterCount = 3,
    MonsterInfo = {
      [20104601] = 2,
      [20104301] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}
