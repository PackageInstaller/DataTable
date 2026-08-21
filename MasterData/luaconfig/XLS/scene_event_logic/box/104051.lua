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
              CustomEventName = "BOX10405",
              Type = 19,
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
                    Id = 104504,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "BOX10405",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0
                  }
                }
              },
              Type = 8,
              Timeout = 0.0
            },
            {
              PosKey = "FOCUS1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 1.0,
              StopLuaScript = false,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = true,
          Actions = {
            {
              PosKey = "BOX1",
              Rotation = 0,
              NPCId = 104051,
              NPCName = "1",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "CXqAbsFE"
            },
            {
              NPCId = 104051,
              NPCName = "1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "vRuCKQml"
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
      [20104501] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}
