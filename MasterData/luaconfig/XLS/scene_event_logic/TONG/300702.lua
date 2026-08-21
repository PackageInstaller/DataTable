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
              NPCId = 300702,
              NPCName = "food2",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300705,
              NPCName = "food5",
              Type = 1,
              Timeout = 0.0
            },
            {
              Target = "Hero",
              MagicId = 30701021,
              Level = 0,
              Type = 16,
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
              PosKey = "N3",
              Rotation = 0,
              NPCId = 300705,
              NPCName = "food5",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "LXdDMhpF"
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
  FinishiConditionDict = empty
}
