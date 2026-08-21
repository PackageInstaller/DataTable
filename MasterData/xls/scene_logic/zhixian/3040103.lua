local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 300109,
          NPCName = "shudui4",
          Type = 0,
          Timeout = 0.0
        },
        {

          TimelineName = "TimeLine_304010301",
          Fadein = 0.0,
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

          GroupID = 5,
          Type = 86,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "zhangai",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 3.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638306330427550188,
          IsRemove = true,
          CustomEventName = "clear",
          Type = 92,
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

          KeyName = "M2",
          IsOpen = true,
          IsContinue = true,
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

          Key = "Z1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 2204108,
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

          StoryId = 2204102,
          Actions = {
            {

              FadeIn = 0.1,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_day/sc01_chapter_01_pre/Prop/sc01_prp_08a_pre(51)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_day/sc01_chapter_01_pre/Prop/sc01_prp_08a_pre (51)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_day/sc01_chapter_01_pre/Prop/sc01_prp_08a_pre (52)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
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

          StoryId = 2204103,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              TaskId = 30403,
              Type = 5,
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

          NPCId = 300109,
          Actions = {
            {

              PosKey = "M1",
              Rotation = 0,
              NPCId = 300401,
              NPCName = "收藏品",
              Type = 0,
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

          NPCId = 300110,
          Actions = {
            {

              FadeIn = 0.1,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_day/sc01_chapter_01_pre/Prop/sc01_prp_08a_pre(51)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "WyOZkIYw"
            },
            {

              ObjName = "/Root/Change_/Change_day/sc01_chapter_01_pre/Prop/sc01_prp_08a_pre (51)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "OTnkYNKX"
            },
            {

              ObjName = "/Root/Change_/Change_day/sc01_chapter_01_pre/Prop/sc01_prp_08a_pre (52)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "gDxFjMSY"
            },
            {

              ObjName = "/Root/Change_/Change_day/wall/wall_box_01 (3)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "aiFOXSVM"
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

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear",
      Actions = {
        {

          FadeIn = 0.1,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_day/sc01_chapter_01_pre/Prop/sc01_prp_08a_pre(51)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "iMZZsfUF"
        },
        {

          ObjName = "/Root/Change_/Change_day/sc01_chapter_01_pre/Prop/sc01_prp_08a_pre (51)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "BwjuDedG"
        },
        {

          ObjName = "/Root/Change_/Change_day/sc01_chapter_01_pre/Prop/sc01_prp_08a_pre (52)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "sQIFrkPh"
        },
        {

          ObjName = "/Root/Change_/Change_day/wall/wall_box_01 (3)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "ctmAhfSt"
        },
        {

          Type = 71,
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

          CollectionId = 560104,
          Actions = {
            {

              StoryId = 2204103,
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
      Type = 29,
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