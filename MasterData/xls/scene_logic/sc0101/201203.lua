local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "Change_/Change_haze/Level_2/NPC_fake",
          Visible = true,
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

      NoPassCamera = 117,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 117,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          GroupId = 20120301,
          Type = 27,
          Timeout = 0.0
        },
        {

          Key = "trap_switch_on",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 20120302,
          Type = 27,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4032189,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10211,
          PosKey = "B1",
          Rotation = 90,
          IsPlayEffectAndSound = true,
          IsCanOpen = false,
          CustomEventName = "boxend10211",
          Type = 124,
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

          Key = "201111_CheckIsDead",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "over",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_haze/Level_2/NPC_fake",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Type = 35,
          Timeout = 0.0
        },
        {

          Key = "in_daze",
          SyncValType = 1,
          Value = 1.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 2.0,
          TimeoutKey = "NkZuLUBM"
        },
        {

          ResId = 20103901,
          PosKey = "NPC1",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 2,
          Level = 999,
          NPCName = "NPC",
          AutoSave = false,
          Type = 2,
          Timeout = 2.0,
          TimeoutKey = "jhBeqlxK"
        },
        {

          Key = "trap_switch_on",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "EDyvPDqC"
        },
        {

          NPC = "Hero",
          Point = "Begin",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "RAVCquDN"
        },
        {

          Type = 61,
          Timeout = 0.0
        },
        {

          Type = 60,
          Timeout = 3.0,
          TimeoutKey = "ignkLISm"
        },
        {

          Type = 14,
          Timeout = 0.0
        },
        {

          FadeIn = 0.5,
          Hold = 2.5,
          FadeOut = 1.0,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Group = 20120304,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "RAhMeWsL"
        },
        {

          NpcName = "NPC",
          Type = 83,
          Timeout = 1.0,
          TimeoutKey = "nxhYfpOH"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "201111_CheckIsDead",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "201111_ArriveDestination",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Type = 34,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "201111_ArriveDestination",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "talk",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 100102092,
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
              Timeout = 2.0,
              TimeoutKey = "1"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              PosKey = "NPC1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
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

          Key = "tips",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TipsId = 100187,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "tips1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TipsId = 100187,
              Visible = true,
              Flip = false,
              Type = 15,
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

          Key = "atk",
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 20120311,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "box10211",
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
        }
      },
      Type = 3,
      ConditionVariable = "10211",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          Key = "NPC",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "guide11",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "guide2",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
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

          Key = "block",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "timeline_n0240",
              Fadein = 2.0,
              Fadeout = 0.5,
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

              StoryId = 1020901,
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

          Key = "battle",
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 20120301,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "trap",
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

              GroupID = 1,
              Type = 86,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "battle2",
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
                WallObjPath = "",
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 20120302,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "jieshu",
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

          Key = "over",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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
                    Id = 20120304,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "over_show",
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

              Key = "over",
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
      ConditionVariable = "over",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "husong",
          Actions = {
            {

              TimelineName = "timeline_B0204_1",
              Fadein = 1.0,
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

              StoryId = 2020903,
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

              AreaName = "husong",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "tips",
          Actions = {
            {

              TipsId = 100187,
              Visible = false,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "tips1",
          Actions = {
            {

              TipsId = 100187,
              Visible = false,
              Flip = false,
              Type = 15,
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

          StoryId = 1020901,
          Actions = {
            {

              TimelineName = "timeline_B0204",
              Fadein = 1.0,
              Fadeout = 1.0,
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
              Timeout = 0.5,
              TimeoutKey = "x"
            },
            {

              TimelineName = "timeline_n0240",
              Type = 7,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 100102101,
          Actions = {
            {

              GroupId = 100304,
              Type = 42,
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

          StoryId = 100102092,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              BackToDefault = false,
              Type = 63,
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
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          GroupId = 100304,
          Actions = {
            {

              Key = "in_daze",
              SyncValType = 1,
              Value = 0.0,
              selectIdx = 1,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              TaskId = 102201,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 8,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "1",
      Actions = {
        {

          Type = 22,
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

      EventName = "trap",
      Actions = {
        {

          Target = "1_20120302_0",
          MagicId = 1021010301,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        },
        {

          GroupId = 20120303,
          Type = 27,
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

      EventName = "jieshu",
      Actions = {
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          KeyName = "NPC1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 87,
          Timeout = 0.0
        },
        {

          Group = 20120302,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 20120303,
          Type = 65,
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

      EventName = "over_show",
      Actions = {
        {

          Type = 22,
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

      EventName = "box10211",
      Actions = {
        {

          TreasureChestId = 10211,
          IsCanOpen = true,
          Type = 125,
          Timeout = 0.0
        },
        {

          PosKey = "B1",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 0.5,
          TimeoutKey = "cNRyuLCm"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "boxend10211",
      Actions = {
        {

          Variable = "10211",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10211CLOSE",
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

      EventName = "GBOX10211CLOSE",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10211",
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

      EventName = "GBOX10211OPEN",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10211",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10211",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_B0204_1",
          Actions = {
            {

              KeyName = "NPC1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_B0204",
          Actions = {
            {

              KeyName = "guide1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
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

      Actions = empty,
      ValidInTower = false,
      Type = 13,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          ObjName = "Change_/Change_haze/Level_2/NPC_fake",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Type = 35,
          Timeout = 0.0
        },
        {

          Key = "in_daze",
          SyncValType = 1,
          Value = 1.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ResId = 20103901,
          PosKey = "NPC1",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 2,
          Level = 999,
          NPCName = "NPC",
          AutoSave = false,
          Type = 2,
          Timeout = 0.0
        },
        {

          Key = "trap_switch_on",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 21,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10211OPEN",
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

          CustomEventName = "GBOX10211CLOSE",
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
      StoryId = 100102092,
      Name = "剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 4,
    MonsterCount = 11,
    MonsterInfo = {
      [ 20102801 ] = 1,
      [ 20103001 ] = 10
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}