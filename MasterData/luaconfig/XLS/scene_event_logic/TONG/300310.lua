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
              NPCId = 300306,
              NPCName = "shujiai3",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300310,
              NPCName = "shujiai6",
              Type = 1,
              Timeout = 0.0
            },
            {
              RefreshCfg = {
                Weight = 100,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 1,
                SendWave = false,
                WaveStyle = 0,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 3001,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0
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
              PosKey = "M5",
              Rotation = 0,
              NPCId = 300306,
              NPCName = "shujiai3",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "BnHZqztQ"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 22,
      ConditionVariable = "",
      IsNotCondition = false
    }
  },
  MonsterRefreshCfg = {
    Weight = 100,
    MonsterGroupId = 0,
    MonsterWave = 0,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0
  },
  FinishiConditionDict = empty,
  MonsterCountInfo = {EventCount = 1, MonsterCount = 1}
}
