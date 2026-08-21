local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          HeroId = 1001024,
          Type = 29,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
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
        },
        {

          PosKey = "r1",
          Rotation = 0,
          NPCId = 3029411,
          NPCName = "精英",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "r2",
          Rotation = 90,
          NPCId = 3029412,
          NPCName = "小怪1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "r3",
          Rotation = -90,
          NPCId = 3029413,
          NPCName = "小怪2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "r1",
          NPCName = "GrAxnaPN",
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
          NpcId = 638751301783277149,
          IsRemove = true,
          CustomEventName = "r1",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "i2",
          NPCName = "屏风",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638751305462381377,
          IsRemove = true,
          CustomEventName = "i2",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "i3",
          NPCName = "茶几",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638751302290856318,
          IsRemove = true,
          CustomEventName = "i3",
          Type = 92,
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

          StoryId = 100229601,
          Actions = {
            {

              TaskGroupId = 32904,
              Type = 21,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229601,
          Actions = {
            {

              TimelineName = "timeline_32904_revive",
              Fadein = 0.0,
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

              NPCName = "屏风",
              Type = 93,
              Timeout = 0.0
            },
            {

              NPCName = "茶几",
              Type = 93,
              Timeout = 0.0
            },
            {

              PlayBgm = "bgm_chapter6_common",
              Type = 76,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229602,
          Actions = {
            {

              CondId = 32904012,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229603,
          Actions = {
            {

              CondId = 32904013,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229604,
          Actions = {
            {

              GroupID = 1,
              Type = 87,
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

      StoryID = 100229601,
      Actions = {
        {

          StoryId = 100229601,
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

      EventName = "addr1",
      Actions = {
        {

          PosKey = "r1",
          NPCName = "白傀儡",
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
          NpcId = 638750397682917976,
          IsRemove = true,
          CustomEventName = "r1",
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

      EventName = "addi2",
      Actions = {
        {

          PosKey = "i2",
          NPCName = "jvNliAYI",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638750541733811188,
          IsRemove = true,
          CustomEventName = "i2",
          Type = 92,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "2229602end",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "addi3",
      Actions = {
        {

          PosKey = "i3",
          NPCName = "PkKlSZTN",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638750542109473213,
          IsRemove = true,
          CustomEventName = "i3",
          Type = 92,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "2229603end",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "r1",
      Actions = {
        {

          StoryId = 2229601,
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

      EventName = "i2",
      Actions = {
        {

          StoryId = 2229602,
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
      FinishMarkVariable = "2229602end",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "i3",
      Actions = {
        {

          StoryId = 2229603,
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
      FinishMarkVariable = "2229603end",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "r1end",
      Actions = {
        {

          CondId = 32904011,
          CondValue = 1,
          Type = 31,
          Timeout = 0.0
        },
        {

          CustomEventName = "addi2",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "addi3",
          Type = 19,
          Timeout = 0.0
        },
        {

          PlayBgm = "storybgm_057",
          Type = 76,
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

          TimelineName = "timeline_32904_revive",
          Actions = {
            {

              NPCId = 3029411,
              NPCName = "精英",
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 3029412,
              NPCName = "小怪1",
              Type = 1,
              Timeout = 0.75,
              TimeoutKey = "pWgPUOYJ"
            },
            {

              NPCId = 3029413,
              NPCName = "小怪2",
              Type = 1,
              Timeout = 2.85,
              TimeoutKey = "kataNDyh"
            },
            {

              NPC = "Hero",
              Point = "H",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 3.0,
              TimeoutKey = "BHMwjbis"
            },
            {

              Point = "r1",
              Type = 3,
              Timeout = 3.1,
              TimeoutKey = "WDBlAMXF"
            },
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
                    Id = 29411,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "r1end",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 5.85,
              TimeoutKey = "aafkIDQq"
            },
            {

              TimelineName = "timeline_32904_revive",
              Type = 7,
              Timeout = 6.5,
              TimeoutKey = "pehbjenQ"
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

      ConditionActions = {
        {

          TimelineName = "timeline_32904_revive",
          Actions = empty,
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

          TaskId = 3290401,
          Actions = {
            {

              StoryId = 2229604,
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
      Type = 14,
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
      StoryId = 2229604,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 3,
    MonsterInfo = {
      [ 20103706 ] = 2,
      [ 20105105 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}