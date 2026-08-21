local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 1,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = true,
      PassCamera = 1,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
      Actions = {
        {

          TaskGroupId = 10716,
          Type = 21,
          Timeout = 0.0
        },
        {

          CustomEventName = "添加NPC",
          Type = 19,
          Timeout = 0.0
        },
        {

          Key = "talk_index1",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_71601",
          Fadein = 0.0,
          Fadeout = 2.0,
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

          PlayBgm = "storybgm_070",
          Type = 76,
          Timeout = 1.0,
          TimeoutKey = "rtKpIqeI"
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

          TimelineName = "scene_timeline_71601",
          Actions = {
            {

              CustomEventName = "添加交互",
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
    },
    {

      EventName = "添加交互",
      Actions = {
        {

          PosKey = "N1",
          NPCName = "RnLZYUSR",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638759930877744722,
          IsRemove = true,
          CustomEventName = "talk1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "N2",
          NPCName = "mbGbzwQz",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638759930877764725,
          IsRemove = true,
          CustomEventName = "talk2",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "N3",
          NPCName = "AovNaDhc",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638759930877784722,
          IsRemove = true,
          CustomEventName = "talk3",
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

      EventName = "添加NPC",
      Actions = {
        {

          PosKey = "M1",
          Rotation = 90,
          NPCId = 1071601,
          NPCName = "商贩男",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          Rotation = 270,
          NPCId = 1071602,
          NPCName = "商贩男",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M3",
          Rotation = 90,
          NPCId = 1071603,
          NPCName = "商贩男",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M4",
          Rotation = 270,
          NPCId = 1071604,
          NPCName = "商贩女",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M10",
          Rotation = 219,
          NPCId = 1071606,
          NPCName = "薪",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M11",
          Rotation = 41,
          NPCId = 1071605,
          NPCName = "阿紫",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M9",
          Rotation = -78,
          NPCId = 1071607,
          NPCName = "暝",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M12",
          Rotation = 90,
          NPCId = 1071608,
          NPCName = "黎蚩",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M13",
          Rotation = 90,
          NPCId = 1071609,
          NPCName = "小孩",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M6",
          Rotation = 180,
          NPCId = 1071610,
          NPCName = "工程师",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M7",
          Rotation = 180,
          NPCId = 1071611,
          NPCName = "车队司机",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M5",
          Rotation = 270,
          NPCId = 1071612,
          NPCName = "照顾孕妇的少女",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M8",
          Rotation = 92,
          NPCId = 1071613,
          NPCName = "唯实社社员",
          Type = 0,
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

      EventName = "talk1",
      Actions = {
        {

          StoryId = 4072601,
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

      EventName = "talk2",
      Actions = {
        {

          StoryId = 4072602,
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

      EventName = "talk3",
      Actions = {
        {

          StoryId = 4072603,
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

      ConditionActions = {
        {

          StoryId = 4072601,
          Actions = {
            {

              CondId = 10716011,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4072602,
          Actions = {
            {

              CondId = 10716012,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4072603,
          Actions = {
            {

              CondId = 10716013,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              CondId = 10716014,
              CondValue = 1,
              Type = 31,
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

          TaskId = 1071601,
          Actions = {
            {

              StoryId = 4072611,
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
              TimeoutKey = "JKlEtvPu"
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

      ConditionActions = {
        {

          StoryId = 4072611,
          Actions = {
            {

              PosKey = "N5",
              NPCName = "照顾孕妇的少女",
              NpcParams = {
                InteractionArea = 3.0,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638781489362346612,
              IsRemove = true,
              CustomEventName = "照顾孕妇的少女",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "N4",
              NPCName = "司机",
              NpcParams = {
                InteractionArea = 3.0,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638781489362376616,
              IsRemove = true,
              CustomEventName = "司机",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "N6",
              NPCName = "工程师",
              NpcParams = {
                InteractionArea = 3.0,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 3.0
              },
              Rotation = 0,
              NpcId = 638781489362356615,
              IsRemove = false,
              CustomEventName = "工程师",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "N7",
              NPCName = "唯实社社员",
              NpcParams = {
                InteractionArea = 3.0,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 3.0
              },
              Rotation = 0,
              NpcId = 638781489362406610,
              IsRemove = false,
              CustomEventName = "唯实社社员",
              Type = 92,
              Timeout = 0.0
            },
            {

              Type = 134,
              Timeout = 0.1,
              TimeoutKey = "rUlhmUZH"
            }
          },
          FinishMarkVariable = "SHOWBOX",
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "司机",
      Actions = {
        {

          StoryId = 4072604,
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

      EventName = "照顾孕妇的少女",
      Actions = {
        {

          StoryId = 4072605,
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

      EventName = "工程师",
      Actions = {
        {

          StoryId = 4072606,
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

      EventName = "唯实社社员",
      Actions = {
        {

          StoryId = 4072607,
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

      ConditionActions = {
        {

          StoryId = 4072604,
          Actions = {
            {

              CondId = 10716022,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              CustomEventName = "尝试跳转任务",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4072605,
          Actions = {
            {

              CondId = 10716023,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              CustomEventName = "尝试跳转任务",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          StoryId = 4072606,
          Actions = {
            {

              GameType = 1,
              GameID = 1013,
              Type = 137,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4072607,
          Actions = {
            {

              GameType = 2,
              GameID = 2041,
              Type = 137,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4072609,
          Actions = {
            {

              CondId = 10716021,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              CustomEventName = "尝试跳转任务",
              Type = 19,
              Timeout = 0.0
            },
            {

              NPCName = "工程师",
              Type = 93,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4072610,
          Actions = {
            {

              CondId = 10716024,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              CustomEventName = "尝试跳转任务",
              Type = 19,
              Timeout = 0.0
            },
            {

              NPCName = "唯实社社员",
              Type = 93,
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

      EventName = "尝试跳转任务",
      Actions = {
        {

          CustomEventName = "尝试跳转任务1",
          Type = 19,
          Timeout = 0.0
        },
        {

          Key = "talk_index1",
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
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "尝试跳转任务1",
      Actions = {
        {

          CustomEventName = "尝试跳转任务2",
          Type = 19,
          Timeout = 0.0
        },
        {

          Key = "talk_index2",
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
      Type = 9,
      ConditionVariable = "talk_index1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "尝试跳转任务2",
      Actions = {
        {

          StoryId = 4072608,
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
          TimeoutKey = "YgMxIuVE"
        },
        {

          TimelineName = "scene_timeline_71602",
          IsPlay = true,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "ngLXlDQW"
        },
        {

          NPCName = "照顾孕妇的少女",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "工程师",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "唯实社社员",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCName = "司机",
          Type = 93,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "talk_index2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4072608,
          Actions = {
            {

              TaskId = 1071602,
              Type = 5,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
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

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 35,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      StoryID = 1001072601,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 1001072601,
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
      Type = 37,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 1071614,
          Actions = {
            {

              StoryId = 4072609,
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

          NPCId = 1071615,
          Actions = {
            {

              StoryId = 4072610,
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

          GameType = 1,
          GameID = 1013,
          Actions = {
            {

              StoryId = 4072609,
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

          GameType = 2,
          GameID = 2041,
          Actions = {
            {

              StoryId = 4072610,
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
      Type = 41,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false,
      HyperlinkStr = "https://redmine.mingzhougame.com/issues/5045"
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