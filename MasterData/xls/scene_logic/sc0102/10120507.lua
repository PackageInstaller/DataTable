local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "LevelObj/anmen",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/1015/sc01_prp_19a_pre",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_workshop_sculpture",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_workshop_clock",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_door_fx1",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_door_fx2",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/09_JGZBGS/sc01_area_09/Prop/sc01_prp_02a3_pre (2)(5)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/09_JGZBGS/sc01_area_09/Prop/sc01_prp_34b_pre 9/sc01_prp_13a_pre (2)(22)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = "QAhTyzQX"
        },
        {

          ObjName = "/Root/Scene/09_JGZBGS/sc01_area_09/Prop/sc01_prp_34b_pre 9/sc01_prp_13a_pre (3)(21)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = "bbdlWZgk"
        },
        {

          ObjName = "/Root/Scene/09_JGZBGS/sc01_area_09/Prop/sc01_prp_13a_pre(13) (6)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = "qzjdcWyn"
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
        },
        {

          KeyName = "ningsha",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

          Key = "camera1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
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

          Key = "timeline1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.75,
              TimeoutKey = "TuUyNHtf"
            },
            {

              TimelineName = "scene_timeline_workshop_enji",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.5,
              Hold = 0.5,
              BlackOut = 0.5,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.5,
              BeforeHold = 0.5,
              BeforeBlackOut = 0.5,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0,
              TimeoutKey = "bbVCMVvi"
            },
            {

              CustomEventName = "播放和好剧情",
              Type = 19,
              Timeout = 9.5,
              TimeoutKey = "yLYoTyMn"
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

          Key = "end",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = empty,
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

          Key = "camera1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 102,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4010606,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 100101032,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 4010606,
          Actions = {
            {

              StoryId = 100101032,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 1.0,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.0,
              StopStayTime = 0.0,
              StopFadeOutTime = 0.0,
              NoSkipStory = false,
              IsSettleStory = true,
              Type = 10,
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

      EventName = "播放和好剧情",
      Actions = {
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_workshop_camera",
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
          Timeout = 0.25,
          TimeoutKey = "WzARSsRN"
        },
        {

          TimelineName = "scene_timeline_workshop_enji4",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0,
          TimeoutKey = "gXVWvTtc"
        },
        {

          StoryId = 4010606,
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
          TimeoutKey = "YqpHDEbJ"
        }
      },
      FinishMarkVariable = "enji2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "enji2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "播放和好剧情（10分钟后）",
      Actions = {
        {

          TimelineName = "scene_timeline_workshop_camera",
          Fadein = 0.0,
          Fadeout = 3.0,
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

          TimelineName = "scene_timeline_workshop_enji4",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          StoryId = 100101032,
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
          Timeout = 1.0,
          TimeoutKey = "IVDxODwd"
        },
        {

          Target = "Hero",
          Type = 38,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "enji4",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "enji4",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "scene_timeline_workshop_enji",
          Actions = {
            {

              CustomEventName = "播放和好剧情",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "scene_timeline_workshop_enji3",
          Actions = {
            {

              CustomEventName = "播放和好剧情（10分钟后）",
              Type = 19,
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
      StoryId = 100101032,
      Name = "剧情开始"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}