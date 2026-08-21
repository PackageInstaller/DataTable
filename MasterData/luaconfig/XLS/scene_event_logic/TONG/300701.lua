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
              NPCId = 300701,
              NPCName = "food1",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300704,
              NPCName = "food4",
              Type = 1,
              Timeout = 0.0
            },
            {
              Target = "Hero",
              MagicId = 4010007,
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
              PosKey = "N2",
              Rotation = 0,
              NPCId = 300704,
              NPCName = "food4",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "WMdVbyNo"
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
