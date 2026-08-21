local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Level/scene_timeline2_3_1",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline2_3_1",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline2_3_2",
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
          Timeout = 0.0
        },
        {

          Target = "Hero",
          Type = 37,
          Timeout = 0.0
        },
        {

          Target = "1001015",
          MagicId = 10001013,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline2_3_1",
          IsPlay = true,
          Type = 110,
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
          PosKey = "2222222",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "2",
          Cd = 3.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "A3",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "3",
          Cd = 3.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "A4",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "4",
          Cd = 3.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "A1-1",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "1-1",
          Cd = 3.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ResId = 10210105,
          PosKey = "A3-1",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "3-1",
          Cd = 3.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_03_1/sc03_area_03_pre/sc03_area_03_01_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_02_1/sc03_area_02_pre/sc03_area_02_26_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_02_1/sc03_area_02_pre/sc03_area_02_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          IsSkip = false,
          Type = 36,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          Camera = 1031001,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10307,
          PosKey = "BOX1",
          Rotation = 90,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/Section_02/Zone_03_1/sc03_prp_04a_pre(43)/switch_on",
          Rewind = 3.0,
          IsSaveState = false,
          Type = 56,
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

          Key = "AB",
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10320301,
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
                    Id = 10320302,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "1",
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

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              AreaName = "AA",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              Camera = 101503,
              IsNewConfig = true,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              Target = "1001015",
              MagicId = 10001013,
              Type = 103,
              Timeout = 0.0
            },
            {

              TipsId = 103203,
              Visible = false,
              Flip = false,
              Type = 15,
              Timeout = 0.1,
              TimeoutKey = "JIUIuraA"
            },
            {

              Key = "tishijishiqi",
              Type = 52,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "AA",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "A4",
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

              Camera = 132301,
              IsNewConfig = true,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              TipsId = 103203,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 60.0,
              TimeoutKey = "tishijishiqi"
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

          Key = "AD",
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

          Key = "AF",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          FinishMarkVariable = "",
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

          Key = "CAMM",
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

          Key = "right",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1032032,
              IsNewConfig = true,
              IsForceDepressCameraMode = true,
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

          Key = "AD",
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "AA",
          Actions = {
            {

              Camera = 1031010,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              Key = "tishijishiqi",
              Type = 52,
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

          StoryId = 1030901,
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

          NPCId = 101106,
          Actions = {
            {

              TimelineName = "CP2",
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
              TimeoutKey = "111"
            },
            {

              Path = "Level/Section_02/Component/PC_2",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
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

      EventName = "1",
      Actions = {
        {

          PosKey = "drop",
          Rotation = 0,
          NPCId = 101106,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "drop",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 3.0,
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline2_3_2",
          Actions = {
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline2_3_1",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              StoryId = 2030901,
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
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "CP2",
          Actions = {
            {

              StoryId = 1030901,
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
            },
            {

              TaskId = 103203,
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

          NPCName = "1",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/Section_02/Zone_03_1/PuzzleRoom/TL-S3T2/TL-PuzzleRoomPlat1",
              Plat = "plat1",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Section_02/Zone_03_1/sc03_prp_04a_pre(43)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          NPCName = "2",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/Section_02/Zone_03_1/PuzzleRoom/TL-S3T2/TL-PuzzleRoomPlat2",
              Plat = "plat2",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Section_02/Zone_03_1/PuzzleRoom/Plat201_/sc03_03_anim_03(MISSILE_BLOCK)/sc03_prp_04a_pre(44)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          NPCName = "3",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/Section_02/Zone_03_1/PuzzleRoom/TL-S3T2/TL-PuzzleRoomPlat3",
              Plat = "plat3",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Section_02/Zone_03_1/sc03_prp_04a_pre(45)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "4",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/Section_02/Zone_03_1/PuzzleRoom/TL-S3T2/TL-PuzzleRoomPlat4",
              Plat = "plat4",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Section_02/Zone_03_1/sc03_prp_04a_pre(46)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "1-1",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/Section_02/Zone_03_1/PuzzleRoom/TL-S3T2/TL-PuzzleRoomPlat1",
              Plat = "plat1",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Section_02/Zone_03_1/sc03_prp_04a_pre(48)/switch_on",
              Rewind = 3.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCName = "3-1",
          HitType = 0,
          Actions = {
            {

              Path = "/Root/Level/Section_02/Zone_03_1/PuzzleRoom/TL-S3T2/TL-PuzzleRoomPlat3",
              Plat = "plat3",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Section_02/Zone_03_1/sc03_prp_04a_pre(47)/switch_on",
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

      Actions = {
        {

          Path = "Level/Section_02/Component/1323DOOR",
          PlatCount = 0,
          Type = 96,
          Timeout = 0.0
        },
        {

          PosKey = "TP",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 3.0,
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

          Camera = 101503,
          IsNewConfig = true,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 21,
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
      StoryId = 1030901,
      Name = "剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 7,
    MonsterInfo = {
      [ 20104201 ] = 5,
      [ 20103201 ] = 1,
      [ 20103601 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}