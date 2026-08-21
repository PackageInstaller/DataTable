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
              NPCId = 3031411,
              NPCName = "sword1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "sAGLWsop"
            },
            {
              Target = "Hero",
              Enable = false,
              Type = 119,
              Timeout = 0.0
            },
            {
              TimelineName = "timeline_331_knife1",
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
              TimelineName = "timeline_331_knife1",
              Type = 7,
              Timeout = 3.5,
              TimeoutKey = "XtyRETbH"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              ObjName = "/Root/Level2/331/fatherEje/H1001022_Weapon_1_2_UI (1)/weapon/weapon_p/wp1",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {
              NPCId = 3031411,
              NPCName = "sword1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "fHRvAhuo"
            },
            {
              NPCId = 3031412,
              NPCName = "sword2",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "hWyThKLO"
            },
            {
              NPCId = 3031413,
              NPCName = "sword3",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "SMSNlbwg"
            },
            {
              NPCId = 3031414,
              NPCName = "sword4",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "XMUOrqyB"
            },
            {
              TaskId = 3310405,
              Type = 5,
              Timeout = 0.1,
              TimeoutKey = "UfpzhZhj"
            },
            {
              StoryId = 100231402,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = true,
              Type = 10,
              Timeout = 0.5,
              TimeoutKey = "NBeDOhni"
            }
          },
          ValidInTower = false
        },
        {
          IsValid = true,
          IsNeedRetain = false,
          Actions = {
            {
              NPCId = 3031411,
              NPCName = "sword1",
              Type = 1,
              Timeout = 0.1,
              TimeoutKey = "opUecjBK"
            },
            {
              PosKey = "M1",
              Rotation = 0,
              NPCId = 3031411,
              NPCName = "sword1",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "QjykAyMG"
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
