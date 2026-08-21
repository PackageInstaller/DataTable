return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Change_/Change_ LYG/sc06_area_lingyange/floor1/prop/sc06_prop_70_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_ LYG/sc06_area_lingyange/floor1/sc06_area_lingyange_1lou_pre/sc06_area_lingyange_1lou_01_mod/sc06_area_lingyange_1lou_01_m02",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level2/331/fatherEje",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          KeyName = "monster",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
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

      NoPassCamera = 104,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = true,
      PassCamera = 104,
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

          ObjName = "/Root/Level/yilou_door1/D2_/open",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/slot1/S1_/work",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          IsSkip = true,
          Type = 36,
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

          Key = "4Knives",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 3231401,
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
              Timeout = 0.2,
              TimeoutKey = "LlqBzYGT"
            },
            {

              PosKey = "look",
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
              Timeout = 0.2,
              TimeoutKey = "MvTquvTA"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              TaskId = 3310401,
              Type = 5,
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

          StoryId = 3231401,
          Actions = {
            {

              KeyName = "read1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              PosKey = "read1",
              NPCName = "1in4",
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
              NpcId = 638711871144969787,
              IsRemove = true,
              CustomEventName = "1in4",
              Type = 92,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2231401,
          Actions = {
            {

              Point = "look",
              Type = 3,
              Timeout = 0.0
            },
            {

              Camera = 1,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              StoryId = 2231403,
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

          StoryId = 2231403,
          Actions = {
            {

              PosKey = "read2",
              NPCName = "swordStory1",
              NpcParams = {
                InteractionArea = 2.0,
                UseEffect = "Fx_Investigate_weak|H101004",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638711886319647471,
              IsRemove = false,
              CustomEventName = "swordStory1",
              Type = 92,
              Timeout = 0.0
            },
            {

              PosKey = "read1",
              NPCName = "findKey",
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
              NpcId = 638711887973159753,
              IsRemove = true,
              CustomEventName = "findKey",
              Type = 92,
              Timeout = 0.5,
              TimeoutKey = "QwffJdNy"
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2231404,
          Actions = {
            {

              PosKey = "key",
              NPCName = "key1",
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
              NpcId = 638711901698873106,
              IsRemove = true,
              CustomEventName = "firstSwitch",
              Type = 92,
              Timeout = 0.0
            },
            {

              KeyName = "key",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              TaskId = 3310403,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 100231401,
          Actions = {
            {

              TaskGroupId = 33104,
              Type = 21,
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

      EventName = "findKey",
      Actions = {
        {

          StoryId = 2231404,
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

      EventName = "addSwordInteract1",
      Actions = {
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 3031411,
          NPCName = "sword1",
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

      EventName = "addSwordInteract2",
      Actions = {
        {

          PosKey = "M2",
          Rotation = 0,
          NPCId = 3031412,
          NPCName = "sword2",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "used2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "addSwordInteract3",
      Actions = {
        {

          PosKey = "M3",
          Rotation = 0,
          NPCId = 3031413,
          NPCName = "sword3",
          Type = 0,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "used3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "addSwordInteract4",
      Actions = {
        {

          PosKey = "M4",
          Rotation = 0,
          NPCId = 3031414,
          NPCName = "sword4",
          Type = 0,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "used4",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "1in4",
      Actions = {
        {

          StoryId = 2231401,
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "swordStory1",
      Actions = {
        {

          StoryId = 2231405,
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

      EventName = "useSword3",
      Actions = {
        {

          Camera = 104,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.2,
          TimeoutKey = "uIMpXhkM"
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
                Id = 31411,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "used3",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.5,
          TimeoutKey = "bUTNAjZJ"
        },
        {

          PosKey = "monster",
          IsOpen = true,
          CameraStyle = 0,
          Duration = 1.5,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 1.5,
          Type = 62,
          Timeout = 0.5,
          TimeoutKey = "bKLeForV"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "useSword4",
      Actions = {
        {

          Camera = 104,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.2,
          TimeoutKey = "rEFPWQuY"
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
                Id = 31412,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "used4",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.5,
          TimeoutKey = "nWCqGAbf"
        },
        {

          PosKey = "monster",
          IsOpen = true,
          CameraStyle = 0,
          Duration = 1.5,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 1.5,
          Type = 62,
          Timeout = 0.5,
          TimeoutKey = "LxATELeU"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "wrongCommon",
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

          Camera = 1,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.3,
          TimeoutKey = "aBlYQgQG"
        },
        {

          NPC = "Hero",
          Point = "wrong1",
          Rotate = 45.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.4,
          TimeoutKey = "pjgopCBA"
        },
        {

          ObjName = "/Root/Level2/331/timeline_original",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.5,
          TimeoutKey = "MfgtmbDj"
        },
        {

          ObjName = "/Root/Level2/331/timeline_rounding",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.5,
          TimeoutKey = "FbhDZcIn"
        },
        {

          NPCId = 3031411,
          NPCName = "sword1",
          Type = 1,
          Timeout = 0.6,
          TimeoutKey = "PuaNwZJc"
        },
        {

          NPCId = 3031412,
          NPCName = "sword2",
          Type = 1,
          Timeout = 0.6,
          TimeoutKey = "GgjPaOIe"
        },
        {

          NPCId = 3031413,
          NPCName = "sword3",
          Type = 1,
          Timeout = 0.6,
          TimeoutKey = "fTQrFDJV"
        },
        {

          NPCId = 3031414,
          NPCName = "sword4",
          Type = 1,
          Timeout = 0.6,
          TimeoutKey = "aKzxieug"
        },
        {

          PosKey = "key",
          NPCName = "keyRepeat",
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
          NpcId = 638711731213966492,
          IsRemove = true,
          CustomEventName = "switch",
          Type = 92,
          Timeout = 0.7,
          TimeoutKey = "IiDxVsij"
        },
        {

          KeyName = "key",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 1.1,
          TimeoutKey = "rzzdnTtd"
        }
      },
      FinishMarkVariable = "used2",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "used3",
      Actions = {
        {

          CustomEventName = "addSwordInteract1",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "wJelsiUG"
        },
        {

          CustomEventName = "addSwordInteract2",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "FFcknDOU"
        },
        {

          CustomEventName = "addSwordInteract3",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "RfoFyfSC"
        },
        {

          CustomEventName = "addSwordInteract4",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "bfsipMdo"
        }
      },
      FinishMarkVariable = "used3",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "used4",
      Actions = {
        {

          CustomEventName = "addSwordInteract1",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "HGffQZgq"
        },
        {

          CustomEventName = "addSwordInteract2",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "hsvZKqAv"
        },
        {

          CustomEventName = "addSwordInteract3",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "Negtoaxh"
        },
        {

          CustomEventName = "addSwordInteract4",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "bNigdEaO"
        }
      },
      FinishMarkVariable = "used4",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_331_knife1",
          Actions = {
            {

              Target = "Hero",
              Enable = true,
              Type = 119,
              Timeout = 0.0
            },
            {

              PosKey = "M1",
              Rotation = 0,
              NPCId = 3031411,
              NPCName = "sword4",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "ocqIvqpH"
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_331_knife2",
          Actions = {
            {

              Target = "Hero",
              Enable = true,
              Type = 119,
              Timeout = 0.0
            },
            {

              PosKey = "M2",
              Rotation = 0,
              NPCId = 3031412,
              NPCName = "sword2",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "cSKymCgk"
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_331_knife3",
          Actions = {
            {

              Target = "Hero",
              Enable = true,
              Type = 119,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
              Rotation = 0,
              NPCId = 3031413,
              NPCName = "sword3",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "ruWtWnYI"
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_331_knife4",
          Actions = {
            {

              Target = "Hero",
              Enable = true,
              Type = 119,
              Timeout = 0.0
            },
            {

              PosKey = "M4",
              Rotation = 0,
              NPCId = 3031414,
              NPCName = "sword4",
              Type = 0,
              Timeout = 0.2,
              TimeoutKey = "XMzTgGoU"
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

      EventName = "switch",
      Actions = {
        {

          Type = 71,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/slot1/S1_/work",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          FadeIn = 0.3,
          Hold = 1.0,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.8,
          TimeoutKey = "wFiiCvRG"
        },
        {

          Camera = 104,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 1.1,
          TimeoutKey = "fCoAiEnH"
        },
        {

          IsCameraModeLocked = false,
          Type = 135,
          Timeout = 0.0
        },
        {

          CustomEventName = "addSwordInteract1",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "tkplLhYZ"
        },
        {

          CustomEventName = "addSwordInteract2",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "gYNIxNkp"
        },
        {

          CustomEventName = "addSwordInteract3",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "ocYTzyWo"
        },
        {

          CustomEventName = "addSwordInteract4",
          Type = 19,
          Timeout = 1.2,
          TimeoutKey = "YOVsPLJA"
        },
        {

          NPC = "Hero",
          Point = "out",
          Rotate = 15.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.2,
          TimeoutKey = "kmNPDwwx"
        },
        {

          ObjName = "/Root/Level2/331/timeline_rounding",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.2,
          TimeoutKey = "BSyfsaLn"
        },
        {

          ObjName = "/Root/Level2/331/timeline_original",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.2,
          TimeoutKey = "jenLCaCn"
        },
        {

          PosKey = "look",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 0.5,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 0.5,
          Type = 62,
          Timeout = 1.3,
          TimeoutKey = "zIbBYEcQ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "firstSwitch",
      Actions = {
        {

          TaskId = 3310404,
          Type = 5,
          Timeout = 0.0
        },
        {

          CustomEventName = "switch",
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

      ConditionActions = {
        {

          StoryId = 2231403,
          StepId = 3,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2231403,
          StepId = 0,
          Actions = {
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              TaskId = 3310402,
              Type = 5,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level2/331/timeline_rounding",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              PosKey = "look",
              IsOpen = true,
              CameraStyle = 1,
              Duration = -1.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = -1.0,
              Type = 62,
              Timeout = 0.5,
              TimeoutKey = "IiZvatSF"
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

      StoryID = 100231401,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 100231401,
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
      StoryId = 100231402,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 2,
    MonsterInfo = {
      [ 20105201 ] = 1,
      [ 20304602 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}