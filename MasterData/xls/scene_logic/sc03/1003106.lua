local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 1031003,
          Type = 0,
          Timeout = 0.0
        },
        {

          ObjName = "Level/T1/R3/Plat2_/sc03_04_anim_15",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/T1/R3/Plat4_/sc03_04_anim_15",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "M2",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "M2",
          Cd = 3.0,
          IgnoreLock = true,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "M3",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "M3",
          Cd = 3.0,
          IgnoreLock = true,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "M4",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "M4",
          Cd = 3.0,
          IgnoreLock = true,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ObjName = "Level/T1/R3/sc03_02_anim_05",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          KeyName = "M1",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(5)/switch_off",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 5.0,
          TimeoutKey = "uxfMHPGf"
        },
        {

          ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(4)/switch_off",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 5.0,
          TimeoutKey = "nWojfwTv"
        },
        {

          ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(3)/switch_off",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 5.0,
          TimeoutKey = "USaSrsxd"
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

          Path = "Level/T1/future1_1/sence_end",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomWall1",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          GroupID = 4,
          Type = 86,
          Timeout = 0.0
        },
        {

          PosKey = "EGG",
          NPCName = "KfUfLveK",
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
          NpcId = 638754001031028893,
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

          Key = "OFF",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NpcName = "M2",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "M3",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "M4",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "enter",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1031003,
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "enter",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TaskId = 103108,
              Type = 5,
              Timeout = 0.0
            },
            {

              KeyName = "tp3",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "OFF",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "OFF",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "OFF",
          Actions = {
            {

              NpcName = "M2",
              CanHit = false,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "M3",
              CanHit = false,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "M4",
              CanHit = false,
              Type = 77,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "enter",
          Actions = {
            {

              Camera = 1031001,
              IsNewConfig = false,
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

          Key = "tips",
          Actions = empty,
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

          Key = "tips",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "tp3",
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

          NPCId = 1031003,
          Actions = {
            {

              NPCId = 1031003,
              Type = 1,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/future1_1/4/4_5",
              Plat = "",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              TimelineName = "4-1-1Timeline",
              Fadein = 1.0,
              Fadeout = 1.0,
              IsCanSkip = false,
              NotPauseLua = true,
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

              TaskId = 103107,
              Type = 5,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat2_/sc03_04_anim_15/switch_on",
              PlatCount = 0,
              Type = 96,
              Timeout = 1.0,
              TimeoutKey = "sdasdw"
            },
            {

              Path = "Level/T1/R3/Plat4_/sc03_04_anim_15/switch_on",
              PlatCount = 0,
              Type = 96,
              Timeout = 1.0,
              TimeoutKey = "dvwedfs"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/sc03_04_anim_29/Box(MISSILE_AND_CHAR_BLOCK)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(5)/switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 5.0,
              TimeoutKey = "QujgEeuh"
            },
            {

              ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(4)/switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 5.0,
              TimeoutKey = "xylZXRbs"
            },
            {

              ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(3)/switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 5.0,
              TimeoutKey = "vMCcMXLW"
            },
            {

              ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(5)/switch_off",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 5.0,
              TimeoutKey = "CsGOaRhy"
            },
            {

              ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(4)/switch_off",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 5.0,
              TimeoutKey = "oJOtUCgh"
            },
            {

              ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(3)/switch_off",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 5.0,
              TimeoutKey = "yLcNisBx"
            }
          },
          FinishMarkVariable = "Q1",
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
        },
        {

          Index = 1,
          Type = 72,
          Timeout = 0.5,
          TimeoutKey = "SUhmQpai"
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

          TimelineName = "4-1-1Timeline",
          Actions = {
            {

              KeyName = "M3",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              TaskId = 103107,
              Type = 5,
              Timeout = 0.0,
              TimeoutKey = ""
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

          NPCName = "M2",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/4/4_2",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/future1_1/4/4_3",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/switch/sc03_prp_04a_pre(4)/switch_hit",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            },
            {

              GroupID = 1,
              Type = 86,
              Timeout = 0.0
            },
            {

              GroupID = 1,
              Type = 87,
              Timeout = 2.5,
              TimeoutKey = "RJOWFbEK"
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

          NPCName = "M3",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/4/4_2",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/future1_1/4/4-4",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/switch/sc03_prp_04a_pre(3)/switch_hit",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            },
            {

              GroupID = 1,
              Type = 86,
              Timeout = 0.0
            },
            {

              GroupID = 1,
              Type = 87,
              Timeout = 2.5,
              TimeoutKey = "pttVycaN"
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

          NPCName = "M4",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/4/4_3",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/future1_1/4/4-4",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/switch/sc03_prp_04a_pre(5)/switch_hit",
              PlatCount = 0,
              Type = 96,
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

      EventName = "彩蛋",
      Actions = {
        {

          EggID = 1004,
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

          TimelineName = "Level/T1/future1_1/4/4_2",
          Actions = {
            {

              GroupID = 1,
              Type = 87,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 23,
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}