local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          IsSkip = true,
          Type = 36,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "薪",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638603651380595730,
          IsRemove = true,
          CustomEventName = "brifing",
          Type = 92,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_32401waiting",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          PosKey = "seller1",
          Rotation = 180,
          NPCId = 3024101,
          NPCName = "卖糖水的",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "seller2",
          Rotation = 90,
          NPCId = 3024102,
          NPCName = "卖榴莲的",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "seller3",
          Rotation = 180,
          NPCId = 3024103,
          NPCName = "卖月饼的",
          Type = 0,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 3,
          Type = 86,
          Timeout = 0.0
        },
        {

          KeyName = "M1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          PosKey = "BBQ",
          NPCName = "烧烤桌",
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
          NpcId = 638627925767274283,
          IsRemove = true,
          CustomEventName = "BBQ",
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
      NoPassForceDepressCameraMode = true,
      PassCamera = 111,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
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

          ObjName = "/Root/Level1/324",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/6/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/17/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          Key = "trigger",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 3224101,
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
              Timeout = 0.0,
              TimeoutKey = "HJEljPba"
            },
            {

              TimelineName = "timeline_32401hello",
              Fadein = 1.0,
              Fadeout = 1.0,
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

              TimelineName = "timeline_32401chase",
              IsPlay = false,
              Type = 110,
              Timeout = 0.1,
              TimeoutKey = "aMKqrITo"
            }
          },
          ValidInTower = false
        },
        {

          Key = "dashBird",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = empty,
          FinishMarkVariable = "enter",
          ValidInTower = false
        },
        {

          Key = "urge",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 2224108,
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

              TimelineName = "timeline_32401hello2",
              Fadein = 2.0,
              Fadeout = 2.0,
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

              TimelineName = "timeline_32401waiting2",
              IsPlay = false,
              Type = 110,
              Timeout = 0.1,
              TimeoutKey = "KxuUjnhq"
            },
            {

              GroupID = 3,
              Type = 86,
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

          StoryId = 2224109,
          Actions = {
            {

              PosKey = "NPC1",
              NPCName = "qUzfmRCV",
              NpcParams = {
                InteractionArea = 1.5,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638627216049364887,
              IsRemove = true,
              CustomEventName = "endTalk2224110",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "NPC2",
              NPCName = "HIgjacDh",
              NpcParams = {
                InteractionArea = 1.5,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638627216049374885,
              IsRemove = true,
              CustomEventName = "endTalk2224111",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "NPC3",
              NPCName = "eUwYIOMB",
              NpcParams = {
                InteractionArea = 1.5,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638627216049384886,
              IsRemove = true,
              CustomEventName = "endTalk2224112",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "NPC4",
              NPCName = "bzirSHZe",
              NpcParams = {
                InteractionArea = 1.5,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638627216049394887,
              IsRemove = true,
              CustomEventName = "endTalk2224113",
              Type = 92,
              Timeout = 0.0
            },
            {

              TaskId = 3240104,
              Type = 5,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "endTalk1",
          ValidInTower = false
        },
        {

          StoryId = 2224110,
          Actions = {
            {

              CondId = 32401051,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "endTalk2",
          ValidInTower = false
        },
        {

          StoryId = 2224111,
          Actions = {
            {

              CondId = 32401052,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "endTalk3",
          ValidInTower = false
        },
        {

          StoryId = 2224112,
          Actions = {
            {

              CondId = 32401053,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "endTalk4",
          ValidInTower = false
        },
        {

          StoryId = 2224113,
          Actions = {
            {

              CondId = 32401054,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "endTalk5",
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

          StoryId = 2224105,
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

              NPC = "Hero",
              Point = "M2",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.5,
              TimeoutKey = "LdZjecSf"
            },
            {

              KeyName = "food",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 1.5,
              TimeoutKey = "vpLgmPbP"
            },
            {

              ObjName = "/Root/Level/17/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_32401chaseCamera",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.5,
              Hold = 1.0,
              BlackOut = 0.5,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 1.0,
              TimeoutKey = "smzuHwAL"
            },
            {

              TimelineName = "timeline_32401chaseCamera",
              Type = 7,
              Timeout = 7.6,
              TimeoutKey = "DgtaHYIg"
            },
            {

              TimelineName = "timeline_32401birds",
              IsPlay = true,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "RfqagDOV"
            },
            {

              TimelineName = "timeline_32401chase",
              IsPlay = true,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "JQRBBTjm"
            },
            {

              TaskId = 3240102,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2224106,
          Actions = {
            {

              TimelineName = "timeline_32401hello",
              Type = 7,
              Timeout = 1.8,
              TimeoutKey = "smDJLMah"
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 1.2,
              TimeoutKey = "aORbfmyb"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2224101,
          Actions = {
            {

              ObjName = "/Root/Level/14/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_32401brifing",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0,
              TimeoutKey = "nPycHVKm"
            },
            {

              TimelineName = "timeline_32401toBuy",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0,
              TimeoutKey = "BCIDMINZ"
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 3.5,
              TimeoutKey = "kysNsiHW"
            },
            {

              TimelineName = "timeline_32401toBuy",
              IsPlay = false,
              Type = 110,
              Timeout = 3.5,
              TimeoutKey = "mcvvRBHN"
            },
            {

              FadeIn = 0.5,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 2.5,
              TimeoutKey = "oMNxSXsG"
            },
            {

              TaskGroupId = 32401,
              Type = 21,
              Timeout = 0.0
            },
            {

              IsCameraModeLocked = false,
              Type = 135,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2224108,
          Actions = {
            {

              TimelineName = "timeline_32401hello2",
              Type = 7,
              Timeout = 0.0,
              TimeoutKey = "IusIYCqj"
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

          StoryId = 2224102,
          Actions = {
            {

              CondId = 32401011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "bought1",
          ValidInTower = false
        },
        {

          StoryId = 2224103,
          Actions = {
            {

              CondId = 32401012,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "bought2",
          ValidInTower = false
        },
        {

          StoryId = 2224104,
          Actions = {
            {

              CondId = 32401013,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "bought3",
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

          NPCId = 3024101,
          Actions = {
            {

              CustomEventName = "bought1",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 3024102,
          Actions = {
            {

              CustomEventName = "bought2",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 3024103,
          Actions = {
            {

              CustomEventName = "bought3",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 3024104,
          Actions = {
            {

              CustomEventName = "endTalk",
              Type = 19,
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

      EventName = "BBQ",
      Actions = {
        {

          StoryId = 2224114,
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

      EventName = "bought1",
      Actions = {
        {

          StoryId = 2224102,
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
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "closeWall3",
      Actions = {
        {

          GroupID = 3,
          Type = 87,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_32401party",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          NPCName = "烧烤桌",
          Type = 93,
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

      EventName = "endTalk2224113",
      Actions = {
        {

          StoryId = 2224113,
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
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "pickUp",
      Actions = {
        {

          StoryId = 2224107,
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
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          KeyName = "M4",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/16/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 87,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_32401waiting2",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TaskId = 3240103,
          Type = 5,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "food",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "endTalk2224109",
      Actions = {
        {

          StoryId = 2224109,
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

          Type = 71,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
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

          ObjName = "/Root/Level/11/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/01/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/0/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Type = 71,
          Timeout = 3.0,
          TimeoutKey = "JkjttyPX"
        },
        {

          StoryId = 2224105,
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
          Timeout = 3.0,
          TimeoutKey = "xPkGQmtJ"
        },
        {

          KeyName = "M4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "end",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "end",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "bought2",
      Actions = {
        {

          StoryId = 2224103,
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
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "endTalk2224110",
      Actions = {
        {

          StoryId = 2224110,
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
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "endTalk2224112",
      Actions = {
        {

          StoryId = 2224112,
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
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "endTalk2224111",
      Actions = {
        {

          StoryId = 2224111,
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
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "brifing",
      Actions = {
        {

          StoryId = 2224101,
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

          Type = 71,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_32401waiting",
          IsPlay = false,
          Type = 110,
          Timeout = 0.1,
          TimeoutKey = "jQDqnSVZ"
        },
        {

          TimelineName = "timeline_32401brifing",
          IsPlay = true,
          Type = 110,
          Timeout = 0.1,
          TimeoutKey = "nQLzcXqf"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "callBird",
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
            WallObjPath = "",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 324010102,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "closeWall3",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "end2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "end2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "bought3",
      Actions = {
        {

          StoryId = 2224104,
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
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "dropFood",
      Actions = {
        {

          PosKey = "food",
          NPCName = "我",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638603671392903414,
          IsRemove = true,
          CustomEventName = "pickUp",
          Type = 92,
          Timeout = 0.0
        },
        {

          KeyName = "food",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

          TimelineName = "timeline_32401hello",
          Actions = {
            {

              TimelineName = "timeline_32401birds",
              IsPlay = false,
              Type = 110,
              Timeout = 0.5,
              TimeoutKey = "SvgqGspl"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 4,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 324010101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "dropFood",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.6,
              TimeoutKey = "fkevVaTW"
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_32401hello2",
          Actions = {
            {

              PosKey = "M4",
              NPCName = "ScDMxnzo",
              NpcParams = {
                InteractionArea = 2.0,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638614961675238059,
              IsRemove = true,
              CustomEventName = "endTalk2224109",
              Type = 92,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_32401waiting2",
              IsPlay = true,
              Type = 110,
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

          NPCCount = 3,
          FuncNpcList = {
            "卖糖水的",
            "卖月饼的",
            "卖榴莲的"
          },
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 24,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            "bought3",
            "bought2",
            "bought1"
          },
          Actions = {
            {

              CustomEventName = "interrupt",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            "food",
            "enter"
          },
          Actions = {
            {

              CustomEventName = "callBird",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            "endTalk1",
            "endTalk2",
            "endTalk3",
            "endTalk4",
            "endTalk5"
          },
          Actions = {
            {

              TaskId = 3240105,
              Type = 5,
              Timeout = 0.0
            },
            {

              StoryId = 2224115,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = true,
              Type = 10,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_32401hello",
          Actions = {
            {

              StoryId = 2224106,
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
              TimeoutKey = "uhWGasCc"
            }
          },
          ValidInTower = false
        }
      },
      Type = 32,
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
    [ 7 ] = {
      StoryId = 2224115,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 8,
    MonsterInfo = {
      [ 20104604 ] = 4,
      [ 20204601 ] = 4
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}