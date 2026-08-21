local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "timeline_n04",
          Fadein = 0.0,
          Fadeout = 3.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.5,
          Hold = 1.0,
          BlackOut = 0.5,
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

          PosKey = "A1",
          Rotation = 90,
          NPCId = 10104101,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "A2",
          Rotation = -90,
          NPCId = 10104102,
          Type = 0,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_n04003",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          CameraFarClipPlane = 500.0,
          Type = 107,
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
            "L0"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L1"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_Bright/Level",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          Key = "C1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "A1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 2.0,
              TimeoutKey = "ABrwmCkH"
            },
            {

              StoryId = 5040102,
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
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          Key = "C2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 4040102,
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
              Timeout = 0.5,
              TimeoutKey = "FDxZEEFZ"
            },
            {

              PosKey = "V",
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
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "VV",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 1041011,
                    param = 2,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 1041011,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "XXD",
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

              StoryId = 5040103,
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
              TimeoutKey = "SDASDAD"
            },
            {

              Target = "Hero",
              MagicId = 2020430113,
              Level = 0,
              Type = 16,
              Timeout = 0.5,
              TimeoutKey = "smjDaHWH"
            },
            {

              PosKey = "M2",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 1.0,
              StopLuaScript = false,
              BackToDefault = true,
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

          Key = "C4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 1,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 1041012,
                    param = 2,
                    Name = "全部杀死",
                    CustomEventName = "END",
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

              StoryId = 5040104,
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

              TimelineName = "timeline_n04001",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_n04002",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "A",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4040103,
          Actions = {
            {

              TaskId = 104102,
              Type = 5,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          StoryId = 4040102,
          Actions = {
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.5,
              TimeoutKey = "FSKVuuvI"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4040101,
          Actions = {
            {

              TimelineName = "timeline_n0400",
              Type = 7,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4040105,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 1.0,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPCId = 10104102,
              Type = 1,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4040104,
          Actions = {
            {

              StoryId = 1001040102,
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

          StoryId = 6040101,
          Actions = {
            {

              TreasureChestId = 10401,
              PosKey = "BOX1",
              Rotation = 90,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "vnhrDFsL"
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
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 10104101,
          Actions = {
            {

              TimelineName = "timeline_n0400",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.5,
              Hold = 1.0,
              BlackOut = 0.5,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 1.0,
              TimeoutKey = "IPuEdSLj"
            },
            {

              StoryId = 4040101,
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
              TimeoutKey = "bzDapRUl"
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

              NPCId = 10104101,
              Type = 1,
              Timeout = 2.0,
              TimeoutKey = "LuUCCfEE"
            },
            {

              TaskId = 104101,
              Type = 5,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          NPCId = 101106,
          Actions = {
            {

              TimelineName = "timeline_n04000",
              Fadein = 2.0,
              Fadeout = 2.0,
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

              ContainerName = "Level",
              Names = {
                "P0"
              },
              States = {
                "3"
              },
              SaveType = 0,
              Type = 97,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 10104102,
          Actions = {
            {

              StoryId = 4040105,
              EnableBlackFade = true,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
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

      EventName = "XXD",
      Actions = {
        {

          StoryId = 4040103,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 2.0,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.0,
          StopStayTime = 0.0,
          StopFadeOutTime = 0.0,
          NoSkipStory = true,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "drop",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 2.0,
          TimeoutKey = "ADA"
        },
        {

          TaskId = 104101,
          Type = 5,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/FD",
          Visible = true,
          IsAutoSave = false,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_n04003",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
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

          StoryId = 4040104,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 1.0,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.0,
          StopStayTime = 0.0,
          StopFadeOutTime = 0.0,
          NoSkipStory = true,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_n040021",
          IsPlay = true,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "kqYogTCJ"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "boxPre",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "box",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10401",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "boxEnd",
      Actions = {
        {

          Variable = "10401",
          Type = 128,
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

          TimelineName = "timeline_n04",
          Actions = {
            {

              Type = 46,
              Timeout = 0.0
            },
            {

              TaskGroupId = 1041,
              Type = 21,
              Timeout = 0.0
            },
            {

              StoryId = 5040101,
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

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_n04000",
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 1041011,
                    param = 2,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 1041011,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "XXD",
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

              StoryId = 2040102,
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

          TimelineName = "timeline_n04004",
          Actions = {
            {

              TimelineName = "timeline_n04001",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            },
            {

              Type = 60,
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

      ConditionActions = {
        {

          StoryId = 4040103,
          StepId = 6,
          Actions = {
            {

              PosKey = "V",
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
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4040103,
          StepId = 11,
          Actions = {
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_n04004",
              Fadein = 2.0,
              Fadeout = 3.0,
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
              Timeout = 1.5,
              TimeoutKey = "PNdGgwad"
            },
            {

              Type = 61,
              Timeout = 1.5,
              TimeoutKey = "UblmVGDf"
            }
          },
          FinishMarkVariable = "A",
          ValidInTower = false
        }
      },
      Type = 12,
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
      StoryId = 1001040102,
      Name = "剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 3,
    MonsterCount = 17,
    MonsterInfo = {
      [ 20104502 ] = 16,
      [ 20104601 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}