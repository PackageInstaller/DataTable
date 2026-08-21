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
              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 2,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                ActionTag = "shop",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10620102,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "BOX10603",
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
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              NPCId = 106031,
              NPCName = "1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "zaVBsWgV"
            },
            {
              PosKey = "BOX1",
              Rotation = 0,
              NPCId = 106031,
              NPCName = "1",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "JcMRZMDV"
            }
          },
          ValidInTower = false
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
    MonsterCount = 2,
    MonsterInfo = {
      [20205001] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}
