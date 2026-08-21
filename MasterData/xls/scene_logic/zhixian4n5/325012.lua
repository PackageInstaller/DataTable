local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M1",
          NPCName = "青",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638618273232499205,
          IsRemove = true,
          CustomEventName = "brifing",
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

      NoPassCamera = 117,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 117,
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

          TimelineName = "timeline_32502watching",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          Key = "end",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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

          StoryId = 2225201,
          Actions = {
            {

              TimelineName = "timeline_32502break",
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
              BeforeBlackIn = 0.5,
              BeforeHold = 0.5,
              BeforeBlackOut = 0.5,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0,
              TimeoutKey = "mGvqDPsz"
            },
            {

              NPC = "Hero",
              Point = "M1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.7,
              TimeoutKey = "OpmcLLUt"
            },
            {

              TimelineName = "timeline_32502break",
              Type = 7,
              Timeout = 7.5,
              TimeoutKey = "gpqqrule"
            },
            {

              TimelineName = "timeline_32502watching",
              IsPlay = false,
              Type = 110,
              Timeout = 0.6,
              TimeoutKey = "HdblPOSq"
            },
            {

              FadeIn = 0.5,
              Hold = 0.8,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 7.0,
              TimeoutKey = "euqhoXaO"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2225202,
          Actions = {
            {

              PosKey = "M2",
              NPCName = "木桩",
              NpcParams = {
                InteractionArea = 1.0,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = true,
                LongPress = true,
                LongPressTime = 1.5,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638623381979013115,
              IsRemove = true,
              CustomEventName = "repairToPractice",
              Type = 92,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2225203,
          Actions = {
            {

              GroupID = 2,
              Type = 86,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 8,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 32501201,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "interrupt",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 1.0,
              TimeoutKey = "NogUrtjm"
            },
            {

              StoryId = 3225201,
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
              Timeout = 1.5,
              TimeoutKey = "svMxCqXB"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2225205,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "M3",
              Rotate = 45.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.6,
              TimeoutKey = "HymQvnYe"
            },
            {

              TimelineName = "timeline_32502practice",
              IsPlay = false,
              Type = 110,
              Timeout = 0.8,
              TimeoutKey = "WjkdsHHd"
            },
            {

              TimelineName = "timeline_32502watching",
              IsPlay = true,
              Type = 110,
              Timeout = 0.9,
              TimeoutKey = "vwuRoIpK"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 1,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 32501202,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "play2225206",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.8,
              TimeoutKey = "thzqgUjG"
            },
            {

              TipsId = 3250201,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.5,
              TimeoutKey = "eNfteQXL"
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          StoryId = 2225206,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_32502watching",
              IsPlay = false,
              Type = 110,
              Timeout = 0.7,
              TimeoutKey = "DajCdzos"
            },
            {

              TimelineName = "timeline_32502practice2",
              IsPlay = true,
              Type = 110,
              Timeout = 0.8,
              TimeoutKey = "OHTHKsYy"
            },
            {

              NPC = "Hero",
              Point = "M1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.9,
              TimeoutKey = "HdCDbhQc"
            },
            {

              StoryId = 3225202,
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
              Timeout = 1.3,
              TimeoutKey = "NgZnDPwR"
            },
            {

              ObjName = "/Root/Level/5/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.8,
              TimeoutKey = "PiJYnubH"
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 3.0,
              TimeoutKey = "RRdJndtW"
            },
            {

              GroupID = 2,
              Type = 86,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 3.0,
              TimeoutKey = "raiOiyEb"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 100225301,
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

      EventName = "brifing",
      Actions = {
        {

          StoryId = 2225201,
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

      EventName = "interrupt",
      Actions = {
        {

          PosKey = "M3",
          NPCName = "qing",
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
          NpcId = 638622906995930707,
          IsRemove = true,
          CustomEventName = "play2225205",
          Type = 92,
          Timeout = 5.0,
          TimeoutKey = "hJZQSnCa"
        },
        {

          TaskId = 3250104,
          Type = 5,
          Timeout = 5.0,
          TimeoutKey = "gIJREvnT"
        },
        {

          Camera = 32501,
          IsNewConfig = true,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 1.0,
          TimeoutKey = "LllPJLNv"
        },
        {

          Tips = "1020",
          Duration = 5.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0,
          TimeoutKey = "MocmGqZL"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "play2225205",
      Actions = {
        {

          StoryId = 2225205,
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

          GroupID = 2,
          Type = 87,
          Timeout = 0.0
        },
        {

          Camera = 32502,
          IsNewConfig = true,
          IsForceDepressCameraMode = true,
          Type = 11,
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

      EventName = "repairToPractice",
      Actions = {
        {

          FadeIn = 0.5,
          Hold = 0.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "M4",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.6,
          TimeoutKey = "iJwbNsYp"
        },
        {

          StoryId = 2225203,
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
          Timeout = 1.2,
          TimeoutKey = "KjlMKRUQ"
        },
        {

          TimelineName = "timeline_32502shock",
          IsPlay = false,
          Type = 110,
          Timeout = 0.7,
          TimeoutKey = "lqUIYhIx"
        },
        {

          TimelineName = "timeline_32502practice",
          IsPlay = true,
          Type = 110,
          Timeout = 0.8,
          TimeoutKey = "oVaLQncT"
        },
        {

          TaskId = 3250103,
          Type = 5,
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

      EventName = "play2225206",
      Actions = {
        {

          StoryId = 2225206,
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

          TipsId = 3250201,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.5,
          TimeoutKey = "YavsBThp"
        },
        {

          TaskId = 3250105,
          Type = 5,
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

          TimelineName = "timeline_32502break",
          Actions = {
            {

              TimelineName = "timeline_32502shock",
              IsPlay = true,
              Type = 110,
              Timeout = 0.8,
              TimeoutKey = "PgbPtLqJ"
            },
            {

              NPC = "Hero",
              Point = "M4",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.6,
              TimeoutKey = "ngkeQCZm"
            },
            {

              StoryId = 2225202,
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
              Timeout = 1.2,
              TimeoutKey = "akLtmFpv"
            },
            {

              TaskId = 3250102,
              Type = 5,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_32502watching",
              IsPlay = false,
              Type = 110,
              Timeout = 0.8,
              TimeoutKey = "vDBWLCis"
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

          TaskId = 3250106,
          Type = 5,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
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
  FinishiConditionDict = empty,
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 9,
    MonsterInfo = {
      [ 20104501 ] = 8,
      [ 3250201 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}