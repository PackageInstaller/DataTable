local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "NPC1",
          Rotation = 90,
          NPCId = 10804201,
          NPCName = "解说1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC2",
          Rotation = 90,
          NPCId = 10804202,
          NPCName = "游客2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC3",
          Rotation = -90,
          NPCId = 10804203,
          NPCName = "讨论3",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC4",
          Rotation = 90,
          NPCId = 10804204,
          NPCName = "讨论4",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC3",
          Rotation = 90,
          NPCId = 10804205,
          NPCName = "气泡3",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC4",
          Rotation = 90,
          NPCId = 10804206,
          NPCName = "气泡4",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC3.5",
          NPCName = "realTalk",
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
          NpcId = 638780653551538043,
          IsRemove = true,
          CustomEventName = "904080609",
          Type = 92,
          Timeout = 0.0
        },
        {

          LineCount = 3,
          StateInfos = {
            {
              KeyName = "NPC3.5",
              IsOpen = true
            },
            {
              KeyName = "NPC2",
              IsOpen = true
            },
            {
              KeyName = "NPC1",
              IsOpen = true
            }
          },
          Type = 98,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10804/1080405/Fx_ceshifang (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          PosKey = "NPC5",
          Rotation = -90,
          NPCId = 10804209,
          NPCName = "补充1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC6",
          Rotation = -90,
          NPCId = 10804210,
          NPCName = "补充2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC7",
          Rotation = 180,
          NPCId = 10804211,
          NPCName = "补充3",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC8",
          Rotation = 180,
          NPCId = 10804212,
          NPCName = "补充4",
          Type = 0,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 1,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          TimelineName = "timeline_10804_05end",
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
          BeforeHold = 0.5,
          BeforeBlackOut = 0.3,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_10804_05end",
          Type = 7,
          Timeout = 4.5,
          TimeoutKey = "iwNizjfX"
        },
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 4.0,
          TimeoutKey = "oQLLbHxJ"
        },
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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1080401,
          Level = 1,
          Type = 16,
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

          NPCId = 10804201,
          Actions = {
            {

              StoryId = 4080607,
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

              LineCount = 3,
              StateInfos = {
                {
                  KeyName = "NPC1",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 10804202,
          Actions = {
            {

              StoryId = 4080608,
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

              LineCount = 3,
              StateInfos = {
                {
                  KeyName = "NPC2",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 10804203,
          Actions = empty,
          ValidInTower = false
        },
        {

          NPCId = 10804204,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "904080609",
      Actions = {
        {

          StoryId = 4080609,
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

          NPCId = 10804205,
          NPCName = "气泡3",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 10804206,
          NPCName = "气泡4",
          Type = 1,
          Timeout = 0.0
        },
        {

          LineCount = 3,
          StateInfos = {
            {
              KeyName = "NPC3.5",
              IsOpen = false
            }
          },
          Type = 98,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "talked",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "talked",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "discover",
      Actions = {
        {

          StoryId = 4080611,
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

          AreaName = "leave",
          RemoveForever = false,
          Type = 9,
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

      EventName = "UIclose",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill8",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "JoystickContent",
          IsShow = false,
          Type = 32,
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

      EventName = "UIopen",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "JoystickContent",
          IsShow = true,
          Type = 32,
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

      EventName = "leave",
      Actions = {
        {

          Target = "Hero",
          Enable = true,
          Type = 119,
          Timeout = 0.0
        },
        {

          FadeIn = 0.3,
          Hold = 0.3,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_10804_holeCmr2",
          Type = 7,
          Timeout = 0.5,
          TimeoutKey = "LESIovoV"
        },
        {

          Point = "hole",
          Type = 3,
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

          StoryId = 4080607,
          Actions = {
            {

              CondId = 10804021,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080608,
          Actions = {
            {

              CondId = 10804022,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080609,
          Actions = {
            {

              CondId = 10804023,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080611,
          Actions = {
            {

              TimelineName = "timeline_10804_holeCmr",
              Type = 7,
              Timeout = 0.0,
              TimeoutKey = "obxSavVQ"
            },
            {

              Target = "Hero",
              Enable = false,
              Type = 119,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_10804_holeCmr2",
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
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0,
              TimeoutKey = "DTsmvMMQ"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080612,
          Actions = {
            {

              CustomEventName = "leave",
              Type = 19,
              Timeout = 0.0
            },
            {

              TaskId = 1080403,
              Type = 5,
              Timeout = 0.5,
              TimeoutKey = "lfTTtVAY"
            },
            {

              StoryId = 1001080602,
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
              TimeoutKey = "MIWQgfDH"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080610,
          Actions = {
            {

              GroupID = 1,
              Type = 87,
              Timeout = 0.0
            },
            {

              KeyName = "Guide1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
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

          TaskId = 1080402,
          Actions = {
            {

              StoryId = 4080610,
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

      ConditionActions = {
        {

          Key = "sign",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "hole",
              NPCName = "画洞",
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
              NpcId = 638735045733748604,
              IsRemove = true,
              CustomEventName = "discover",
              Type = 92,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "leave",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TimelineName = "timeline_10804_holeCmr",
              Fadein = 1.0,
              Fadeout = 1.0,
              IsCanSkip = false,
              NotPauseLua = true,
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
              Timeout = 0.0
            },
            {

              Type = 71,
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

          Key = "leave",
          Actions = {
            {

              TimelineName = "timeline_10804_holeCmr",
              Type = 7,
              Timeout = 0.0
            },
            {

              KeyName = "Guide1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
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

          StoryId = 4080611,
          StepId = 2,
          Actions = {
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.0,
              TimeoutKey = "zIFeQaQn"
            },
            {

              NPC = "Hero",
              Point = "leave",
              Rotate = 90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0,
              TimeoutKey = "HYqlNhVu"
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

          TimelineName = "timeline_10804_holeCmr2",
          Actions = {
            {

              StoryId = 4080612,
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
              Timeout = 2.5,
              TimeoutKey = "VshjjKJu"
            },
            {

              ObjName = "/Root/Scene/Zone_03/Building_03/sc08_build_27a_pre/sc08_build_27b_mod",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 32,
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
      StoryId = 1001080602,
      Name = "6.剧情开始"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}