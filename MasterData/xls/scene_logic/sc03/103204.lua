local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Path = "Level/Section_02/Zone_04_1/sc03_04_anim_41/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 1.0,
          TimeoutKey = "1"
        },
        {

          IsSkip = false,
          Type = 36,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc03_zone_00_1/sc03_bld_32a_pre(119)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc03_zone_04_1/Building/sc03_04_anim_35 (1)",
          Visible = false,
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

      NoPassCamera = 1031001,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1031001,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          PosKey = "target",
          Rotation = 0,
          NPCId = 101106,
          Type = 0,
          Timeout = 0.5,
          TimeoutKey = "MUviRjeN"
        },
        {

          ResId = 10320101,
          PosKey = "center",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 4,
          Level = 0,
          NPCName = "1",
          AutoSave = false,
          Type = 2,
          Timeout = 0.0,
          TimeoutKey = "MPdgbezv"
        },
        {

          ObjName = "/Root/Level/Section_02/Component/timeline_32K2",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "A2",
          Camp = 4,
          Rotation = 0,
          Level = 1,
          NPCName = "AAC",
          Cd = 999.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ObjName = "Level/T1/R3/Plat4_/GameObject(CHAR_BLOCK)",
          Visible = true,
          IsAutoSave = false,
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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 2,
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
                MonsterWave = 1,
                MonsterCount = 4,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10320401,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "ZZZ",
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

              AreaName = "K2",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "K2",
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10320401,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "ZZZ",
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

              AreaName = "K1",
              RemoveForever = true,
              Type = 9,
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

          Key = "CAM2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "CAM2_2",
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

          Key = "BACK",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "timeline_32j6",
              Fadein = 1.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = true,
              IsCloseTransparent = false,
              BlackIn = 0.5,
              Hold = 0.5,
              BlackOut = 1.5,
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

              Key = "2031101",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Path = "Level/Section_02/Component/BACK_monster",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "BACK",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "SP",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1031011,
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

          Key = "SC5",
          IsRemoveAfterEnter = true,
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
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10320402,
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
              Timeout = 0.5,
              TimeoutKey = "XXQE"
            },
            {

              ObjName = "/Root/Level/Section_02/Component/timeline_34M1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/Section_02/Component/timeline_34M1",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.0,
              TimeoutKey = "OTwNwMki"
            }
          },
          FinishMarkVariable = "SC5",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "SC5",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "AA",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 2031001,
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

              Camera = 1031001,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              PosKey = "A2",
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
              Timeout = 0.0,
              TimeoutKey = ""
            }
          },
          ValidInTower = false
        },
        {

          Key = "SC3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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

          Key = "CAM1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 117,
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

          Key = "CAM2",
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
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

          Key = "CAM1",
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

          Key = "SP",
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

          StoryId = 2031101,
          Actions = empty,
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

          StoryId = 1031001,
          Actions = {
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
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
      Type = 5,
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

              TimelineName = "CP3",
              Fadein = 0.0,
              Fadeout = 0.0,
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
              Timeout = 0.5,
              TimeoutKey = "22"
            },
            {

              Path = "Level/Section_02/Component/PC_3",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.5,
              TimeoutKey = "33"
            },
            {

              FadeIn = 0.5,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "BACK",
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

          Index = 2,
          Type = 72,
          Timeout = 0.5,
          TimeoutKey = "FHdzqFfC"
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "M1",
      Actions = {
        {

          StoryId = 2031101,
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

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          Type = 12,
          Timeout = 0.0
        },
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          PosKey = "tp4",
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
          TimeoutKey = ""
        },
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 3.0,
          TimeoutKey = "XXXADA84694"
        },
        {

          Path = "Level/T1/R3/Plat3_/sc03_04_anim_43/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 1.0,
          TimeoutKey = "s1"
        },
        {

          Path = "Level/T1/R3/Plat1_/sc03_04_anim_43/switch_on",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 1.0,
          TimeoutKey = "s2"
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

      EventName = "ZZZ",
      Actions = {
        {

          ResId = 10210105,
          PosKey = "A5",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "A5",
          Cd = 999.0,
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

      ConditionActions = {
        {

          TimelineName = "timeline_32j5",
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

          TimelineName = "timeline_32j6",
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
                WallObjPath = "0",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 103204,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "M1",
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

              ObjName = "Level/Section_02/Component/BACK_monster",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "FUCK",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 0.0
            },
            {

              GroupID = 1,
              Type = 87,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "CP3",
          Actions = {
            {

              StoryId = 1031001,
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

              TaskId = 103204,
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

          NPCName = "A5",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Scene/collapse/sc03_zone_04_1/Prop/Group_01/sc03_prp_04a_pre (4)/switch_on",
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

          NPCName = "AAC",
          HitType = 1,
          Actions = {
            {

              ObjName = "/Root/Level/Section_02/Component/timeline_32C2",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Path = "/Root/Scene/collapse/sc03_zone_04_1/Building/sc03_04_anim_10/sc03_04_anim_10_03/sc03_prp_04a_pre(36)/switch_on",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              KeyName = "target",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
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
    EventCount = 4,
    MonsterCount = 13,
    MonsterInfo = {
      [ 20104201 ] = 9,
      [ 20103201 ] = 1,
      [ 20103601 ] = 1,
      [ 20101201 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}