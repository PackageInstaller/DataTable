local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ResId = 10210105,
          PosKey = "NPC1",
          Camp = 2,
          Rotation = 0,
          Level = 0,
          NPCName = "NPC1",
          Cd = 9999.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "NPC2",
          Camp = 2,
          Rotation = 0,
          Level = 0,
          NPCName = "NPC2",
          Cd = 9999.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "NPC3",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "NPC3",
          Cd = 9999.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          NpcName = "NPC3",
          CanHit = true,
          Type = 77,
          Timeout = 0.25,
          TimeoutKey = "alLyLSrw"
        },
        {

          TaskId = 103102,
          Type = 5,
          Timeout = 0.0
        },
        {

          TimelineName = "2-1-2Timeline",
          Fadein = 0.0,
          Fadeout = 2.0,
          IsCanSkip = false,
          NotPauseLua = true,
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
          Timeout = 0.4,
          TimeoutKey = "zAPdyQjz"
        },
        {

          Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 1.4,
          TimeoutKey = "15"
        },
        {

          Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 1.4,
          TimeoutKey = "16"
        },
        {

          FadeIn = 0.0,
          Hold = 0.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
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

          Key = "guide_switch",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 0,
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

          NpcName = "NPC3",
          CanHit = false,
          Type = 77,
          Timeout = 0.0
        },
        {

          PosKey = "NPC3",
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

          BackToDefault = true,
          Type = 63,
          Timeout = 4.0,
          TimeoutKey = "3"
        },
        {

          NpcName = "NPC1",
          CanHit = true,
          Type = 77,
          Timeout = 0.0
        },
        {

          NpcName = "NPC2",
          CanHit = true,
          Type = 77,
          Timeout = 0.0
        },
        {

          StartRoomId = 11,
          TargetRoomId = 7,
          IsOpen = false,
          Type = 24,
          Timeout = 0.0
        },
        {

          Index = 3,
          Type = 72,
          Timeout = 0.0
        },
        {

          Index = 4,
          Type = 72,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "room2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 1031006,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1031006,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Index = 2,
          Type = 72,
          Timeout = 0.5,
          TimeoutKey = "sFoUoPVC"
        },
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "tp2",
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

          Index = 3,
          Type = 72,
          Timeout = 0.5,
          TimeoutKey = "YNNtSVGD"
        },
        {

          Index = 4,
          Type = 72,
          Timeout = 0.5,
          TimeoutKey = "CBnWyLMY"
        },
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "tp34",
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

          IsOpen = false,
          Type = 79,
          Timeout = 0.0
        },
        {

          IsSkip = false,
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

          Key = "battle1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "NPC3Active",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              NpcName = "NPC3",
              CanHit = false,
              Type = 77,
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

          Key = "tp4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TaskId = 103103,
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

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 2.0,
          TimeoutKey = "4"
        }
      },
      FinishMarkVariable = "1003102_room1",
      ValidInTower = true,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "monster_end",
      Actions = {
        {

          Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 1.0,
          TimeoutKey = "15"
        },
        {

          Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 1.0,
          TimeoutKey = "16"
        },
        {

          PosKey = "tp4",
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
          Timeout = 1.0,
          TimeoutKey = "tp4"
        },
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 3.0,
          TimeoutKey = "ju"
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          FadeIn = 0.5,
          Hold = 0.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "M7",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "Hero"
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "tp2",
      ValidInTower = true,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "2-1-2Timeline",
          Actions = {
            {

              StoryId = 2030302,
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
                MonsterWave = 2,
                MonsterCount = 4,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 100310201,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 100310202,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "monster_end",
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

              TaskId = 103107,
              Type = 5,
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

          TimelineName = "3-2-4Timeline",
          Actions = {
            {

              Index = 2,
              Type = 73,
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

      Actions = {
        {

          Type = 71,
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

      ConditionActions = {
        {

          NPCName = "NPC3",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future2-3/3-2-3Timeline",
              Plat = "",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              TimelineName = "3-2-4Timeline",
              Fadein = 0.0,
              Fadeout = 2.0,
              IsCanSkip = true,
              NotPauseLua = true,
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

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_18/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/sc03_04_anim_08/sc03_04_anim_31 (1)/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 6.0,
              TimeoutKey = "11111"
            },
            {

              TaskId = 103105,
              Type = 5,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_11_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/sc03_04_anim_29/sc03_04_anim_29_06/sc03_prp_04a_pre(12)/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0
            },
            {

              AreaName = "NPC3Active",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "final_switch",
          ValidInTower = true
        },
        {

          NPCName = "NPC3",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_43/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43 (1)/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_43/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Index = 3,
              Type = 72,
              Timeout = 0.0
            },
            {

              Index = 4,
              Type = 72,
              Timeout = 0.0
            },
            {

              NpcName = "NPC3",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              KeyName = "tp2",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 1.0,
              TimeoutKey = "tp2222"
            },
            {

              Direction = 2,
              Type = 51,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "M12",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
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

          NPCName = "NPC3",
          HitType = 0,
          Actions = empty,
          FinishMarkVariable = "tp34",
          ValidInTower = true
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

          NPCName = "NPC1",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future2-3/bridge_left",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/sc03_04_anim_06/sc03_04_anim_06_06/sc03_prp_04a_pre(7)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              NpcName = "NPC1",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
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

      ConditionActions = {
        {

          NPCName = "NPC2",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future2-3/bridge_right",
              Plat = "",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/sc03_04_anim_07/sc03_04_anim_07_06/sc03_prp_04a_pre(8)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              NpcName = "NPC2",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 19,
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
    MonsterCount = 4,
    MonsterInfo = {
      [ 20103601 ] = 2,
      [ 20104201 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}