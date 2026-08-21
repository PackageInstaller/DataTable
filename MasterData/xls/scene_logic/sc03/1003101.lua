local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Path = "Level/Section_02/Zone_02/sc03_02_anim_02 (1)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/Section_02/Zone_02/sc03_02_anim_02 (1)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/Section_02/Zone_02/sc03_prp_04a_pre/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          SkillLevel = 6,
          TowerValid = false,
          Type = 45,
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

          PosKey = "O1",
          Rotation = 0,
          NPCId = 101208,
          Type = 0,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R1/sc03_prp_04a_pre/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          Type = 37,
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

          ResId = 10210105,
          PosKey = "A6",
          Camp = 2,
          Rotation = 0,
          Level = 0,
          NPCName = "bridge_1",
          Cd = 9999.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          IsOpen = false,
          Type = 79,
          Timeout = 0.0
        },
        {

          IsSkip = false,
          Type = 36,
          Timeout = 0.0
        },
        {

          NpcName = "bridge_1",
          CanHit = true,
          Type = 77,
          Timeout = 1.0,
          TimeoutKey = "bridge_1"
        },
        {

          CustomEventName = "box",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
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

          PosKey = "C2",
          Rotation = 0,
          NPCId = 1031003,
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "final_switch",
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

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          GroupID = 5,
          Type = 86,
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

          Key = "guide_switch",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TimelineName = "3-2-7",
          Fadein = 0.0,
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
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Path = "Level/T1/R3/sc03_04_anim_29/sc03_04_anim_29_06/sc03_prp_04a_pre(12)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          KeyName = "F1",
          IsOpen = false,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "C1",
          Camp = 2,
          Rotation = 0,
          Level = 0,
          NPCName = "3_1",
          Cd = 9999.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
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

          Index = 1,
          Type = 72,
          Timeout = 0.5,
          TimeoutKey = "SlTAyvzs"
        },
        {

          Index = 4,
          Type = 72,
          Timeout = 0.5,
          TimeoutKey = "fdzwnBqK"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "guide_switch",
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

          NpcName = "C6",
          CanHit = true,
          Type = 77,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          NpcName = "C7",
          CanHit = true,
          Type = 77,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          ObjName = "/Root/Level/T1/R3/Plat2_/sc03_04_anim_15",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/Plat4_/sc03_04_anim_15",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomWall1",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Index = 2,
          Type = 72,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/future1_1/R1/light_off",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "endend",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "CAM1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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
        },
        {

          Key = "CAM5",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              GroupId = 1003012,
              Type = 42,
              Timeout = 0.0
            },
            {

              TipsId = 1003012,
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

          Key = "CD_NPC",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 103101,
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

          Key = "CAM3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 101503,
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

          Key = "FUCK",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NpcName = "C6",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "C7",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "room2",
              CanHit = true,
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

          Key = "CAM5",
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

          Key = "CAM4",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "B2",
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
              TimeoutKey = "OWHnciyo"
            },
            {

              TimelineName = "timeline_NPC_1003101",
              IsPlay = true,
              Type = 110,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "end1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 100103022,
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
              Timeout = 0.0,
              TimeoutKey = "LlXWHYOe"
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

          Key = "JU1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "A1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.1,
              TimeoutKey = "AuQKHNnR"
            }
          },
          FinishMarkVariable = "103102",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "103102",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "CAM2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1031002,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              CustomEventName = "播放剧情1030201",
              Type = 19,
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

          Key = "JU1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NpcName = "bridge_1",
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

          Key = "emptywall3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              ObjName = "Level/T1/future1_1/sence",
              Visible = true,
              IsAutoSave = true,
              SaveType = 1,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/future1_1/R1/light_off",
              Visible = true,
              IsAutoSave = true,
              SaveType = 1,
              Type = 13,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "sence",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "sence",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10310103,
                    param = 2,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10310104,
                    param = 1,
                    Name = "全部杀死",
                    CustomEventName = "K1",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Camera = 1031005,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              Target = "0_10310103_0",
              MagicId = 20103601014,
              Level = 0,
              Type = 16,
              Timeout = 1.0,
              TimeoutKey = "magic1"
            }
          },
          FinishMarkVariable = "K1",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "CAM3",
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
                WallObjPath = "emptywall",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 103101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "sence",
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

              Path = "Level/Section_02/Zone_02/Plat7_/sc03_02_anim_03 (1)/switch_on",
              Plat = "",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "CAM3",
          ValidInTower = true
        }
      },
      Type = 3,
      ConditionVariable = "CAM3",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "bridge",
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
        },
        {

          Key = "JU1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NpcName = "bridge_1",
              CanHit = false,
              Type = 77,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "bridge_cam",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "Q1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1031003,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              TaskId = 103108,
              Type = 5,
              Timeout = 0.0
            },
            {

              ResId = 10210105,
              PosKey = "B1",
              Camp = 2,
              Rotation = 0,
              Level = 0,
              NPCName = "4_2",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.0
            },
            {

              ResId = 10210105,
              PosKey = "B2",
              Camp = 2,
              Rotation = 0,
              Level = 0,
              NPCName = "4_3",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.0,
              TimeoutKey = "S"
            },
            {

              ResId = 10210105,
              PosKey = "B3",
              Camp = 2,
              Rotation = 0,
              Level = 0,
              NPCName = "4_4",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/Plat4_/sc03_04_anim_15",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/Plat2_/sc03_04_anim_15",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "Q2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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
        },
        {

          Key = "NPC",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 2030402,
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

              ObjName = "/Root/Level/T1/R3/Plat4_/sc03_04_anim_15",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/Plat2_/sc03_04_anim_15",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              KeyName = "tp3",
              IsOpen = false,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "Q1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "M21",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "JU1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.1,
              TimeoutKey = "KpyDkFqH"
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

          Key = "CAM1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 4,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "emptywall",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10310101,
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
                    Id = 10310102,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "guide_1",
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
          FinishMarkVariable = "MONSTER1",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "MONSTER1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "guide_1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              GuideId = 103101,
              Type = 41,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "timer",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "Q3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              NpcName = "4_2",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "4_3",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "4_4",
              CanHit = true,
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

          Key = "bridge",
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
      ConditionVariable = "bridge_cam",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "CAM3",
          Actions = {
            {

              Camera = 1031001,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = ""
            }
          },
          ValidInTower = false
        },
        {

          Key = "CAM2",
          Actions = {
            {

              Camera = 1031001,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = ""
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

          Key = "CAM5",
          Actions = {
            {

              Camera = 1031001,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = ""
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

          Key = "Q3",
          Actions = {
            {

              NpcName = "4_2",
              CanHit = false,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "4_3",
              CanHit = false,
              Type = 77,
              Timeout = 0.0
            },
            {

              NpcName = "4_4",
              CanHit = false,
              Type = 77,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "JU1",
          Actions = {
            {

              NpcName = "bridge_1",
              CanHit = true,
              Type = 77,
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

          StoryId = 100103031,
          Actions = {
            {

              TaskId = 103101,
              Type = 5,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1999217,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              FadeIn = 0.0,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/sc03_02_anim_05",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Pos = 2,
              SavePos = 0,
              IsGoOut = true,
              Type = 78,
              Timeout = 0.75,
              TimeoutKey = "OnEnSrJs"
            },
            {

              Tips = "1024",
              Duration = 3.0,
              IsOpen = true,
              Type = 94,
              Timeout = 1.0,
              TimeoutKey = "WpheogbK"
            },
            {

              TimelineName = "timeline_NPC_1003101",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 100103021,
          Actions = {
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
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

          StoryId = 100103022,
          Actions = {
            {

              TimelineName = "1-1-1Timeline",
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

          StoryId = 6030101,
          Actions = {
            {

              TreasureChestId = 10301,
              PosKey = "BOX1",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "rtlKYQUO"
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

          StoryId = 2030301,
          Actions = {
            {

              Camera = 1031001,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = "rPNLuOZj"
            },
            {

              TimelineName = "1-1-4Timeline",
              Type = 7,
              Timeout = 0.5,
              TimeoutKey = "fllxBUPs"
            },
            {

              TaskId = 103102,
              Type = 5,
              Timeout = 0.5,
              TimeoutKey = "PYqpngaJ"
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

          StoryId = 1030201,
          Actions = {
            {

              TaskGroupId = 1031,
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
              Plat = "plat6",
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

              Index = 1,
              Type = 72,
              Timeout = 0.0
            },
            {

              Index = 4,
              Type = 72,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat2_/sc03_04_anim_15/switch_on",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.5,
              TimeoutKey = "846847"
            },
            {

              Path = "Level/T1/R3/Plat4_/sc03_04_anim_15/switch_on",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.5,
              TimeoutKey = "87468498"
            },
            {

              KeyName = "B1",
              IsOpen = false,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
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

      ConditionActions = {
        {

          NPCId = 101208,
          Actions = {
            {

              Enable = true,
              Type = 17,
              Timeout = 0.0
            },
            {

              GroupId = 100301,
              Type = 42,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "timer",
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

          NPCId = 1031002,
          Actions = {
            {

              Camera = 1031003,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 8.0,
              TimeoutKey = "stair_1"
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 8.0,
              TimeoutKey = "stair_2"
            },
            {

              StoryId = 2030301,
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
              Timeout = 12.0,
              TimeoutKey = "story_1"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              ObjName = "Level/T1/future1_1/sence_on",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/sc03_02_anim_05",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 1031002,
          Actions = {
            {

              Path = "Level/T1/R3/switch/sc03_prp_04a_pre(34)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat2_/sc03_04_anim_13/sc03_04_anim_13_03/sc03_prp_04a_pre(40)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/sc03_prp_04a_pre (12)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43 (1)/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat4_/sc03_04_anim_14/sc03_04_anim_14_03/sc03_prp_04a_pre(40)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre (34)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_11_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_10/sc03_04_anim_10_03/sc03_prp_04a_pre(36)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_10/sc03_prp_04a_pre(37)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
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

          NPCId = 1031004,
          Actions = empty,
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

      ConditionActions = {
        {

          GroupId = 100301,
          Actions = {
            {

              ResId = 10210105,
              PosKey = "A3",
              Camp = 2,
              Rotation = 0,
              Level = 0,
              NPCName = "door",
              Cd = 9999.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R1/sc03_prp_04a_pre/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 2.0,
              TimeoutKey = "door"
            },
            {

              TimelineName = "1-1-2Timeline",
              Fadein = 0.5,
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
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              SkillLevel = 7,
              TowerValid = false,
              Type = 45,
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

      EventName = "monster_2",
      Actions = {
        {

          Path = "Level/T1/R3/sc03_04_anim_19/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 2.5,
          TimeoutKey = "1"
        },
        {

          TimelineName = "2-1-1Timeline",
          Fadein = 1.0,
          Fadeout = 1.0,
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
          Timeout = 1.0,
          TimeoutKey = "VKYcXlJa"
        },
        {

          Path = "Level/T1/R3/switch/sc03_prp_04a_pre(34)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 4.5,
          TimeoutKey = "2"
        },
        {

          Direction = 1,
          Type = 51,
          Timeout = 0.0
        },
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "A2",
          Camp = 2,
          Rotation = 0,
          Level = 0,
          NPCName = "bridge_down",
          Cd = 9999.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
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

      EventName = "boxPre",
      Actions = {
        {

          StoryId = 6030101,
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

      EventName = "sence",
      Actions = {
        {

          ObjName = "Level/T1/future1_1/sence",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/future1_1/R1/light_off",
          Visible = true,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(5)/switch_off",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(4)/switch_off",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(3)/switch_off",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "sence",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "sence",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "boxEnd",
      Actions = {
        {

          Variable = "10301",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10301CLOSE",
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

      EventName = "switch",
      Actions = {
        {

          Path = "Level/T1/R3/switch/sc03_prp_04a_pre(5)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/switch/sc03_prp_04a_pre(4)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/switch/sc03_prp_04a_pre(3)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat3_/sc03_04_anim_10/sc03_prp_04a_pre(37)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/switch/sc03_prp_04a_pre(34)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat1_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat2_/sc03_04_anim_13/sc03_04_anim_13_03/sc03_prp_04a_pre(40)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/sc03_prp_04a_pre (12)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat3_/sc03_04_anim_43 (1)/sc03_prp_04a_pre (11)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat4_/sc03_04_anim_14/sc03_04_anim_14_03/sc03_prp_04a_pre(40)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat5_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre (34)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_11_02/sc03_prp_04a_pre(11)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat3_/sc03_04_anim_10/sc03_04_anim_10_03/sc03_prp_04a_pre(36)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat3_/sc03_04_anim_10/sc03_prp_04a_pre(37)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
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

      EventName = "guide_1",
      Actions = {
        {

          KeyName = "M21",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
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

      EventName = "K1",
      Actions = {
        {

          ResId = 10210105,
          PosKey = "F1",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "room2",
          Cd = 9999.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 4.0,
          TimeoutKey = "room2"
        },
        {

          TimelineName = "1-1-3Timeline",
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
          Timeout = 0.5,
          TimeoutKey = "tl"
        },
        {

          Path = "Level/T1/R3/Plat3_/sc03_04_anim_10/sc03_04_anim_10_03/sc03_prp_04a_pre(36)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 3.0,
          TimeoutKey = "switch"
        },
        {

          Camera = 1031001,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "CC",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.5,
          TimeoutKey = "CC"
        },
        {

          Path = "Level/T1/R3/Plat5_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat4_/sc03_04_anim_14/sc03_04_anim_14_03/sc03_prp_04a_pre(40)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat2_/sc03_04_anim_13/sc03_04_anim_13_03/sc03_prp_04a_pre(40)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat1_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat3_/sc03_04_anim_43 (1)/sc03_prp_04a_pre (11)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/sc03_prp_04a_pre (12)/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          NpcName = "P5",
          CanHit = true,
          Type = 77,
          Timeout = 1.0,
          TimeoutKey = "gdWrUnSk"
        },
        {

          NpcName = "P4_1",
          CanHit = true,
          Type = 77,
          Timeout = 1.0,
          TimeoutKey = "BqiLYSSF"
        },
        {

          NpcName = "P4_2",
          CanHit = true,
          Type = 77,
          Timeout = 1.0,
          TimeoutKey = "PKPUFZXa"
        },
        {

          NpcName = "P2_1",
          CanHit = true,
          Type = 77,
          Timeout = 1.0,
          TimeoutKey = "bCOtFHsn"
        },
        {

          NpcName = "P2_2",
          CanHit = true,
          Type = 77,
          Timeout = 1.0,
          TimeoutKey = "aMORQAqb"
        },
        {

          NpcName = "P1",
          CanHit = true,
          Type = 77,
          Timeout = 1.0,
          TimeoutKey = "UuTqbatH"
        },
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          FadeIn = 1.0,
          Hold = 0.5,
          FadeOut = 1.0,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          NpcName = "P5",
          Type = 83,
          Timeout = 1.25,
          TimeoutKey = "JsUSUoOf"
        },
        {

          NpcName = "P1",
          Type = 83,
          Timeout = 1.25,
          TimeoutKey = "ktMMOkNp"
        },
        {

          NpcName = "P4_1",
          Type = 83,
          Timeout = 1.25,
          TimeoutKey = "pOFERKqu"
        },
        {

          NpcName = "P4_2",
          Type = 83,
          Timeout = 1.25,
          TimeoutKey = "RAQIkCUj"
        },
        {

          NpcName = "P2_1",
          Type = 83,
          Timeout = 1.25,
          TimeoutKey = "zRvtbkOa"
        },
        {

          NpcName = "P2_2",
          Type = 83,
          Timeout = 1.25,
          TimeoutKey = "priQKZIv"
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

          PosKey = "BOX1",
          NPCName = "Yaqqkvot",
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
          NpcId = 638625385028463057,
          IsRemove = true,
          CustomEventName = "boxPre",
          Type = 92,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10301",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "播放剧情1030201",
      Actions = {
        {

          StoryId = 1030201,
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
          TimeoutKey = "jAPZsrOE"
        }
      },
      FinishMarkVariable = "1030201",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "1030201",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "二次返回开关_尝试显示tp",
      Actions = {
        {

          Key = "二次返回开关_clear",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.5,
          TimeoutKey = "MbCnyvSi"
        },
        {

          Index = 1,
          Type = 73,
          Timeout = 1.0,
          TimeoutKey = "DhHiMEBA"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "二次返回开关_clear",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "二次返回开关_尝试隐藏tp",
      Actions = {
        {

          Key = "二次返回开关_clear",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.5,
          TimeoutKey = "dHNeZfrY"
        },
        {

          Index = 1,
          Type = 72,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "二次返回开关_clear",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10301CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10301",
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

      EventName = "GBOX10301OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuideFx/Fx_Common_BoxGuide10301",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10301",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          TimelineName = "3-2-6Timeline",
          Actions = empty,
          ValidInTower = false
        },
        {

          TimelineName = "3-2-7",
          Actions = {
            {

              StoryId = 2030303,
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
              TimeoutKey = "story"
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "3-2-5Timeline",
          Actions = {
            {

              StoryId = 2030304,
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

          TimelineName = "3-2-6Timeline",
          Actions = empty,
          ValidInTower = false
        },
        {

          TimelineName = "2-1-1Timeline",
          Actions = empty,
          ValidInTower = false
        },
        {

          TimelineName = "1-1-4Timeline",
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 5,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "emptywall3",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 103102,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    TimeoutKey = "",
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 103103,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "monster_2",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 3.0,
              TimeoutKey = "monster_2"
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

          StoryId = 2030301,
          StepId = 1,
          Actions = {
            {

              TimelineName = "1-1-4Timeline",
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

          StoryId = 100103031,
          StepId = 1,
          Actions = {
            {

              PosKey = "A1",
              Rotation = 0,
              NPCId = 1031002,
              Type = 0,
              Timeout = 0.0
            },
            {

              KeyName = "A1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              PosKey = "A1",
              Rotation = 0,
              NPCId = 1031002,
              Type = 0,
              Timeout = 0.0
            },
            {

              ObjName = "Level/T1/future1_1/R3_1/NPC",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "NPC2",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            },
            {

              ObjName = "Level/T1/future1_1/sence",
              Visible = true,
              IsAutoSave = true,
              SaveType = 1,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(5)/switch_off",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(4)/switch_off",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/T1/R3/switch/sc03_prp_04a_pre(3)/switch_off",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_NPC_1003101",
              IsPlay = true,
              Type = 110,
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

          StoryId = 100103022,
          StepId = 22,
          Actions = {
            {

              Target = "Hero",
              Type = 37,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_NPC_1003101",
              IsPlay = false,
              Type = 110,
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

          NPCName = "P4_1",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/T1/future1_1/3/P4",
              Plat = "plat4",
              Rewind = 4.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat4_/sc03_04_anim_14/sc03_04_anim_14_03/sc03_prp_04a_pre(40)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "P4_2",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/P4",
              Plat = "plat4",
              Rewind = 4.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43 (1)/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "3_1-2",
          HitType = 0,
          Actions = {
            {

              TimelineName = "3-2-5Timeline",
              Fadein = 0.5,
              Fadeout = 1.0,
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

              Path = "Level/T1/future1_1/3/all_plat",
              Plat = "plat5,plat4,plat3,plat2,plat1",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_12_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 2.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_11_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "3_1",
          HitType = 0,
          Actions = {
            {

              TimelineName = "3-2-5Timeline",
              Fadein = 0.5,
              Fadeout = 1.0,
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

              Path = "Level/T1/future1_1/3/all_plat",
              Plat = "plat5,plat4,plat3,plat2,plat1",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_12_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_17/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "3_1",
          HitType = 0,
          Actions = {
            {

              Index = 1,
              Type = 72,
              Timeout = 0.0
            },
            {

              Index = 4,
              Type = 72,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "F1",
              IsOpen = false,
              IsContinue = false,
              Type = 70,
              Timeout = 1.0,
              TimeoutKey = "F1"
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

          NPCName = "room2",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/all_plat_off",
              Plat = "plat6",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              TimelineName = "3-2-6Timeline",
              Fadein = 0.0,
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
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_10/sc03_04_anim_10_03/sc03_prp_04a_pre(36)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/sc03_04_anim_29/sc03_04_anim_29_06/sc03_prp_04a_pre(12)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 6.0,
              TimeoutKey = "BOSS_T"
            },
            {

              TaskId = 103104,
              Type = 5,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "CC2",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            },
            {

              ObjName = "Level/T1/R3/sc03_04_anim_29/Box(MISSILE_AND_CHAR_BLOCK)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              GroupID = 4,
              Type = 86,
              Timeout = 0.0
            },
            {

              StartRoomId = 11,
              TargetRoomId = 7,
              IsOpen = true,
              Type = 24,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "room2",
          ValidInTower = true
        },
        {

          NPCName = "room2",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_43/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 1.0,
              TimeoutKey = "1"
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 1.0,
              TimeoutKey = "2"
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43 (1)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 1.0,
              TimeoutKey = "3"
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_43/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 1.0,
              TimeoutKey = "4"
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "room2",
          HitType = 0,
          Actions = {
            {

              ResId = 10210105,
              PosKey = "C4",
              Camp = 4,
              Rotation = 0,
              Level = 0,
              NPCName = "C4",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 7.5,
              TimeoutKey = "UOoVNbmm"
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_11_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              ResId = 10210105,
              PosKey = "C6",
              Camp = 4,
              Rotation = 0,
              Level = 0,
              NPCName = "C6",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 2.5,
              TimeoutKey = "C6"
            },
            {

              Key = "二次返回开关_clear",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "C4",
          HitType = 1,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/BOSS_RT",
              Plat = "plat1,plat5",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_11_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "tp1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 2.0,
              TimeoutKey = "tp1c4"
            },
            {

              CustomEventName = "二次返回开关_尝试显示tp",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "二次返回开关_尝试隐藏tp",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "C5",
          HitType = 1,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/BOSS_RT",
              Plat = "plat1,plat5",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_12_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Index = 1,
              Type = 73,
              Timeout = 1.0,
              TimeoutKey = "tp11"
            },
            {

              Index = 4,
              Type = 73,
              Timeout = 1.0,
              TimeoutKey = "tp44"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 2.0,
              TimeoutKey = "tp4c5"
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "room2",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/sc03_prp_04a_pre (12)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "room2",
          HitType = 0,
          Actions = {
            {

              NpcName = "room2",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "room2",
          HitType = 0,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "C4",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 1.0,
              TimeoutKey = "C4Y"
            },
            {

              TaskId = 103105,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "C6",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/BOSS_RT",
              Plat = "plat1,plat5",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/sc03_prp_04a_pre (12)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              CustomEventName = "二次返回开关_尝试显示tp",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "二次返回开关_尝试隐藏tp",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "C7",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/BOSS_RT",
              Plat = "plat1,plat5",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43 (1)/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "C4",
          HitType = 2,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/BOSS_RT",
              Plat = "plat1,plat5",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_11_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "tp1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 2.0,
              TimeoutKey = "tp1c4"
            },
            {

              CustomEventName = "二次返回开关_尝试显示tp",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "二次返回开关_尝试隐藏tp",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "C5",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/BOSS_RT",
              Plat = "plat1,plat5",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_16/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_15/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_12/sc03_04_anim_12_02/sc03_prp_04a_pre(11)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Index = 1,
              Type = 73,
              Timeout = 1.0,
              TimeoutKey = "tp11"
            },
            {

              Index = 4,
              Type = 73,
              Timeout = 1.0,
              TimeoutKey = "tp44"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 2.0,
              TimeoutKey = "tp4c5"
            },
            {

              Index = 1,
              Type = 72,
              Timeout = 0.0
            },
            {

              Index = 4,
              Type = 72,
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

          NPCName = "bridge_1",
          HitType = 0,
          Actions = {
            {

              Path = "Level/Section_02/Zone_02/Plat7_/sc03_02_anim_03 (1)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/Section_02/Zone_02/sc03_prp_04a_pre (1)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              AreaName = "JU1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 2.0,
              TimeoutKey = "2"
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

          NPCName = "P2_2",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/P2",
              Plat = "plat2",
              Rewind = 4.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/sc03_prp_04a_pre (12)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "4_3",
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

              Path = "Level/T1/R3/switch/sc03_prp_04a_pre(4)/switch_hit",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "4_2",
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

              Path = "Level/T1/R3/switch/sc03_prp_04a_pre(3)/switch_hit",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "P5",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/P5",
              Plat = "plat5",
              Rewind = 4.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "door",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/R1/door",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R1/sc03_prp_04a_pre/switch_on",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0
            },
            {

              NPCId = 1031004,
              Type = 1,
              Timeout = 0.0
            },
            {

              Path = "Level/Section_02/Component/timeline_32K999",
              Rewind = 0.0,
              IsSaveState = true,
              Type = 56,
              Timeout = 0.0
            },
            {

              AreaName = "guide_1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              GuideId = 103101,
              Type = 67,
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

          NPCName = "P2_1",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/P2",
              Plat = "plat2",
              Rewind = 4.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat2_/sc03_04_anim_13/sc03_04_anim_13_03/sc03_prp_04a_pre(40)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "3_1",
          HitType = 0,
          Actions = {
            {

              ResId = 10210105,
              PosKey = "P5",
              Camp = 2,
              Rotation = 0,
              Level = 0,
              NPCName = "P5",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 4.0,
              TimeoutKey = "P5"
            },
            {

              ResId = 10210105,
              PosKey = "P4_1",
              Camp = 2,
              Rotation = 0,
              Level = 0,
              NPCName = "P4_1",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 4.0,
              TimeoutKey = "P4_1"
            },
            {

              ResId = 10210105,
              PosKey = "P4_2",
              Camp = 2,
              Rotation = 0,
              Level = 0,
              NPCName = "P4_2",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 4.0,
              TimeoutKey = "P4_2"
            },
            {

              ResId = 10210105,
              PosKey = "P2_1",
              Camp = 2,
              Rotation = 0,
              Level = 0,
              NPCName = "P2_1",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 4.0,
              TimeoutKey = "P2_1"
            },
            {

              ResId = 10210105,
              PosKey = "P2_2",
              Camp = 2,
              Rotation = 0,
              Level = 0,
              NPCName = "P2_2",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 4.0,
              TimeoutKey = "P2_2"
            },
            {

              ResId = 10210105,
              PosKey = "P1",
              Camp = 4,
              Rotation = 0,
              Level = 0,
              NPCName = "P1",
              Cd = 3.0,
              IgnoreLock = false,
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Type = 55,
              Timeout = 4.0,
              TimeoutKey = "P1"
            }
          },
          FinishMarkVariable = "all_switch",
          ValidInTower = false
        },
        {

          NPCName = "3_1",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/R3/Plat5_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat4_/sc03_04_anim_14/sc03_04_anim_14_03/sc03_prp_04a_pre(40)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43 (1)/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/sc03_prp_04a_pre (12)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat2_/sc03_04_anim_13/sc03_04_anim_13_03/sc03_prp_04a_pre(40)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "3_1",
          HitType = 0,
          Actions = {
            {

              NpcName = "3_1",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              TaskId = 103104,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 19,
      ConditionVariable = "all_switch",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCName = "P1",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/3/P1",
              Plat = "plat1",
              Rewind = 4.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_43/sc03_prp_04a_pre (11)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "4_4",
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
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
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

          NPCName = "C3",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/future1_1/4/4_1",
              Plat = "plat6",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/Plat3_/sc03_04_anim_10/sc03_prp_04a_pre(37)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              TaskId = 103108,
              Type = 5,
              Timeout = 0.0
            },
            {

              Camera = 1031003,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "bridge_cam",
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

          NPCName = "bridge_down",
          HitType = 0,
          Actions = {
            {

              Path = "Level/T1/R3/Plat1_/sc03_04_anim_11/sc03_04_anim_17/switch_on",
              Plat = "",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/T1/R3/switch/sc03_prp_04a_pre(34)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              NpcName = "bridge_down",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              TipsId = 1003012,
              Visible = false,
              Flip = false,
              Type = 15,
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

          NPCName = "sence",
          HitType = 0,
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
                    Id = 103102,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "1111",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 1.0,
              TimeoutKey = "monster_2"
            },
            {

              Camera = 1031003,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              Camera = 1031001,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "cam_1"
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

      Actions = empty,
      ValidInTower = false,
      Type = 21,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10301CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 40,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10301OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 100103022,
      Name = "剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 5,
    MonsterCount = 16,
    MonsterInfo = {
      [ 20103601 ] = 5,
      [ 20104201 ] = 11
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}