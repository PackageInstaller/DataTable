local empty = {}
return
{
  Events = {
    {

      StoryID = 1001072501,
      Actions = {
        {

          StoryId = 1001072501,
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
        }
      },
      ValidInTower = false,
      Type = 37,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          CustomEventName = "添加NPC",
          Type = 19,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_71501",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "1",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638755568329751419,
          IsRemove = true,
          CustomEventName = "talk",
          Type = 92,
          Timeout = 0.0
        },
        {

          TaskGroupId = 10715,
          Type = 21,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "添加NPC",
      Actions = {
        {

          PosKey = "N1",
          Rotation = 83,
          NPCId = 1071501,
          NPCName = "天黎氏男人1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N3",
          Rotation = 336,
          NPCId = 1071506,
          NPCName = "暝",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N4",
          Rotation = 23,
          NPCId = 1071504,
          NPCName = "天黎氏女人2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N5",
          Rotation = 45,
          NPCId = 1071505,
          NPCName = "天黎氏男人2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N6",
          Rotation = 53,
          NPCId = 1071503,
          NPCName = "天黎氏女人1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "N7",
          Rotation = 356,
          NPCId = 1071507,
          NPCName = "天黎氏男人3",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "talk",
      Actions = {
        {

          StoryId = 4072501,
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
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4072501,
          Actions = {
            {

              TaskId = 1071501,
              Type = 5,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 35,
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