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
              NPCId = 300304,
              NPCName = "shujia1",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300305,
              NPCName = "shujia2",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300306,
              NPCName = "shujia3",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300308,
              NPCName = "shujia4",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300309,
              NPCName = "shujia5",
              Type = 1,
              Timeout = 0.0
            },
            {
              NPCId = 300310,
              NPCName = "shujia6",
              Type = 1,
              Timeout = 0.0
            },
            {
              PosKey = "M1",
              Rotation = 0,
              NPCId = 300313,
              NPCName = "收藏品",
              Type = 0,
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
              PosKey = "M1",
              Rotation = 0,
              NPCId = 300304,
              NPCName = "shujia1",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "SWKzopyN"
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
