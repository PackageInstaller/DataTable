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
              PosKey = "NPC1",
              Rotation = 0,
              NPCId = 102012,
              NPCName = "1",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "NfbXUQVi"
            },
            {
              NPCId = 102012,
              NPCName = "1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "aEkBaTEx"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              TreasureChestId = 10234,
              PosKey = "B1",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "BOXEND10234",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "ZBFPaUZV"
            },
            {
              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              Type = 59,
              Timeout = 0.0
            },
            {
              NPCId = 102012,
              NPCName = "1",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "ApvdCDMS"
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
              NPCId = 102012,
              NPCName = "1",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "KZiJreVv"
            },
            {
              NPCId = 102012,
              NPCName = "1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "zMxYywuh"
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
