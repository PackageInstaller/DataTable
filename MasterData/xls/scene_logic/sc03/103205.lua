local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "O1",
          Rotation = 0,
          NPCId = 101106,
          Type = 0,
          Timeout = 0.0
        },
        {

          Path = "Level/Section_02/Component/timeline_32D5",
          PlatCount = 0,
          CustomEventName = "door",
          Type = 96,
          Timeout = 0.0
        },
        {

          TimelineName = "ZX05_on",
          Fadein = 0.0,
          Fadeout = 2.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = true,
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

          Path = "Level/Section_02/Zone_05/sc03_05_anim_12/switch_on",
          Rewind = 0.0,
          IsSaveState = true,
          Type = 56,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Section_02/Zone_05/sc03_05_anim_11/switch_on",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = "rDAdYlIL"
        },
        {

          Path = "/Root/Level/Section_02/Zone_05/sc03_05_anim_12/switch_on",
          Rewind = 0.1,
          IsSaveState = true,
          Type = 56,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
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

      NoPassCamera = 1031001,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1031001,
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

          IsSkip = true,
          Type = 36,
          Timeout = 0.0
        },
        {

          CustomEventName = "prebox",
          Type = 19,
          Timeout = 0.0
        },
        {

          PosKey = "EGG",
          NPCName = "XueqcDkk",
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
          NpcId = 638753905174568796,
          IsRemove = false,
          CustomEventName = "彩蛋",
          Type = 92,
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

          StoryId = 100103112,
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

          StoryId = 1031101,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 6,
                MonsterCount = 27,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "emptywall2",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10320501,
                    param = 1,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10320502,
                    param = 1,
                    Name = "全部杀死",
                    CustomEventName = "moster_1",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10320503,
                    param = 1,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10320504,
                    param = 1,
                    Name = "全部杀死",
                    CustomEventName = "moster_2",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10320505,
                    param = 1,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10320506,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "moster_3",
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

              AreaName = "CAM1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "CAM2",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 1031101,
          Actions = {
            {

              Seconds = 300,
              Text = "保护中枢",
              Type = 66,
              Timeout = 0.0
            },
            {

              Path = "Level/Section_02/Component/BACK_off",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 6030401,
          Actions = {
            {

              PosKey = "BOX1",
              Rotation = 0,
              NPCId = 1032032,
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

          NPCId = 1032032,
          Actions = {
            {

              NPCId = 1032032,
              NPCName = "chazhen",
              Type = 1,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10308,
              PosKey = "BOX1",
              Rotation = 90,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "TeBFdELj"
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

      ConditionActions = {
        {

          NPCId = 101106,
          Actions = {
            {

              TimelineName = "timeline_32j8",
              Fadein = 0.0,
              Fadeout = 1.0,
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
            },
            {

              Path = "Level/Section_02/Component/super_PC_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Section_02/Zone_05/sc03_05_anim_11/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 8.0,
              TimeoutKey = "dafgwegter"
            },
            {

              Path = "Level/Section_02/Zone_05/sc03_05_anim_12/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 8.0,
              TimeoutKey = "sdafgqwefrwe"
            },
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "A2",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 2.0,
              TimeoutKey = "Hero"
            },
            {

              TaskId = 103205,
              Type = 5,
              Timeout = 0.0
            },
            {

              Camera = 1031001,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 3.0,
              TimeoutKey = "cam"
            },
            {

              AreaName = "CAM1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "CAM2",
              RemoveForever = true,
              Type = 9,
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

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "boxEnd",
      Actions = {
        {

          Variable = "10308",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10308CLOSE",
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

      EventName = "moster_3",
      Actions = {
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          StoryId = 100103112,
          EnableBlackFade = false,
          DelayDestroy = true,
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
          TimeoutKey = "LihLkuAH"
        },
        {

          Group = 10320501,
          Type = 65,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Group = 10320502,
          Type = 65,
          Timeout = 0.0,
          TimeoutKey = ""
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "door",
      Actions = {
        {

          Camera = 1031006,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
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

      EventName = "moster_2",
      Actions = {
        {

          Path = "Level/Section_02/Component/T2_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          GroupId = 10320502,
          Type = 27,
          Timeout = 2.5,
          TimeoutKey = "UNIBwoOf"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "moster_1",
      Actions = {
        {

          Path = "Level/Section_02/Component/T1_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          GroupId = 10320501,
          Type = 27,
          Timeout = 2.5,
          TimeoutKey = "BdzflpFe"
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

          StoryId = 6030401,
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
      ConditionVariable = "10308",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "prebox",
      Actions = {
        {

          PosKey = "BOX1",
          NPCName = "kAfTiZyd",
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
          NpcId = 638666016269376698,
          IsRemove = true,
          CustomEventName = "box",
          Type = 92,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10308",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "彩蛋",
      Actions = {
        {

          EggID = 1003,
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

      EventName = "GBOX10308CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10308",
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

      EventName = "GBOX10308OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10308",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10308",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_32j8",
          Actions = {
            {

              StoryId = 1031101,
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

          NPCName = "P1",
          HitType = 0,
          Actions = {
            {

              GroupId = 10320504,
              Type = 27,
              Timeout = 0.0
            },
            {

              Group = 10320501,
              Type = 65,
              Timeout = 20.0,
              TimeoutKey = "AcMvjCJf"
            }
          },
          FinishMarkVariable = "P1",
          ValidInTower = false
        }
      },
      Type = 19,
      ConditionVariable = "P2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCName = "P1",
          HitType = 0,
          Actions = {
            {

              GroupId = 10320504,
              Type = 27,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "P1a",
          ValidInTower = false
        }
      },
      Type = 19,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCName = "P1",
          HitType = 0,
          Actions = {
            {

              Group = 10320504,
              Type = 65,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "P2",
          ValidInTower = false
        }
      },
      Type = 19,
      ConditionVariable = "P1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCName = "L1",
          HitType = 0,
          Actions = {
            {

              GroupId = 10320501,
              Type = 27,
              Timeout = 0.0
            },
            {

              Group = 10320501,
              Type = 65,
              Timeout = 5.0,
              TimeoutKey = "HrahBHiN"
            }
          },
          FinishMarkVariable = "222",
          ValidInTower = false
        }
      },
      Type = 19,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCName = "L2",
          HitType = 0,
          Actions = {
            {

              GroupId = 10320502,
              Type = 27,
              Timeout = 0.0
            },
            {

              Group = 10320502,
              Type = 65,
              Timeout = 5.0,
              TimeoutKey = "nrgiZjbo"
            }
          },
          ValidInTower = false
        }
      },
      Type = 19,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10308OPEN",
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

          CustomEventName = "GBOX10308CLOSE",
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
    EventCount = 1,
    MonsterCount = 27,
    MonsterInfo = {
      [ 20103601 ] = 7,
      [ 20104201 ] = 7,
      [ 20103201 ] = 8,
      [ 20101301 ] = 1,
      [ 20101201 ] = 2,
      [ 20101101 ] = 2
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}