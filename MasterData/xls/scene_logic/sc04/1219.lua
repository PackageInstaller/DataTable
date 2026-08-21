local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 403210033,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill2",
          IsShow = false,
          Type = 32,
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

          Key = "story",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 5000106,
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
      ConditionVariable = "is_story",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "cancelFocus",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "100001_focus",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 100001,
          Actions = {
            {

              CustomEventName = "交互后",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "100001_interacted",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "storage2",
      Actions = {
        {

          Type = 46,
          Timeout = 5000102.0,
          TimeoutKey = "HtYcJmgj"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "交互后",
      Actions = {
        {

          TimelineName = "timeline_player1",
          Fadein = 3.0,
          Fadeout = 0.0,
          IsCanSkip = false,
          NotPauseLua = true,
          IsCloseTransparent = true,
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

          TimelineName = "scene_timeline_0_1",
          IsPlay = false,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "JRoEtLjh"
        },
        {

          TimelineName = "scene_timeline_player1",
          IsPlay = true,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "AKbIxPUP"
        },
        {

          TimelineName = "scene_timeline_player1_2",
          IsPlay = true,
          Type = 110,
          Timeout = 3.0,
          TimeoutKey = "ixlFbzcF"
        },
        {

          Key = "scene_timeline_player1_2",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 3.0,
          TimeoutKey = "uaftvCvH"
        },
        {

          StoryId = 5000103,
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
          Timeout = 5.5,
          TimeoutKey = "iHMxUcYb"
        },
        {

          StoryId = 4000101,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.0,
          PlayStayTime = 0.0,
          PlayFadeOutTime = 0.0,
          StopFadeInTime = 0.0,
          StopStayTime = 0.0,
          StopFadeOutTime = 0.0,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 9.5,
          TimeoutKey = "OsdUmdno"
        },
        {

          NPC = "Hero",
          Point = "bornpoint0_1",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 4.0,
          TimeoutKey = "hYxvoxfQ"
        },
        {

          Camera = 5,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 4.0,
          TimeoutKey = "YnWbAUCe"
        },
        {

          Key = "is_loop",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ChangeTime = 0.0,
          Type = 75,
          Timeout = 2.0,
          TimeoutKey = "TyoPStpg"
        },
        {

          Type = 71,
          Timeout = 0.0
        },
        {

          BackToDefault = false,
          Type = 63,
          Timeout = 0.0
        },
        {

          TipsId = 10010602,
          Visible = false,
          Flip = false,
          Type = 15,
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

      EventName = "聚焦石碑交互点",
      Actions = {
        {

          PosKey = "int1",
          IsOpen = true,
          CameraStyle = 0,
          Duration = 3.0,
          StopLuaScript = false,
          BackToDefault = false,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 0.0
        },
        {

          TipsId = 10010602,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 1.0,
          TimeoutKey = "qusSVgsg"
        }
      },
      FinishMarkVariable = "100001_focus",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "100001_interacted",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline0_1up",
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 4100101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "monster2",
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

              PosKey = "0_4100101_0",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 1.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 1.5,
              TimeoutKey = "HiryUQrG"
            },
            {

              Target = "God",
              MagicId = 100010101,
              Level = 0,
              Type = 16,
              Timeout = 0.3,
              TimeoutKey = "ZHsvHiWr"
            },
            {

              Target = "God",
              MagicId = 403210033,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Key = "step1",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              StoryId = 201406,
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

              ChangeTime = 1.0,
              Type = 74,
              Timeout = 0.0
            },
            {

              CustomEventName = "UIopen",
              Type = 19,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Enable = true,
              Type = 119,
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

          GuideID = 1001001,
          Actions = {
            {

              TipsId = 10010601,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 1.0,
              TimeoutKey = "eIYdtOIY"
            },
            {

              TimelineName = "scene_timeline_player1",
              Type = 7,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_FX_prologue_dim1_2",
              IsPlay = true,
              Type = 110,
              Timeout = 5.0,
              TimeoutKey = "NSHrnbSE"
            },
            {

              Target = "Hero",
              MagicId = 1000102,
              Level = 0,
              Type = 16,
              Timeout = 5.0,
              TimeoutKey = "DvvEgjRc"
            },
            {

              TimelineName = "scene_timeline_FX_prologue_dim2",
              IsPlay = true,
              Type = 110,
              Timeout = 13.0,
              TimeoutKey = "MUliCjuP"
            },
            {

              PosKey = "int1",
              Rotation = 0,
              NPCId = 100001,
              NPCName = "111",
              Type = 0,
              Timeout = 14.0,
              TimeoutKey = "MqhoQzIu"
            },
            {

              Key = "is_story",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 14.0,
              TimeoutKey = "qnSGreXo"
            },
            {

              Key = "is_loop",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              KeyName = "int1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 14.0,
              TimeoutKey = "kCchexnT"
            },
            {

              CustomEventName = "聚焦石碑交互点",
              Type = 19,
              Timeout = 20.0,
              TimeoutKey = "srsdmhGQ"
            }
          },
          ValidInTower = false
        }
      },
      Type = 15,
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
    MonsterCount = 3,
    MonsterInfo = {
      [ 2010150115 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}