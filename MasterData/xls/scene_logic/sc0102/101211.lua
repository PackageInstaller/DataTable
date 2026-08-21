local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          StoryId = 1012004,
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

          ObjName = "scene_timeline_anmen",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline1_2_office",
          Fadein = 0.0,
          Fadeout = 3.0,
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
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 110,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 110,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = empty,
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 100104,
          Actions = {
            {

              NPCId = 100104,
              Type = 1,
              Timeout = 0.0
            },
            {

              StoryId = 1012008,
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
        },
        {

          NPCId = 100105,
          Actions = {
            {

              NPCId = 100105,
              Type = 1,
              Timeout = 0.0
            },
            {

              StoryId = 1012009,
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
        },
        {

          NPCId = 100106,
          Actions = {
            {

              NPCId = 100106,
              Type = 1,
              Timeout = 0.0
            },
            {

              StoryId = 1012010,
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

      ConditionActions = {
        {

          StoryId = 1012010,
          Actions = {
            {

              ObjName = "scene_timeline_anmen",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline1_2_office",
              Type = 7,
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

      ConditionActions = {
        {

          TimelineName = "timeline1_2_office",
          Actions = {
            {

              TaskId = 100202,
              Type = 5,
              Timeout = 0.0
            },
            {

              PosKey = "NPC1",
              Rotation = 0,
              NPCId = 100104,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "NPC2",
              Rotation = 0,
              NPCId = 100105,
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "NPC3",
              Rotation = 0,
              NPCId = 100106,
              Type = 0,
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
    },
    {

      ConditionActions = {
        {

          StoryId = 1012004,
          Actions = {
            {

              TimelineName = "timeline1_2_office",
              Type = 7,
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

          Type = 12,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
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
    [ 4 ] = {
      StoryId = 1012010,
      Name = "播放剧情"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}