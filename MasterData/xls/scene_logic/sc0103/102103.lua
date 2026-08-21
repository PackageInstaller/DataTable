local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          StoryId = 1020301,
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
          TimeoutKey = "XD"
        },
        {

          TimelineName = "timeline_n0233",
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
          Timeout = 1.0,
          TimeoutKey = "SXD"
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

          ObjName = "/Root/Change_/Change_bright/Level_1/T1-HENJI",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          PosKey = "EGG",
          NPCName = "jKgnUTgI",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate_weak|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 1.0
          },
          Rotation = 0,
          NpcId = 638753902479128897,
          IsRemove = false,
          CustomEventName = "彩蛋",
          Type = 92,
          Timeout = 0.0
        }
      },
      ValidInTower = true,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 10403,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10403,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          SkillLevel = 3,
          TowerValid = false,
          Type = 45,
          Timeout = 0.0
        },
        {

          Target = "1001008",
          MagicId = 4032189,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10205,
          PosKey = "F3",
          Rotation = 197,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "boxEnd10205",
          Type = 124,
          Timeout = 0.0
        },
        {

          CustomEventName = "prebox10204",
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "is_break2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "/Root/Change_/Change_bright/Level_1/T1-TL/timeline_n0228",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "is_break2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = empty,
      FinishMarkVariable = "is_break2",
      ValidInTower = true,
      Type = 2,
      ConditionVariable = "break2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "cam0",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              Target = "1001008",
              MagicId = 41021006,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "1001008",
              MagicId = 10001013,
              Type = 103,
              Timeout = 0.0
            },
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
      Type = 3,
      ConditionVariable = "cam1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "A1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 1021005,
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
              Timeout = 2.0,
              TimeoutKey = "AAA"
            },
            {

              AreaName = "A1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level_1/T1-TL/timeline_n0208",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
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
                WallObjPath = "emptywall",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 2464,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "QQQ",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 7.5,
              TimeoutKey = "SCC"
            }
          },
          ValidInTower = true
        },
        {

          Key = "A0",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "A0",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "W2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "W5",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              ObjName = "/GroupCtrlObj/T1-TL/timeline_n0212",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "K1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = true,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "F0",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = true
        },
        {

          Key = "C1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TipsId = 10210001,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "WA",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
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

          Key = "F2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "timeline_n0220",
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

              TipsId = 10210004,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 2.0,
              TimeoutKey = "SDDS"
            }
          },
          ValidInTower = false
        },
        {

          Key = "energy",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "cam1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "focus1",
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

              Target = "1001008",
              MagicId = 41021006,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "1001008",
              MagicId = 10001013,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              TipsId = 100187,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "cam1",
          ValidInTower = false
        },
        {

          Key = "cam2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "focus2",
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
              Timeout = 0.0,
              TimeoutKey = "rCyGDGMv"
            },
            {

              Target = "1001008",
              MagicId = 41021006,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "1001008",
              MagicId = 10001013,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
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

          Key = "F0",
          Actions = {
            {

              Camera = 1021003,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "WA",
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "K1",
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "energy",
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "cam2",
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              Target = "1001008",
              MagicId = 41021006,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "1001008",
              MagicId = 10001013,
              Type = 103,
              Timeout = 0.0
            },
            {

              TipsId = 100187,
              Visible = false,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              GroupID = 2,
              Type = 86,
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

          StoryId = 1020301,
          Actions = {
            {

              TimelineName = "timeline_n0233",
              Type = 7,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 6020501,
          Actions = {
            {

              PosKey = "Q1",
              Rotation = 0,
              NPCId = 1022028,
              NPCName = "chazhen",
              Type = 0,
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

          NPCId = 103305,
          Actions = {
            {

              GroupId = 100203,
              Type = 42,
              Timeout = 0.0
            },
            {

              SkillLevel = 4,
              TowerValid = false,
              Type = 45,
              Timeout = 0.0
            }
          },
          ValidInTower = true
        },
        {

          NPCId = 102141,
          Actions = {
            {

              ObjName = "/GroupCtrlObj/T1-TL/timeline_n0219",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 3.0,
              TimeoutKey = "F3"
            }
          },
          FinishMarkVariable = "",
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

          NPCId = 1022028,
          Actions = {
            {

              NPCId = 1022028,
              NPCName = "chazhen",
              Type = 1,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10204,
              PosKey = "Q1",
              Rotation = 90,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd10204",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "xmqtCDNl"
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0,
              TimeoutKey = "AIrkSgAT"
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

      EventName = "QQQ",
      Actions = {
        {

          GroupId = 100203,
          Type = 42,
          Timeout = 1.0,
          TimeoutKey = "SSSD"
        },
        {

          SkillLevel = 4,
          TowerValid = false,
          Type = 45,
          Timeout = 1.0,
          TimeoutKey = "SDASD"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "prebox10204",
      Actions = {
        {

          PosKey = "Q1",
          NPCName = "eNhDwPBK",
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
          NpcId = 638666005357901548,
          IsRemove = true,
          CustomEventName = "box",
          Type = 92,
          Timeout = 0.1,
          TimeoutKey = "PRhEapwM"
        },
        {

          NPCName = "eNhDwPBK",
          Type = 93,
          Timeout = 0.0
        },
        {

          NPCId = 1022028,
          NPCName = "chazhen",
          Type = 1,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10204",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "boxEnd10204",
      Actions = {
        {

          Variable = "10204",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10204CLOSE",
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

      EventName = "box",
      Actions = {
        {

          StoryId = 6020501,
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

      EventName = "彩蛋",
      Actions = {
        {

          EggID = 1007,
          Type = 131,
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

          TimelineName = "timeline_n02120",
          Actions = {
            {

              TipsId = 10210004,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0,
              TimeoutKey = "SDDS"
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_n0233",
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

      Actions = {
        {

          Target = "1001008",
          MagicId = 4032189,
          Type = 103,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10204CLOSE",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10204",
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

      EventName = "GBOX10204OPEN",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10204",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10204",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10205CLOSE",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10205",
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

      EventName = "GBOX10205OPEN",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10205",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10205",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "boxEnd10205",
      Actions = {
        {

          Variable = "10205",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10205CLOSE",
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

      Actions = {
        {

          CustomEventName = "GBOX10204OPEN",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10205OPEN",
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

          CustomEventName = "GBOX10204CLOSE",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10205CLOSE",
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
    [ 4 ] = {
      StoryId = 1020301,
      Name = "播放剧情"
    },
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 3,
    MonsterInfo = {
      [ 20102801 ] = 2,
      [ 20101101 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}