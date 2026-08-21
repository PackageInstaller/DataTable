local empty = {}
return
{
  Events = {
    {

      Actions = empty,
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 210,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 118,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          GroupId = 10560103,
          Type = 27,
          Timeout = 0.0
        },
        {

          TimelineName = "TimeLine_juese_10560301",
          IsPlay = true,
          Type = 110,
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

      ConditionActions = {
        {

          Key = "Z1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              ContainerName = "Level",
              Names = {
                "L9"
              },
              States = {
                "0"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 1.0,
              TimeoutKey = "QNVxIBwE"
            },
            {

              Camera = 118,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              TimelineName = "TimeLine_10560301",
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

              StoryId = 5051106,
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
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4051103,
          Actions = {
            {

              StoryId = 1001051102,
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
              Timeout = 0.0
            },
            {

              TaskId = 105606,
              Type = 5,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              NPCId = 10560103,
              NPCName = "路人",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "tjGDlAyw"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 1001051102,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 10560103,
          Actions = {
            {

              StoryId = 4051103,
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
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          Rotation = 90,
          NPCId = 10560103,
          NPCName = "路人",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "nSrMLEtX"
        },
        {

          NPC = "Hero",
          Point = "M2",
          Rotate = -90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "ZyWbHdFG"
        },
        {

          TimelineName = "TimeLine_juese_10560301",
          IsPlay = false,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "GWxolMou"
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

          TimelineName = "TimeLine_10560301",
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 4,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "5",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10510613,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              TaskId = 105605,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 10,
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
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 1001051102,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 4,
    MonsterInfo = {
      [ 20204301 ] = 2,
      [ 20204601 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}