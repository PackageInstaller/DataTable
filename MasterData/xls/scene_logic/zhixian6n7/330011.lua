local empty = {}
return
{
  Events = {
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

          ObjName = "/Root/Level/Level_02/330/SceneObj",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          StoryId = 2230101,
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

          TaskGroupId = 33001,
          Type = 21,
          Timeout = 0.0
        },
        {

          GroupId = 33001101,
          Type = 27,
          Timeout = 0.0
        },
        {

          IsSkip = true,
          Type = 36,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_330011_DaoBo",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_330011_Lichi",
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

      Actions = {
        {

          Key = "shouldDecrease",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          AddValue = -1,
          Type = 102,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "shouldDecrease",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "needReset1",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StoryId = 2230113,
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
          TimeoutKey = "NFtpsned"
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "needReset1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "needReset2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StoryId = 2230116,
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
      Type = 2,
      ConditionVariable = "needReset2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2230108,
          Actions = {
            {

              TaskId = 3300103,
              Type = 5,
              Timeout = 0.0
            },
            {

              CustomEventName = "M1生成非目标物品",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "M2生成非目标物品",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "M3生成非目标物品",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "M4生成目标物品",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "M5生成非目标物品",
              Type = 19,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000002,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              FadeIn = 0.0,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              TimelineName = "Timeline_330011_Lichi2",
              Type = 7,
              Timeout = 1.0,
              TimeoutKey = "FekMAMyl"
            },
            {

              TimelineName = "Timeline_330011_Lichi3",
              IsPlay = true,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "xGBApcqX"
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 1.0,
              TimeoutKey = "jSVLombO"
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

          StoryId = 2230109,
          Actions = {
            {

              TaskId = 3300105,
              Type = 5,
              Timeout = 0.0
            },
            {

              CustomEventName = "M1生成目标物品1",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "M2生成非目标物品",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "M3生成目标物品1",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "M4生成非目标物品",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "M5生成非目标物品",
              Type = 19,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000003,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              FadeIn = 0.0,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              TimelineName = "Timeline_330011_Lichi2",
              Type = 7,
              Timeout = 1.0,
              TimeoutKey = "gYhRiXFE"
            },
            {

              TimelineName = "Timeline_330011_Lichi3",
              IsPlay = true,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "tpmODVdF"
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 1.0,
              TimeoutKey = "DAoLWZwu"
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

          StoryId = 2230110,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              Type = 114,
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

          StoryId = 2230113,
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

              IsNeedAnimation = false,
              Type = 106,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "bornpoint",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "hwpDXEaK"
            },
            {

              StyleIndex = 2,
              InitValue = 0,
              UpInterval = 1,
              UpSpeed = 0,
              CurrRoomFinalValue = 100,
              AllRoomFinalValue = 100,
              IsNeedAnimation = false,
              Type = 101,
              Timeout = 1.0,
              TimeoutKey = "AlwuJusK"
            },
            {

              StoryId = 2230108,
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
              TimeoutKey = "IazuxITM"
            },
            {

              NPCName = "M1非目标物品",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M2非目标物品",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M3非目标物品",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M4目标物品",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M5非目标物品",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "正式直播2",
              Type = 93,
              Timeout = 0.0
            },
            {

              TimelineName = "Timeline_330011_Lichi3",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "emtKkSjC"
            },
            {

              TimelineName = "Timeline_330011_Lichi2",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = true,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 1.0,
              TimeoutKey = "ciAGLndj"
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 1.0,
              TimeoutKey = "BNICAdoL"
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

          StoryId = 2230116,
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

              IsNeedAnimation = false,
              Type = 106,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "bornpoint",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "QtNTfYLB"
            },
            {

              StyleIndex = 2,
              InitValue = 35,
              UpInterval = 1,
              UpSpeed = 0,
              CurrRoomFinalValue = 100,
              AllRoomFinalValue = 100,
              IsNeedAnimation = false,
              Type = 101,
              Timeout = 1.0,
              TimeoutKey = "okBckjxO"
            },
            {

              StoryId = 2230109,
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
              TimeoutKey = "qQAiyOeu"
            },
            {

              NPCName = "M2非目标物品",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M4非目标物品",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M5非目标物品",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "正式直播3",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M1目标物品1",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M1目标物品2",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M3目标物品1",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "M3目标物品2",
              Type = 93,
              Timeout = 0.0
            },
            {

              TimelineName = "Timeline_330011_Lichi3",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "PzfSsUbU"
            },
            {

              TimelineName = "Timeline_330011_Lichi2",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = true,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 1.0,
              TimeoutKey = "UfnWXvoW"
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 1.0,
              TimeoutKey = "BepSJCTP"
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

          StoryId = 2230101,
          Actions = {
            {

              PosKey = "M1",
              NPCName = "卷轴",
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
              NpcId = 638681497800157280,
              IsRemove = true,
              CustomEventName = "介绍卷轴",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "M2",
              NPCName = "酒",
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
              NpcId = 638681497779895354,
              IsRemove = true,
              CustomEventName = "介绍酒",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
              NPCName = "圆灯",
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
              NpcId = 638681497781315353,
              IsRemove = true,
              CustomEventName = "介绍圆灯",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "M4",
              NPCName = "伞",
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
              NpcId = 638681497782825356,
              IsRemove = true,
              CustomEventName = "介绍伞",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "M5",
              NPCName = "方灯",
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
              NpcId = 638681498101397668,
              IsRemove = true,
              CustomEventName = "介绍方灯",
              Type = 92,
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

          StoryId = 2230107,
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

              StoryId = 2230117,
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
              Timeout = 1.1,
              TimeoutKey = "RBMAQowE"
            },
            {

              StyleIndex = 2,
              InitValue = 30,
              UpInterval = 1,
              UpSpeed = 0,
              CurrRoomFinalValue = 100,
              AllRoomFinalValue = 100,
              IsNeedAnimation = false,
              Type = 101,
              Timeout = 1.1,
              TimeoutKey = "qVAIvUfv"
            },
            {

              StoryId = 2230201,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 1.1,
              TimeoutKey = "PRsgPJFb"
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 1.0,
              TimeoutKey = "zXKxhJJe"
            },
            {

              TimelineName = "Timeline_330011_Lichi",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "CKXXwoLJ"
            },
            {

              TimelineName = "Timeline_330011_Lichi2",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = true,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 1.0,
              TimeoutKey = "NDUqgGmm"
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

          StoryId = 2230117,
          Actions = {
            {

              StoryId = 2230108,
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
              TimeoutKey = "BFiLbpJh"
            },
            {

              IsNeedAnimation = false,
              Type = 106,
              Timeout = 0.8,
              TimeoutKey = "gtxYMAtw"
            },
            {

              StyleIndex = 2,
              InitValue = 0,
              UpInterval = 1,
              UpSpeed = 0,
              CurrRoomFinalValue = 100,
              AllRoomFinalValue = 100,
              IsNeedAnimation = false,
              Type = 101,
              Timeout = 1.0,
              TimeoutKey = "CTvWagWQ"
            },
            {

              FadeIn = 0.0,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              TaskId = 3300102,
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

      EventName = "正式直播2",
      Actions = {
        {

          Target = "1_33001101_0",
          MagicId = 3000001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          TaskId = 3300104,
          Type = 5,
          Timeout = 0.0
        },
        {

          StoryId = 2230109,
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
          TimeoutKey = "QryiKDFi"
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_330011_Lichi3",
          IsPlay = false,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "gIjIhFey"
        },
        {

          TimelineName = "Timeline_330011_Lichi2",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = true,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 1.0,
          TimeoutKey = "HJXmVcRQ"
        },
        {

          Target = "Hero",
          Type = 37,
          Timeout = 1.0,
          TimeoutKey = "PTsRIlLH"
        },
        {

          ObjName = "/Root/Level/Level_02/330/SceneObj/ZhiBoJian/sc06_prop_15b_pre (7)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      EventName = "M1生成目标物品1",
      Actions = {
        {

          PosKey = "M1",
          NPCName = "M1目标物品1",
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
          NpcId = 638683063604370966,
          IsRemove = true,
          CustomEventName = "目标物品交谈2",
          Type = 92,
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

      EventName = "M4生成目标物品",
      Actions = {
        {

          PosKey = "M4",
          NPCName = "ZcycAHmt",
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
          NpcId = 638683064393669388,
          IsRemove = true,
          CustomEventName = "目标物品交谈1",
          Type = 92,
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

      EventName = "M1生成目标物品2",
      Actions = {
        {

          PosKey = "M1",
          NPCName = "M1目标物品2",
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
          NpcId = 638683070738865841,
          IsRemove = true,
          CustomEventName = "目标物品交谈4",
          Type = 92,
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

      EventName = "目标物品交谈1",
      Actions = {
        {

          StoryId = 2230112,
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

          NPCName = "M1非目标物品",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "M2非目标物品",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "M3非目标物品",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "M5非目标物品",
          Type = 93,
          Timeout = 0.0
        },
        {

          PosKey = "M6",
          NPCName = "正式直播2",
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
          NpcId = 638683069165193589,
          IsRemove = true,
          CustomEventName = "正式直播2",
          Type = 92,
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

      EventName = "介绍伞",
      Actions = {
        {

          StoryId = 2230105,
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

          CondId = 33001014,
          CondValue = 1,
          Type = 31,
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

      EventName = "试播剧情",
      Actions = {
        {

          StoryId = 2230107,
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

      EventName = "介绍酒",
      Actions = {
        {

          StoryId = 2230103,
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

          CondId = 33001012,
          CondValue = 1,
          Type = 31,
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

      EventName = "介绍卷轴",
      Actions = {
        {

          StoryId = 2230102,
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

          CondId = 33001011,
          CondValue = 1,
          Type = 31,
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

      EventName = "M3生成非目标物品",
      Actions = {
        {

          PosKey = "M3",
          NPCName = "M3非目标物品",
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
          NpcId = 638682306035338895,
          IsRemove = true,
          CustomEventName = "非目标物品交谈",
          Type = 92,
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

      EventName = "M5生成非目标物品",
      Actions = {
        {

          PosKey = "M5",
          NPCName = "M5非目标物品",
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
          NpcId = 638682309528442800,
          IsRemove = true,
          CustomEventName = "非目标物品交谈",
          Type = 92,
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

      EventName = "非目标物品交谈",
      Actions = {
        {

          StoryId = 2230111,
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

      EventName = "介绍圆灯",
      Actions = {
        {

          StoryId = 2230104,
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

          CondId = 33001013,
          CondValue = 1,
          Type = 31,
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

      EventName = "正式直播3",
      Actions = {
        {

          Target = "1_33001101_0",
          MagicId = 3000001,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          TaskId = 3300106,
          Type = 5,
          Timeout = 0.0
        },
        {

          StoryId = 2230110,
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
          TimeoutKey = "vFSBYkgO"
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_330011_Lichi3",
          IsPlay = false,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "ACzCqMHC"
        },
        {

          TimelineName = "Timeline_330011_Lichi2",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = true,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 1.0,
          TimeoutKey = "HeUrnjms"
        },
        {

          Target = "Hero",
          Type = 37,
          Timeout = 1.0,
          TimeoutKey = "bvspvIbw"
        },
        {

          ObjName = "/Root/Level/Level_02/330/SceneObj/ZhiBoJian/sc06_prop_16c_pre (2)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Level_02/330/SceneObj/ZhiBoJian/sc06_prop_69_pre",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      EventName = "目标物品交谈4",
      Actions = {
        {

          StoryId = 2230115,
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

          NPCName = "M2非目标物品",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "M4非目标物品",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "M5非目标物品",
          Type = 93,
          Timeout = 0.0
        },
        {

          PosKey = "M6",
          NPCName = "正式直播3",
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
          NpcId = 638683075817455047,
          IsRemove = true,
          CustomEventName = "正式直播3",
          Type = 92,
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

      EventName = "M4生成非目标物品",
      Actions = {
        {

          PosKey = "M4",
          NPCName = "M4非目标物品",
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
          NpcId = 638682317767701399,
          IsRemove = true,
          CustomEventName = "非目标物品交谈",
          Type = 92,
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

      EventName = "M3生成目标物品1",
      Actions = {
        {

          PosKey = "M3",
          NPCName = "M3目标物品1",
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
          NpcId = 638682306363438607,
          IsRemove = true,
          CustomEventName = "目标物品交谈3",
          Type = 92,
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

      EventName = "目标物品交谈3",
      Actions = {
        {

          StoryId = 2230114,
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

          NPCName = "M1目标物品1",
          Type = 93,
          Timeout = 0.0
        },
        {

          CustomEventName = "M1生成目标物品2",
          Type = 19,
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

      EventName = "M2生成非目标物品",
      Actions = {
        {

          PosKey = "M2",
          NPCName = "M2非目标物品",
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
          NpcId = 638682305727979255,
          IsRemove = true,
          CustomEventName = "非目标物品交谈",
          Type = 92,
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

      EventName = "目标物品交谈2",
      Actions = {
        {

          StoryId = 2230114,
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

          NPCName = "M3目标物品1",
          Type = 93,
          Timeout = 0.0
        },
        {

          CustomEventName = "M3生成目标物品2",
          Type = 19,
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

      EventName = "介绍方灯",
      Actions = {
        {

          StoryId = 2230106,
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

          CondId = 33001015,
          CondValue = 1,
          Type = 31,
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

      EventName = "M3生成目标物品2",
      Actions = {
        {

          PosKey = "M3",
          NPCName = "M3目标物品2",
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
          NpcId = 638683071364476267,
          IsRemove = true,
          CustomEventName = "目标物品交谈4",
          Type = 92,
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

      EventName = "M1生成非目标物品",
      Actions = {
        {

          PosKey = "M1",
          NPCName = "M1非目标物品",
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
          NpcId = 638682303529373560,
          IsRemove = true,
          CustomEventName = "非目标物品交谈",
          Type = 92,
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

          StoryId = 2230110,
          StepId = 1,
          Actions = {
            {

              StoryId = 2230221,
              BarrageStyle = 0,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230110,
          StepId = 4,
          Actions = {
            {

              StoryId = 2230222,
              BarrageStyle = 0,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 10,
              Type = 102,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230110,
          StepId = 5,
          Actions = {
            {

              StoryId = 2230223,
              BarrageStyle = 0,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 10,
              Type = 102,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230110,
          StepId = 8,
          Actions = {
            {

              StoryId = 2230224,
              BarrageStyle = 0,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              IsNeedAnimation = false,
              Type = 106,
              Timeout = 0.0
            },
            {

              StyleIndex = 2,
              InitValue = 99,
              UpInterval = 1,
              UpSpeed = 0,
              CurrRoomFinalValue = 100,
              AllRoomFinalValue = 100,
              IsNeedAnimation = false,
              Type = 101,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2230108,
          StepId = 5,
          Actions = {
            {

              StoryId = 2230203,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 15,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 15.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230108,
          StepId = 7,
          Actions = {
            {

              StoryId = 2230204,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 25,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 25.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230108,
          StepId = 11,
          Actions = {
            {

              StoryId = 2230205,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 15,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 15.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230108,
          StepId = 12,
          Actions = {
            {

              StoryId = 2230206,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 15,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 15.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230108,
          StepId = 13,
          Actions = {
            {

              StoryId = 2230207,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 25,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 25.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230108,
          StepId = 19,
          Actions = {
            {

              StoryId = 2230208,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = -10,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = -10.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230108,
          StepId = 23,
          Actions = {
            {

              StoryId = 2230209,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230108,
          StepId = 1,
          Actions = {
            {

              StoryId = 2230202,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2230109,
          StepId = 1,
          Actions = {
            {

              StoryId = 2230210,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 5,
          Actions = {
            {

              StoryId = 2230211,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 15,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 15.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 9,
          Actions = {
            {

              StoryId = 2230212,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 5,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 5.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 11,
          Actions = {
            {

              StoryId = 2230213,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 10,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 10.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 12,
          Actions = {
            {

              StoryId = 2230214,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 20,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 20.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 13,
          Actions = {
            {

              StoryId = 2230215,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 15,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 15.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 15,
          Actions = {
            {

              StoryId = 2230216,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 10,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 10.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 16,
          Actions = {
            {

              StoryId = 2230217,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 15,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 15.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 17,
          Actions = {
            {

              StoryId = 2230218,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 15,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 15.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 21,
          Actions = {
            {

              StoryId = 2230219,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = -10,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = -10.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230109,
          StepId = 26,
          Actions = {
            {

              StoryId = 2230220,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              AddValue = 0,
              Type = 102,
              Timeout = 0.0
            },
            {

              Key = "pkValueChange",
              SyncValType = 1,
              Value = 0.0,
              selectIdx = 1,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Target = "1_33001101_0",
              MagicId = 3000004,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2230117,
          StepId = 8,
          Actions = {
            {

              AddValue = 10,
              Type = 102,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2230117,
          StepId = 13,
          Actions = {
            {

              AddValue = 20,
              Type = 102,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TaskId = 3300101,
          Actions = {
            {

              PosKey = "M6",
              NPCName = "直播间",
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
              NpcId = 638681582264081111,
              IsRemove = true,
              CustomEventName = "试播剧情",
              Type = 92,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 14,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Type = 114,
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