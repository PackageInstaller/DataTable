local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          GroupId = 104502,
          Type = 27,
          Timeout = 0.0
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
                Id = 104505,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb",
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

          ObjName = "/Root/Change_/Change_night/Level2/camerashake",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          PosKey = "NPC",
          NPCName = "control2",
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
          NpcId = 638304856886648888,
          IsRemove = true,
          CustomEventName = "路障交互",
          Type = 92,
          Timeout = 0.0
        },
        {

          StoryId = 4040801,
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

          ContainerName = "Level2",
          Names = {
            "L3"
          },
          States = {
            "3"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          Key = "in_daze",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          PosKey = "item3",
          Rotation = 0,
          NPCId = 10450104,
          NPCName = "力量药水",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "item1",
          Rotation = 0,
          NPCId = 10450105,
          NPCName = "技能药水",
          Type = 0,
          Timeout = 0.0
        },
        {

          ContainerName = "Level2",
          Names = {
            "L5"
          },
          States = {
            "3"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level2",
          Names = {
            "L4"
          },
          States = {
            "3"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/104502",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          TaskGroupId = 1044,
          Type = 21,
          Timeout = 0.0
        },
        {

          KeyName = "NPC",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0,
          TimeoutKey = "oadGRANA"
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

          Key = "qian_night",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "nightSwitch",
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
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
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
          ObjectName = "Btn_skill8",
          IsShow = false,
          Type = 32,
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

      NoPassCamera = 104501,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 104501,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "/Root/Change_/Change_night/Level2/A7/8/sc05_prp_55b_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/Level2/A8/9/sc05_prp_55b_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupId = 10440202,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupID = 5,
          Type = 86,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/jiejing_G/sc05_prp_60b_pre (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_night/jiejing_G/sc05_prp_60e_pre (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10413",
          Type = 19,
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

          Key = "story1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 4040802,
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

          Key = "camera",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Camera = 101,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Camera = 104503,
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

          Key = "camera1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "camera2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "NPC2",
              IsOpen = true,
              CameraStyle = 0,
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
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4040802,
          Actions = {
            {

              TimelineName = "timeline_104501_xiaowu",
              Type = 7,
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
                EndPerform = false,
                ActionTag = "",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104506,
                    param = 0,
                    Name = "全部杀死",
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
          ValidInTower = false
        },
        {

          StoryId = 4040804,
          Actions = {
            {

              CondId = 104503,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4040805,
          Actions = {
            {

              CondId = 104501,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4040806,
          Actions = {
            {

              CondId = 104502,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4040807,
          Actions = {
            {

              Camera = 104501,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
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
                ActionTag = "",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 104507,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "通关剧情",
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

              StoryId = 5040802,
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

          StoryId = 2040910,
          Actions = {
            {

              CustomEventName = "magic",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4040808,
          Actions = {
            {

              TimelineName = "timeline_104501_jiaoying",
              Type = 7,
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

          StoryId = 4040801,
          Actions = {
            {

              CustomEventName = "magic",
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

          StoryId = 4040803,
          Actions = {
            {

              TaskId = 104401,
              Type = 5,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              Camera = 104502,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "NPC1",
              NPCName = "name1",
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
              NpcId = 638304875554613459,
              IsRemove = true,
              CustomEventName = "name1",
              Type = 92,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              PosKey = "NPC2",
              NPCName = "name2",
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
              NpcId = 638304875917697497,
              IsRemove = true,
              CustomEventName = "name2",
              Type = 92,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              PosKey = "NPC3",
              NPCName = "name3",
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
              NpcId = 638304875940270074,
              IsRemove = true,
              CustomEventName = "name3",
              Type = 92,
              Timeout = 0.0,
              TimeoutKey = "name3"
            },
            {

              TaskGroupId = 1045,
              Type = 21,
              Timeout = 0.0
            },
            {

              Camera = 104502,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "is_in_task",
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "is_in_task",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2040905,
          Actions = {
            {

              Camera = 104501,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "is_in_task",
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "is_in_task",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 10440201,
          Actions = {
            {

              StoryId = 4040808,
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
              Timeout = 3.5,
              TimeoutKey = "UraBQTHV"
            },
            {

              TimelineName = "timeline_104501_jiaoying",
              Fadein = 3.0,
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
              Timeout = 1.0,
              TimeoutKey = "nDGDeCLf"
            },
            {

              Type = 22,
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

      EventName = "BOXEND10405",
      Actions = {
        {

          Variable = "10405",
          Type = 128,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4010006,
          Level = 1,
          Type = 16,
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

      EventName = "路障交互",
      Actions = {
        {

          CustomEventName = "有卡",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "无卡",
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

      EventName = "magic",
      Actions = {
        {

          Target = "Hero",
          MagicId = 40104406,
          Level = 0,
          Type = 16,
          Timeout = 0.0,
          TimeoutKey = "oEMDLxkX"
        },
        {

          Target = "Hero",
          MagicId = 1001330,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 40104416,
          Level = 0,
          Type = 16,
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

      EventName = "无卡",
      Actions = {
        {

          StoryId = 4040803,
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

          PosKey = "NPC",
          NPCName = "BIidqeSa",
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
          NpcId = 638304865235083156,
          IsRemove = true,
          CustomEventName = "路障交互",
          Type = 92,
          Timeout = 0.5,
          TimeoutKey = "kYmsSIOZ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "task_done",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "PREBOX10413",
      Actions = {
        {

          PosKey = "BOX2",
          NPCName = "MxUiaZGm",
          NpcParams = {
            InteractionArea = 0.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638663385870830113,
          IsRemove = true,
          Type = 92,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10413",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "name2",
      Actions = {
        {

          StoryId = 4040804,
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

      EventName = "BOX10405",
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

          TreasureChestId = 10405,
          PosKey = "BOX1",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10405",
          Type = 124,
          Timeout = 1.0,
          TimeoutKey = "EAfqcMra"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "有卡",
      Actions = {
        {

          StoryId = 4040807,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = true,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "task_done",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "name1",
      Actions = {
        {

          StoryId = 4040805,
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

      EventName = "通关剧情",
      Actions = {
        {

          PosKey = "END",
          Rotation = 0,
          NPCId = 10440201,
          NPCName = "脚印",
          Type = 0,
          Timeout = 0.0
        },
        {

          KeyName = "END",
          IsOpen = true,
          IsContinue = true,
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

      EventName = "qb",
      Actions = {
        {

          ContainerName = "Level2",
          Names = {
            "L3"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level2",
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

          ContainerName = "Level2",
          Names = {
            "L7"
          },
          States = {
            "0"
          },
          SaveType = 0,
          Type = 97,
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

      EventName = "name3",
      Actions = {
        {

          StoryId = 4040806,
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

      EventName = "PREBOX10405",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10405",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          StoryId = 4040802,
          StepId = 2,
          Actions = {
            {

              TimelineName = "timeline_104501_xiaowu",
              Fadein = 4.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.5,
              Hold = 0.5,
              BlackOut = 0.5,
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

          StoryId = 4040807,
          StepId = 6,
          Actions = {
            {

              ContainerName = "Level2",
              Names = {
                "L4"
              },
              States = {
                "0"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            },
            {

              ContainerName = "Level2",
              Names = {
                "L5"
              },
              States = {
                "0"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            },
            {

              KeyName = "END",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
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

          TaskId = 104501,
          Actions = {
            {

              KeyName = "NPC",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "task_done",
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

          NPCId = 10450104,
          Actions = {
            {

              ObjName = "/Root/Change_/Change_night/Level2/camerashake",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 40104416,
              Type = 103,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 20,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 10450105,
          Actions = {
            {

              UIName = "fight",
              ObjectName = "Btn_skill4",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill5",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill7",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 20,
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
    [ 6 ] = {
      TimeLineId = "timeline_104501_jiaoying",
      Name = "播放TimeLine结束"
    }
  },
  MonsterCountInfo = {
    EventCount = 3,
    MonsterCount = 15,
    MonsterInfo = {
      [ 20104301 ] = 13,
      [ 20204401 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}