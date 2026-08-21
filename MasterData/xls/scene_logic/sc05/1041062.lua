local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "NPC1",
          Rotation = -30,
          NPCId = 10104103,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC1",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = false,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 2.0,
          Type = 62,
          Timeout = 1.0,
          TimeoutKey = "OMzGSkoo"
        },
        {

          ObjName = "/Root/Level/12/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/12/sc05_prp_55b_pre0/1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L14"
          },
          States = {
            "2"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          Configs = {
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10480201",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10480202",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            }
          },
          Type = 104,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/SceneNPC1_/104802",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupId = 10480201,
          Type = 27,
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

      NoPassCamera = 10402,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10402,
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

          ContainerName = "Level",
          Names = {
            "L10"
          },
          States = {
            "2"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L9"
          },
          States = {
            "2"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          Intensity = 0.01,
          Type = 105,
          Timeout = 0.0
        },
        {

          GroupID = 5,
          Type = 86,
          Timeout = 0.0
        },
        {

          CustomEventName = "prebox10409",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10411",
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

          Key = "C2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 7,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                ActionTag = "2",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10410922,
                    param = 1,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10510623,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 2.0,
              TimeoutKey = "boRnSAqt"
            },
            {

              StoryId = 5041602,
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
              TimeoutKey = "oFHxFPCF"
            }
          },
          ValidInTower = false
        },
        {

          Key = "C3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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
                ActionTag = "1",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10410924,
                    param = 1,
                    Name = "全部杀死",
                    CustomEventName = "",
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

          Key = "C4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 5041601,
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

              Camera = 10406,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "story_finish",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "C1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 2,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10410921,
                    param = 1,
                    Name = "全部杀死",
                    CustomEventName = "",
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

              PosKey = "center",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 1.5,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              Intensity = 0.02,
              Type = 105,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "story_finish",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 5041602,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 5041601,
          Actions = {
            {

              ContainerName = "Level",
              Names = {
                "L13"
              },
              States = {
                "0"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 2.0,
              TimeoutKey = "xeuVxlgF"
            },
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4041602,
          Actions = {
            {

              NPCId = 10104103,
              NPCName = "1",
              Type = 1,
              Timeout = 0.0
            },
            {

              TaskId = 104901,
              Type = 5,
              Timeout = 0.0
            },
            {

              Key = "story_finish",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/12/sc05_prp_55b_pre0/sc05_prp_55b_02_mod",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/12/sc05_prp_55b_pre0/1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Target = "1_10480201_0",
              MagicId = 2010050124,
              Level = 1,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "1_10480201_1",
              MagicId = 2010050124,
              Level = 1,
              Type = 16,
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

          NPCId = 10104103,
          Actions = {
            {

              StoryId = 4041602,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.0,
              PlayStayTime = 0.0,
              PlayFadeOutTime = 0.0,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 1.0,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "story_finish",
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

          NPCId = 1042034,
          Actions = {
            {

              NPCId = 1042034,
              NPCName = "chazhen",
              Type = 1,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10409,
              PosKey = "PBOX1",
              Rotation = 180,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd10409",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "mzRelCeI"
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 1042035,
          Actions = {
            {

              NPCId = 1042035,
              NPCName = "1",
              Type = 1,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10411,
              PosKey = "BOX1",
              Rotation = 180,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "BOXEND10411",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "svqrVyXy"
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
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

          Direction = 1,
          Type = 51,
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

      EventName = "boxend10412",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "END",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
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

      EventName = "BOX10411",
      Actions = {
        {

          PosKey = "BOX1",
          Rotation = 0,
          NPCId = 1042035,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        },
        {

          CustomEventName = "BOX10411STORYBUG",
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

      EventName = "PREBOX10411",
      Actions = {
        {

          PosKey = "BOXNPC1",
          Rotation = 0,
          NPCId = 104111,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10411",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "boxEnd10409",
      Actions = {
        {

          Variable = "10409",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10409CLOSE",
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

      EventName = "box10409",
      Actions = {
        {

          PosKey = "PBOX1",
          Rotation = 0,
          NPCId = 1042034,
          NPCName = "chazhen",
          Type = 0,
          Timeout = 1.0,
          TimeoutKey = "aiWfYqIq"
        },
        {

          StoryId = 6040801,
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

      EventName = "BOX10411STORYBUG",
      Actions = {
        {

          StoryId = 6040901,
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
      ConditionVariable = "bug",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOXEND10411",
      Actions = {
        {

          Variable = "10411",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10411CLOSE",
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

      EventName = "box10412",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10412",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "prebox10409",
      Actions = {
        {

          PosKey = "PBOX1",
          NPCName = "hIfvTgDA",
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
          NpcId = 638755825855981353,
          IsRemove = true,
          CustomEventName = "box10409",
          Type = 92,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10409",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10409OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10409",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10409",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10409CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10409",
          IsAutoSave = false,
          Type = 53,
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

      EventName = "GBOX10411OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10411",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10411",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10411CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10411",
          IsAutoSave = false,
          Type = 53,
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

          StoryId = 5041601,
          StepId = 2,
          Actions = {
            {

              PosKey = "tp4",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
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
        },
        {

          StoryId = 5041601,
          StepId = 3,
          Actions = {
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            },
            {

              PosKey = "tp1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.5,
              TimeoutKey = "gjirCkiz"
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

          ActionTagMap = {
            [ 1 ] = "1",
            [ 2 ] = "2"
          },
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              CustomEventName = "box10412",
              Type = 19,
              Timeout = 0.5,
              TimeoutKey = "lrMWYVGf"
            }
          },
          ValidInTower = false
        }
      },
      Type = 28,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10409OPEN",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10411OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10409CLOSE",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10411CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 40,
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
    EventCount = 3,
    MonsterCount = 15,
    MonsterInfo = {
      [ 20104501 ] = 1,
      [ 20204601 ] = 5,
      [ 20204301 ] = 7,
      [ 20204401 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}