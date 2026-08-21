return
{
  Events = {
    {

      Actions = {
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          StoryId = 2226106,
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

          Intensity = 0.0001,
          Type = 105,
          Timeout = 0.0
        },
        {

          StartDistance = 0.0,
          Type = 123,
          Timeout = 0.0
        },
        {

          StartHeight = 0.0,
          Type = 129,
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

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
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

          Key = "cancel_born_skill",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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

          StoryId = 2226101,
          Actions = {
            {

              TimelineName = "timeline_326011_brifing",
              Type = 7,
              Timeout = 0.0,
              TimeoutKey = "vDWzzwsQ"
            },
            {

              TimelineName = "timeline_326011_purpleJump",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = false,
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

              NPC = "Hero",
              Point = "M1",
              Rotate = -180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.5,
              TimeoutKey = "XTSkOSgT"
            },
            {

              TimelineName = "timeline_326011_purpleJump",
              Type = 7,
              Timeout = 3.5,
              TimeoutKey = "tJkmWyTM"
            },
            {

              FadeIn = 0.5,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 2.9,
              TimeoutKey = "amvwTRXx"
            },
            {

              TaskId = 3260101,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2226102,
          Actions = {
            {

              PosKey = "tp4",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 1.0,
              StopLuaScript = false,
              BackToDefault = true,
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

          StoryId = 2226106,
          Actions = {
            {

              TimelineName = "timeline_326011_brifing",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.5,
              BeforeHold = 0.5,
              BeforeBlackOut = 0.5,
              IsWhite = false,
              Type = 6,
              Timeout = 4.0,
              TimeoutKey = "wCZePzQG"
            },
            {

              NPC = "Hero",
              Point = "M1",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 4.7,
              TimeoutKey = "qgbfVHWp"
            },
            {

              StoryId = 2226101,
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
              Timeout = 6.0,
              TimeoutKey = "RQRDXuyu"
            },
            {

              TaskGroupId = 32601,
              Type = 21,
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

          TimelineName = "timeline_326011_purpleJump",
          Actions = {
            {

              StoryId = 2226102,
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
              Timeout = 1.0,
              TimeoutKey = "xrqVPIGb"
            },
            {

              TimelineName = "scene_timeline_326011_foto",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0,
              TimeoutKey = "OVJAPhfq"
            },
            {

              PosKey = "M3",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 1.0,
              TimeoutKey = "FddflxLm"
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

      Actions = {
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
  FinishiConditionDict = {
    [ 4 ] = {
      StoryId = 2226102,
      Name = "4.剧情结束"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}