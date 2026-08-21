local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          CustomEventName = "关闭全部交互tl",
          Type = 19,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/32104/ROOM1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "START",
          NpcParams = {
            InteractionArea = 6.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638556220182936129,
          IsRemove = true,
          CustomEventName = "首次交互",
          Type = 92,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          StoryId = 2221409,
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
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 102,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 102,
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

          TaskId = 3210401,
          Type = 5,
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

          StoryId = 2221406,
          Actions = {
            {

              CustomEventName = "错误1",
              Type = 19,
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

          StoryId = 2221410,
          Actions = {
            {

              CustomEventName = "重启",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "重播",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "首次交互",
      Actions = {
        {

          StoryId = 3221401,
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
          Timeout = 4.0,
          TimeoutKey = "lpQKdvZG"
        },
        {

          CustomEventName = "播放正确顺序",
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

      EventName = "错误1",
      Actions = {
        {

          CustomEventName = "播放正确顺序",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "WenneONe"
        },
        {

          CustomEventName = "关闭全部交互tl",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "wIwRrsgU"
        },
        {

          CustomEventName = "关闭全部交互npc",
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

      EventName = "关闭全部交互tl",
      Actions = {
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-1",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-2",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-3",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-4",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-5",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-6",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
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

      EventName = "错误",
      Actions = {
        {

          StoryId = 2221406,
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

      EventName = "重启选项",
      Actions = {
        {

          StoryId = 2221410,
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

      EventName = "重启",
      Actions = {
        {

          CustomEventName = "播放正确顺序",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "GJFkFRVJ"
        },
        {

          CustomEventName = "关闭全部交互tl",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "UTWsvPDe"
        },
        {

          CustomEventName = "关闭全部交互npc",
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

      EventName = "灯光timeline刷新",
      Actions = {
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-1",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-2",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-3",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-4",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-5",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-6",
          PlatCount = 0,
          Type = 96,
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

      EventName = "关闭全部交互npc",
      Actions = {
        {

          NPCName = "C1",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "C2",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "C3",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "C4",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "C5",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "T2",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "T3",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "C6",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "START1",
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

      EventName = "正确3",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          StoryId = 2221404,
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

          CustomEventName = "关闭全部交互npc",
          Type = 19,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-5",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 0.0
        },
        {

          Camera = 102,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
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

      EventName = "正确2",
      Actions = {
        {

          PosKey = "C5T",
          NPCName = "T3",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638556055954614457,
          IsRemove = true,
          CustomEventName = "正确3",
          Type = 92,
          Timeout = 0.1,
          TimeoutKey = "mWMbZAQz"
        },
        {

          NPCName = "C5",
          Type = 93,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-3",
          PlatCount = 0,
          Type = 96,
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

      EventName = "正确1",
      Actions = {
        {

          PosKey = "C3T",
          NPCName = "T2",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638556054949919612,
          IsRemove = true,
          CustomEventName = "正确2",
          Type = 92,
          Timeout = 0.1,
          TimeoutKey = "vIBkIvhp"
        },
        {

          NPCName = "C3",
          Type = 93,
          Timeout = 0.0
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-1",
          PlatCount = 0,
          Type = 96,
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

      EventName = "播放正确顺序",
      Actions = {
        {

          CustomEventName = "设置交互NPC",
          Type = 19,
          Timeout = 11.5,
          TimeoutKey = "fFCNbYNh"
        },
        {

          CustomEventName = "正确顺序动画",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "pxUgYxAx"
        },
        {

          PosKey = "M1",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 0.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 0.5,
          TimeoutKey = "mPTzIGHN"
        },
        {

          Camera = 32104,
          IsNewConfig = false,
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

      EventName = "正确顺序动画",
      Actions = {
        {

          CustomEventName = "关闭全部交互tl",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "关闭全部交互tl",
          Type = 19,
          Timeout = 1.0,
          TimeoutKey = "vhLQNivn"
        },
        {

          CustomEventName = "关闭全部交互tl",
          Type = 19,
          Timeout = 2.5,
          TimeoutKey = "ygsffIVc"
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-1",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 3.5,
          TimeoutKey = "migSobhX"
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-1",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 5.0,
          TimeoutKey = "YIpfsRDg"
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-3",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 6.0,
          TimeoutKey = "lhEFohsD"
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-3",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 7.5,
          TimeoutKey = "LHCqtSlV"
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-5",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 8.5,
          TimeoutKey = "VltiQnHn"
        },
        {

          Path = "/Root/LevelObj/32104/ROOM1/tl-light-5",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 10.0,
          TimeoutKey = "UOzoZEAL"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "设置交互NPC",
      Actions = {
        {

          PosKey = "C1T",
          NPCName = "C1",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638555286831692474,
          IsRemove = true,
          CustomEventName = "正确1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "C2T",
          NPCName = "C2",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638555286834202467,
          IsRemove = false,
          CustomEventName = "错误",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "C3T",
          NPCName = "C3",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638555286836592464,
          IsRemove = false,
          CustomEventName = "错误",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "C4T",
          NPCName = "C4",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638555286839052458,
          IsRemove = false,
          CustomEventName = "错误",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "C5T",
          NPCName = "C5",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638555286856162220,
          IsRemove = false,
          CustomEventName = "错误",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "C6T",
          NPCName = "C6",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638555286864962201,
          IsRemove = false,
          CustomEventName = "错误",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "START1",
          NpcParams = {
            InteractionArea = 5.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638556923072620237,
          IsRemove = false,
          CustomEventName = "重启选项",
          Type = 92,
          Timeout = 0.0
        },
        {

          TipsId = 3210402,
          Visible = true,
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

      ConditionActions = {
        {

          StoryId = 2221410,
          StepId = 4,
          Actions = {
            {

              Key = "重播",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2221410,
          StepId = 5,
          Actions = {
            {

              Key = "重播",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}