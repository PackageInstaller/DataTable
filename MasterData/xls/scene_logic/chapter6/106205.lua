local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "npc1-2",
          Rotation = -25,
          NPCId = 10610401,
          NPCName = "唯实社成员",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "npc2",
          Rotation = 180,
          NPCId = 10610402,
          NPCName = "平民A",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "npc3",
          Rotation = -90,
          NPCId = 10610403,
          NPCName = "平民B",
          Type = 0,
          Timeout = 0.0
        },
        {

          GroupId = 10620501,
          Type = 27,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          KeyName = "d1",
          IsOpen = true,
          IsContinue = false,
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

      NoPassCamera = 106045,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 106045,
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

          Target = "God",
          MagicId = 106999,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX",
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

          Key = "enemy1",
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
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 106205002,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
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

          Key = "enemy2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 106205001,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
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

          Key = "cam",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "npc1-2",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.5,
              StopLuaScript = false,
              BackToDefault = false,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 2.5,
              Type = 62,
              Timeout = 0.0
            },
            {

              TaskId = 106101,
              Type = 5,
              Timeout = 0.0
            },
            {

              KeyName = "npc1-2",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              StoryId = 5060302,
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
          FinishMarkVariable = "cam1",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "cam1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "trg1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Tips = "972",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
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

          Key = "dialog",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 4060301,
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

          StoryId = 6060304,
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

              TreasureChestId = 10604,
              PosKey = "BOX1",
              Rotation = -90,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "BOXEND10604",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "EnQPUwFT"
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

          StoryId = 4060301,
          Actions = {
            {

              TaskId = 106102,
              Type = 5,
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

              CustomEventName = "yindaoxian",
              Type = 19,
              Timeout = 1.0,
              TimeoutKey = "aKUwDrll"
            },
            {

              NPC = "1_10620501_2",
              Point = "switch",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "QgcfnviR"
            },
            {

              Key = "heavy_on",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 2.0,
              TimeoutKey = "FzXZzgJS"
            },
            {

              PosKey = "d1",
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
              Timeout = 2.0,
              TimeoutKey = "QywTyWsL"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4060302,
          Actions = {
            {

              CondId = 106102,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            },
            {

              NPCId = 10610402,
              NPCName = "平民A",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "BODTaUHP"
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

          StoryId = 4060303,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 8,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 106205002,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 106205002,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "baohu",
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

              NPCId = 10610402,
              NPCActionName = "skill1_2",
              Type = 100,
              Timeout = 0.0
            },
            {

              NPCId = 10610403,
              NPCActionName = "skill1_2",
              Type = 100,
              Timeout = 0.0
            },
            {

              StoryId = 5060303,
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

          StoryId = 4060304,
          Actions = {
            {

              StoryId = 1001060301,
              EnableBlackFade = true,
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

          NPCId = 10610401,
          Actions = empty,
          ValidInTower = false
        },
        {

          NPCId = 10610402,
          Actions = {
            {

              StoryId = 4060302,
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

          NPCId = 10610403,
          Actions = {
            {

              StoryId = 4060303,
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

          NPCId = 1061001,
          Actions = {
            {

              Tips = "后续换成特殊宝箱事件",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Level_01/sc06_build_40_pre/TL_WaterWell",
              PlatCount = 0,
              Type = 96,
              Timeout = 1.0,
              TimeoutKey = "VGmBHMPa"
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

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "PREBOX2",
      Actions = {
        {

          CustomEventName = "PREBOX10632",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10633",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "DECT1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "PREBOX",
      Actions = {
        {

          CustomEventName = "DectBOX",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX3",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "CBnGsEhE"
        },
        {

          CustomEventName = "PREBOX4",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "vTBmFNcd"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10604",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "DectBOX2",
      Actions = {
        {

          Key = "DECT",
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
      ConditionVariable = "10633",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "BOX10604",
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

          TreasureChestId = 10604,
          PosKey = "BOX1",
          Rotation = -90,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10604",
          Type = 124,
          Timeout = 1.0,
          TimeoutKey = "GveEcCdu"
        },
        {

          PosKey = "BOX1",
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
          TimeoutKey = "KaIiAZoa"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOXEND10632",
      Actions = {
        {

          Variable = "10632",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX",
          Type = 19,
          Timeout = 0.1,
          TimeoutKey = "cvbEXNSZ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "PREBOX10632",
      Actions = {
        {

          PosKey = "LB1",
          Rotation = 0,
          NPCId = 106042,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10632",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "yindaoxian",
      Actions = {
        {

          KeyName = "d1",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.5,
          TimeoutKey = "eHZWFlWr"
        },
        {

          KeyName = "d1",
          IsOpen = false,
          IsContinue = true,
          Type = 70,
          Timeout = 3.5,
          TimeoutKey = "ubtzchax"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "switch",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "DectBOX",
      Actions = {
        {

          CustomEventName = "DectBOX10632",
          Type = 19,
          Timeout = 0.1,
          TimeoutKey = "icLQPhRA"
        },
        {

          CustomEventName = "DectBOX10633",
          Type = 19,
          Timeout = 0.1,
          TimeoutKey = "UwUPzdiE"
        },
        {

          Key = "DECT",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "DECT1",
          SyncValType = 2,
          Value = false,
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

      EventName = "PREBOX3",
      Actions = {
        {

          PosKey = "LB1",
          Rotation = 0,
          NPCId = 106044,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "DECT",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "DectBOX10633",
      Actions = {
        {

          Key = "DECT1",
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
      ConditionVariable = "10633",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "BOXEND10604",
      Actions = {
        {

          Variable = "10604",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10604CLOSE",
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

      EventName = "BOXEND10633",
      Actions = {
        {

          Variable = "10633",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX",
          Type = 19,
          Timeout = 0.1,
          TimeoutKey = "srgaWSQY"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "PREBOX1",
      Actions = {
        {

          PosKey = "LB1",
          Rotation = 0,
          NPCId = 106041,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "DECT1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "DectBOX10632",
      Actions = {
        {

          CustomEventName = "DectBOX2",
          Type = 19,
          Timeout = 0.0
        },
        {

          Key = "DECT1",
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
      ConditionVariable = "10632",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "baohu",
      Actions = {
        {

          CondId = 106103,
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

      EventName = "PREBOX4",
      Actions = {
        {

          CustomEventName = "PREBOX1",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX2",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "DECT",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "PREBOX10633",
      Actions = {
        {

          PosKey = "LB1",
          Rotation = 0,
          NPCId = 106043,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10633",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10604CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/Level_01/BoxGuideFx/Fx_Common_BoxGuide10604",
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

      EventName = "GBOX10604OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/Level_01/BoxGuideFx/Fx_Common_BoxGuide10604",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10604",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          TaskId = 106103,
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

              NPCId = 10610402,
              NPCName = "平民A",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "OjLPIguW"
            },
            {

              NPCId = 10610403,
              NPCName = "平民B",
              Type = 1,
              Timeout = 1.0,
              TimeoutKey = "uiCvCuaX"
            },
            {

              StoryId = 4060304,
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
              TimeoutKey = "MdVlOzZw"
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

          CustomEventName = "GBOX10604OPEN",
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

          CustomEventName = "GBOX10604CLOSE",
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
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 1001060301,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 3,
    MonsterCount = 15,
    MonsterInfo = {
      [ 20204901 ] = 12,
      [ 20205001 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}