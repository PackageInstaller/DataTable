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
              NPCId = 305022,
              Type = 1,
              Timeout = 0.0
            },
            {
              PosKey = "M5",
              Rotation = 0,
              NPCId = 305022,
              NPCName = "M5-2",
              Type = 0,
              Timeout = 0.1,
              TimeoutKey = "VEAGDVCRGER4"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = true,
          Actions = {
            {
              NPCId = 305022,
              Type = 1,
              Timeout = 0.0
            },
            {
              PosKey = "M5",
              Rotation = 0,
              NPCId = 305022,
              NPCName = "M5-2",
              Type = 0,
              Timeout = 0.1,
              TimeoutKey = "DCERGREG"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              TipsId = 3050202,
              Visible = false,
              Type = 15,
              Timeout = 0.0
            },
            {
              NPCId = 305022,
              Type = 1,
              Timeout = 0.0
            },
            {
              StoryId = 2205213,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            },
            {
              CondId = 3052011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
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
