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
              NPCId = 3031412,
              NPCName = "sword2",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "ZfFJORng"
            },
            {
              Target = "Hero",
              Enable = false,
              Type = 119,
              Timeout = 0.0
            },
            {
              TimelineName = "timeline_331_knife2",
              Fadein = 1.0,
              Fadeout = 1.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0
            },
            {
              TimelineName = "timeline_331_knife2",
              Type = 7,
              Timeout = 3.5,
              TimeoutKey = "skishEtm"
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              NPCId = 3031412,
              NPCName = "sword2",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "krGkgzvt"
            },
            {
              NPCId = 3031411,
              NPCName = "sword1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "PCjfryHP"
            },
            {
              NPCId = 3031413,
              NPCName = "sword3",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "RJVrsmLe"
            },
            {
              NPCId = 3031414,
              NPCName = "sword4",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "GZdgMmRL"
            },
            {
              CustomEventName = "wrongCommon",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              NPCId = 3031412,
              NPCName = "sword2",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "pkLCQcqt"
            },
            {
              PosKey = "M2",
              Rotation = 0,
              NPCId = 3031412,
              NPCName = "sword2",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "YICXyzFV"
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
