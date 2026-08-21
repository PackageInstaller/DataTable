local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "Staff",
          Rotation = 0,
          NPCId = 301701,
          NPCName = "接任务工作人员",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Resident1",
          Rotation = 230,
          NPCId = 301703,
          NPCName = "集合地居民1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Resident2",
          Rotation = -20,
          NPCId = 301704,
          NPCName = "集合地居民2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "Resident3",
          Rotation = 45,
          NPCId = 301705,
          NPCName = "集合地居民3",
          Type = 0,
          Timeout = 0.0
        },
        {

          IsOpen = false,
          Type = 79,
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

      NoPassCamera = 31701,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 31701,
      PassCameraIsNewConfig = true,
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

          ContainerName = "Level",
          Names = {
            "L6"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          TaskGroupId = 31701,
          Type = 21,
          Timeout = 0.0
        },
        {

          Key = "walk",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StoryId = 2217101,
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

          KeyName = "Staff",
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

      Actions = {
        {

          Key = "ToEnd",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
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

          PosKey = "Resident8",
          Rotation = 80,
          NPCId = 301710,
          NPCName = "居民8",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "qYfBQUrH"
        },
        {

          PosKey = "Staff",
          Rotation = 0,
          NPCId = 301702,
          NPCName = "交任务工作人员",
          Type = 0,
          Timeout = 0.0
        },
        {

          NPCId = 301701,
          NPCName = "接任务工作人员",
          Type = 1,
          Timeout = 0.0
        },
        {

          Type = 69,
          Timeout = 1.0,
          TimeoutKey = "VjtggjSa"
        },
        {

          Group = 1704,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "cQyTbXwS"
        },
        {

          TaskId = 3170104,
          Type = 5,
          Timeout = 2.0,
          TimeoutKey = "eOCMzQqB"
        },
        {

          NPC = "Hero",
          Point = "BB1",
          Rotate = -90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "ooQbRqer"
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "ToEnd",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "CameraRight",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 31702,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "CameraLeft",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 31703,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
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

          Key = "OpenGate1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              ContainerName = "Level",
              Names = {
                "L17"
              },
              States = {
                "0"
              },
              SaveType = 0,
              Type = 97,
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

          Key = "MonsterRight",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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
                WallObjPath = "right",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 17001,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "RightOver",
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

              ContainerName = "Level",
              Names = {
                "L18"
              },
              States = {
                "1"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "MonsterFront",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "FocusFight",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 1.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 1.0,
              Type = 62,
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
                WallObjPath = "front",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 17002,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "FrontOver",
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

              Path = "Level/4/L5_/A1",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "MonsterLeft",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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
                WallObjPath = "left",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 17003,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "LeftOver",
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

              Path = "Level/6/L7_/A1",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
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

          Key = "CameraRight",
          Actions = {
            {

              Camera = 31701,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "CameraLeft",
          Actions = {
            {

              Camera = 31701,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
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

          StoryId = 2217104,
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

              NPCId = 301711,
              NPCName = "交互居民1",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "lwCXTUQG"
            },
            {

              PosKey = "Resident4",
              Rotation = -10,
              NPCId = 301706,
              NPCName = "居民4",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "GMuAVotn"
            },
            {

              NPCId = 301712,
              NPCName = "交互居民2",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "lbsMPtVj"
            },
            {

              PosKey = "Resident5",
              Rotation = 190,
              NPCId = 301707,
              NPCName = "居民5",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "PvqMuKSA"
            },
            {

              PosKey = "Focus2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 3.0,
              Type = 62,
              Timeout = 2.0,
              TimeoutKey = "LLQwBQmc"
            },
            {

              Path = "Level/4/L5_/A1",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 2.0,
              TimeoutKey = "aiYTbwbO"
            },
            {

              StoryId = 3217101,
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
              Timeout = 2.0,
              TimeoutKey = "hDMMxjGC"
            },
            {

              TaskId = 3170102,
              Type = 5,
              Timeout = 3.0,
              TimeoutKey = "bJihneRe"
            },
            {

              KeyName = "InteractResident3",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2217108,
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 17019,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "loop1",
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

              PosKey = "M1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 3.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 3.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              Key = "walk",
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

          StoryId = 2217105,
          Actions = {
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "InteractResident4",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "front1",
          ValidInTower = false
        },
        {

          StoryId = 2217106,
          Actions = {
            {

              LineCount = 1,
              StateInfos = {
                {
                  KeyName = "InteractResident3",
                  IsOpen = false
                }
              },
              Type = 98,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "front2",
          ValidInTower = false
        },
        {

          StoryId = 2217103,
          Actions = {
            {

              PosKey = "M2",
              Rotation = 0,
              NPCId = 301723,
              NPCName = "撬锁",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "InfiQlGV"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2217107,
          Actions = {
            {

              CustomEventName = "前方街区完成剧情结束",
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

          StoryId = 2217102,
          Actions = {
            {

              ContainerName = "Level",
              Names = {
                "L18"
              },
              States = {
                "0"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            },
            {

              PosKey = "Focus1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 1.5,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 1.5,
              Type = 62,
              Timeout = 0.0
            },
            {

              TaskId = 3170101,
              Type = 5,
              Timeout = 1.0,
              TimeoutKey = "IaItbnEA"
            },
            {

              KeyName = "M2",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 100217102,
          Actions = {
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

      ConditionActions = {
        {

          NPCId = 301711,
          Actions = {
            {

              StoryId = 2217104,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.5,
              StopStayTime = 1.0,
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

          NPCId = 301713,
          Actions = {
            {

              StoryId = 2217106,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.5,
              StopStayTime = 1.0,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          NPCId = 301714,
          Actions = {
            {

              StoryId = 2217105,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.5,
              StopStayTime = 1.0,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          NPCId = 301723,
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

              PosKey = "InteractResident2",
              Rotation = -10,
              NPCId = 301712,
              NPCName = "交互居民2",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "XYwVDCqm"
            },
            {

              NPC = "Hero",
              Point = "M3",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "ZzkWGlFT"
            },
            {

              PosKey = "InteractResident1",
              Rotation = 79,
              NPCId = 301711,
              NPCName = "交互居民1",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "njyAvvUs"
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

          NPCId = 301701,
          Actions = {
            {

              StoryId = 2217102,
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

          NPCId = 301702,
          Actions = {
            {

              StoryId = 100217102,
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
              Timeout = 0.0,
              TimeoutKey = "BTvAnNJg"
            },
            {

              TaskId = 3170105,
              Type = 5,
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

      Actions = {
        {

          Type = 12,
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

      EventName = "RightOver",
      Actions = {
        {

          ContainerName = "Level",
          Names = {
            "L18"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 2.0,
          Type = 62,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "juming1",
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
          NpcId = 638497236386850996,
          IsRemove = true,
          CustomEventName = "RightTalk",
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

      EventName = "FrontOver",
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

          PosKey = "InteractResident3",
          Rotation = -90,
          NPCId = 301713,
          NPCName = "交互居民3",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "qSkGwBPT"
        },
        {

          PosKey = "InteractResident4",
          Rotation = 100,
          NPCId = 301714,
          NPCName = "交互居民4",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "cvQiuWId"
        },
        {

          Path = "Level/4/L5_/A1",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Type = 71,
          Timeout = 0.0
        },
        {

          LineCount = 2,
          StateInfos = {
            {
              KeyName = "InteractResident3",
              IsOpen = true
            },
            {
              KeyName = "InteractResident4",
              IsOpen = true
            }
          },
          Type = 98,
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

      EventName = "LeftOver",
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
          Point = "Conversation",
          Rotate = 160.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "ThQOnDaT"
        },
        {

          Path = "Level/6/L7_/A1",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          StoryId = 2217108,
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
          TimeoutKey = "LHfbDbzl"
        },
        {

          GroupId = 1704,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "Mtwizhbr"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "loop1",
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 17020,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "loop2",
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "loop2",
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 17019,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "loop1",
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "RightTalk",
      Actions = {
        {

          StoryId = 2217103,
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

      EventName = "前方街区完成剧情结束",
      Actions = {
        {

          Path = "Level/6/L7_/A1",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 2.0,
          TimeoutKey = "yoqQuDYN"
        },
        {

          PosKey = "Focus3",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 2.0,
          Type = 62,
          Timeout = 2.0,
          TimeoutKey = "dsIzYxWU"
        },
        {

          StoryId = 3217102,
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
          Timeout = 8.0,
          TimeoutKey = "kqyLlISU"
        },
        {

          TaskId = 3170103,
          Type = 5,
          Timeout = 3.0,
          TimeoutKey = "QjCyeaDl"
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

          StoryId = 100217102,
          StepId = 0,
          Actions = {
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
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            "front1",
            "front2"
          },
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

              NPCId = 301713,
              NPCName = "交互居民3",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "EJoNtIyf"
            },
            {

              PosKey = "Resident6",
              Rotation = 20,
              NPCId = 301708,
              NPCName = "居民6",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "nKKTZngz"
            },
            {

              NPCId = 301714,
              NPCName = "交互居民4",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "XmJLFJGH"
            },
            {

              PosKey = "Resident7",
              Rotation = 180,
              NPCId = 301709,
              NPCName = "居民7",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "uPkbAmpb"
            },
            {

              StoryId = 2217107,
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
              TimeoutKey = "GxReQJHk"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              LineCount = 2,
              StateInfos = {
                {
                  KeyName = "InteractResident3",
                  IsOpen = false
                },
                {
                  KeyName = "InteractResident4",
                  IsOpen = false
                }
              },
              Type = 98,
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
    EventCount = 6,
    MonsterCount = 23,
    MonsterInfo = {
      [ 20204301 ] = 10,
      [ 20104601 ] = 2,
      [ 20204401 ] = 2,
      [ 20204601 ] = 6,
      [ 20304402 ] = 1,
      [ 20104501 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}