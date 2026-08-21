local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Level/6/L7_/A2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/5/L6_/A2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/01/L1_/A2",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/0/L0_/A2",
          Visible = true,
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
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          PosKey = "M1",
          Rotation = 90,
          NPCId = 3029311,
          NPCName = "薪",
          Type = 0,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 6,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 29311,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
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

          StoryId = 2229401,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.0,
          PlayStayTime = 0.0,
          PlayFadeOutTime = 0.0,
          StopFadeInTime = 0.3,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.3,
          NoSkipStory = true,
          IsSettleStory = false,
          Type = 10,
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

          Key = "help",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 3229407,
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
                    Id = 29312,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "tp4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Group = 29313,
              Type = 65,
              Timeout = 0.0
            },
            {

              Group = 29314,
              Type = 65,
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

          Key = "passer3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 9,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 29313,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              Group = 29311,
              Type = 65,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "passer4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 6,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 29314,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            },
            {

              Group = 29312,
              Type = 65,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "passer5",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 29315,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "walk",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Key = "moveTrigger",
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
        }
      },
      Type = 3,
      ConditionVariable = "task",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2229401,
          Actions = {
            {

              FadeIn = 0.3,
              Hold = 0.5,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_32903_wife",
              Type = 7,
              Timeout = 0.0
            },
            {

              NPCId = 3029311,
              NPCName = "薪",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "hkqgXtec"
            },
            {

              PosKey = "M2",
              Rotation = 0,
              NPCId = 3029312,
              NPCName = "妇女",
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "M5",
              Rotation = 135,
              NPCId = 3029311,
              NPCName = "薪2",
              Type = 0,
              Timeout = 0.6,
              TimeoutKey = "wYwLrUAK"
            },
            {

              KeyName = "M2",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.6,
              TimeoutKey = "YOnzAcyn"
            },
            {

              TaskGroupId = 32903,
              Type = 21,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          StoryId = 2229402,
          Actions = {
            {

              FadeIn = 0.3,
              Hold = 0.5,
              FadeOut = 0.3,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
              Rotation = 180,
              NPCId = 3029313,
              NPCName = "老板思过",
              Type = 0,
              Timeout = 0.0
            },
            {

              KeyName = "M3",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.5,
              TimeoutKey = "EozzuHEj"
            },
            {

              Enable = true,
              Type = 17,
              Timeout = 0.5,
              TimeoutKey = "vnORpnDv"
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill3",
              IsShow = false,
              Type = 32,
              Timeout = 0.5,
              TimeoutKey = "ZlWChwRs"
            },
            {

              NPCId = 3029311,
              NPCName = "薪2",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "wqOAbIsY"
            },
            {

              Pos = 3,
              SavePos = 0,
              IsGoOut = true,
              Type = 78,
              Timeout = 0.4,
              TimeoutKey = "DgDAsJXQ"
            },
            {

              HeroId = 1001004,
              Type = 29,
              Timeout = 0.5,
              TimeoutKey = "UbMfULPp"
            },
            {

              NPC = "Hero",
              Point = "M5",
              Rotate = 135.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.7,
              TimeoutKey = "JpEvDdPA"
            },
            {

              Point = "M2",
              Type = 3,
              Timeout = 0.8,
              TimeoutKey = "coZXivza"
            },
            {

              TaskId = 3290301,
              Type = 5,
              Timeout = 0.0
            },
            {

              GroupId = 32903,
              Type = 42,
              Timeout = 1.0,
              TimeoutKey = "yRSdTRXb"
            },
            {

              ObjName = "/Root/Level/4/L5_/A2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "jfmzklJG"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229403,
          Actions = {
            {

              KeyName = "M4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              Tips = "1021",
              Duration = 5.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            },
            {

              Seconds = 60,
              Text = "",
              EventName = "changeEnd",
              Type = 66,
              Timeout = 0.0
            },
            {

              PosKey = "M4",
              NPCName = "GE",
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
              NpcId = 638688528336493276,
              IsRemove = true,
              CustomEventName = "GE",
              Type = 92,
              Timeout = 0.0
            },
            {

              NPCName = "GE",
              Type = 93,
              Timeout = 60.0,
              TimeoutKey = "wGIyIPbs"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 6,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 29316,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "task",
          ValidInTower = false
        },
        {

          StoryId = 2229404,
          Actions = {
            {

              StoryId = 2229406,
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

          StoryId = 2229405,
          Actions = {
            {

              StoryId = 2229406,
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

          StoryId = 2229406,
          Actions = {
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = false,
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

          NPCId = 3029313,
          Actions = {
            {

              StoryId = 2229403,
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

              NPCId = 3029312,
              NPCName = "妇女",
              Type = 1,
              Timeout = 0.5,
              TimeoutKey = "SLCGkcNO"
            },
            {

              TimelineName = "scene_timeline_32903_wifeEnd",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              PosKey = "bubble",
              Rotation = 0,
              NPCId = 3029314,
              NPCName = "妇女气泡",
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 3029312,
          Actions = {
            {

              StoryId = 2229402,
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

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.5,
              TimeoutKey = "IIKSrAaP"
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

      EventName = "tlEnd",
      Actions = {
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0,
          TimeoutKey = "NShyzYAq"
        },
        {

          TimelineName = "timeline_32903_wife",
          Type = 7,
          Timeout = 0.5,
          TimeoutKey = "YDkkJJcR"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "storyEnd",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "tlEnd2",
      Actions = empty,
      FinishMarkVariable = "storyEnd",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GE",
      Actions = {
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          StoryId = 2229404,
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
          TimeoutKey = "zgLtBmPa"
        },
        {

          TaskId = 3290303,
          Type = 5,
          Timeout = 1.0,
          TimeoutKey = "cPgWMGoC"
        },
        {

          NPCId = 3029314,
          NPCName = "妇女气泡",
          Type = 1,
          Timeout = 0.5,
          TimeoutKey = "clRACJAe"
        },
        {

          Group = 29315,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "XfnwtkbV"
        },
        {

          Group = 29316,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "PoHGMQLK"
        },
        {

          NPC = "Hero",
          Point = "finalTalk",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "LSIoZeKR"
        }
      },
      FinishMarkVariable = "GE",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BE",
      Actions = {
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          StoryId = 2229405,
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
          TimeoutKey = "JyYsWYLS"
        },
        {

          TaskId = 3290303,
          Type = 5,
          Timeout = 1.0,
          TimeoutKey = "dyBKkaoM"
        },
        {

          NPCId = 3029314,
          NPCName = "妇女气泡",
          Type = 1,
          Timeout = 0.5,
          TimeoutKey = "JniOrLDs"
        },
        {

          Group = 29316,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "AGnWfBia"
        },
        {

          Group = 29315,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "IbiRLcKG"
        },
        {

          NPC = "Hero",
          Point = "finalTalk",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "PvUtlNaB"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "changeEnd",
      Actions = {
        {

          PosKey = "M4",
          NPCName = "ZjAsxEjp",
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
          NpcId = 638690052052773910,
          IsRemove = true,
          CustomEventName = "BE",
          Type = 92,
          Timeout = 60.0,
          TimeoutKey = "MWnzydCU"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "GE",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_32903_wife",
          Actions = empty,
          FinishMarkVariable = "",
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

          StoryId = 2229401,
          StepId = 2,
          Actions = {
            {

              TimelineName = "timeline_32903_wife",
              Fadein = 2.0,
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
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229401,
          StepId = 3,
          Actions = {
            {

              TimelineName = "timeline_32903_wife",
              Type = 7,
              Timeout = 0.0
            },
            {

              CustomEventName = "tlEnd2",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          StoryId = 2229403,
          StepId = 2,
          Actions = {
            {

              TaskId = 3290302,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229403,
          StepId = 3,
          Actions = {
            {

              PosKey = "M4",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
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

          TimelineName = "timeline_32903_wife",
          Actions = {
            {

              CustomEventName = "tlEnd",
              Type = 19,
              Timeout = 4.5,
              TimeoutKey = "BeIMMXtD"
            }
          },
          ValidInTower = false
        }
      },
      Type = 32,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = true
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
      StoryId = 2229406,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 6,
    MonsterCount = 39,
    MonsterInfo = {
      [ 3290304 ] = 1,
      [ 3290302 ] = 17,
      [ 3290301 ] = 15,
      [ 3290306 ] = 3,
      [ 3290305 ] = 3
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}