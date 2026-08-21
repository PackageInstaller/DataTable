local empty = {}
return {
  Events = {
    {
      ConditionActions = {
        {
          IsValid = true,
          IsNeedRetain = true,
          Actions = {
            {
              NPCId = 102013,
              NPCName = "1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "ysuyWgSz"
            },
            {
              PosKey = "NPC1",
              Rotation = 0,
              NPCId = 102013,
              NPCName = "1",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "GrEgghcd"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = true,
          Actions = {
            {
              PosKey = "NPC1",
              Rotation = 0,
              NPCId = 102013,
              NPCName = "1",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "FDluxIdf"
            },
            {
              NPCId = 102013,
              NPCName = "1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "EoCUYsBo"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              TreasureChestId = 10201,
              PosKey = "NPC1",
              Rotation = 180,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "BOXEND10201",
              Type = 124,
              Timeout = 1.1,
              TimeoutKey = "JXddSHZU"
            },
            {
              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {
              NPCId = 102014,
              NPCName = "2",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "fbgymgCK"
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}
