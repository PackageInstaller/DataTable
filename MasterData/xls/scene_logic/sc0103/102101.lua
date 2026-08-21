local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          SkillLevel = 3,
          TowerValid = false,
          Type = 45,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_bright/sc02_timeline_02_pre/sc02_bld_04a2_pre_reng_ani",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level_1/T1-HENJI",
          Visible = true,
          IsAutoSave = true,
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

          Target = "Hero",
          MagicId = 4032189,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Key = "haoye",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10202,
          PosKey = "SJ1",
          Rotation = 180,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        }
      },
      ValidInTower = true,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "T1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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
                WallObjPath = "",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 1021001,
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
                    Id = 1021001,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "clear",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.7,
              TimeoutKey = "EE1"
            },
            {

              AreaName = "T1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.5,
              TimeoutKey = "EE2"
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level_1/PZ-1(MISSILE_BLOCK)",
              Visible = false,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              AreaName = "WC",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              Enable = true,
              Type = 17,
              Timeout = 0.0
            },
            {

              StoryId = 1020201,
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

          Key = "W1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "W1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_n0201",
              Fadein = 3.0,
              Fadeout = 0.5,
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

              GroupId = 100201,
              Type = 42,
              Timeout = 1.5,
              TimeoutKey = "CMhTNKsF"
            }
          },
          FinishMarkVariable = "WV",
          ValidInTower = false
        },
        {

          Key = "A1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "A1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level_1/T1-TL/timeline_n0211",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              StoryId = 2020201,
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

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              AreaName = "WV",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              Type = 71,
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

              AreaName = "W2",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              GroupId = 100202,
              Type = 42,
              Timeout = 0.0
            },
            {

              Point = "SJB",
              Type = 3,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "VAC",
          ValidInTower = false
        },
        {

          Key = "W4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "W4",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_n0203",
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
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 3.0,
              TimeoutKey = "TXRAvTXb"
            },
            {

              Type = 34,
              Timeout = 3.0,
              TimeoutKey = "jtBikpRt"
            },
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              StoryId = 2020202,
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
              TimeoutKey = "W4"
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level_1/T1-TL/timeline_n0235",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          Key = "W3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "W8",
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

          Key = "J1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1021001,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              AreaName = "J1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_bright/Level_1/T1-TL/timeline_n0216",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "WA",
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

          Key = "WC",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              UIName = "fight",
              ObjectName = "Btn_skill1",
              IsShow = false,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill3",
              IsShow = false,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill4",
              IsShow = false,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill5",
              IsShow = false,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill7",
              IsShow = false,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill8",
              IsShow = false,
              Type = 32,
              Timeout = 0.0
            },
            {

              HeroId = 1001008,
              Type = 29,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              UIName = "fight",
              ObjectName = "TeamHeads",
              IsShow = false,
              Type = 32,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "QQQ",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              ObjName = "/Root/Change_/Change_bright/Level_1/T1-TL/timeline_n0234",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              AreaName = "WC",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "WA",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill1",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill3",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill4",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill5",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill7",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill8",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "TeamHeads",
              IsShow = true,
              Type = 32,
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "WV",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "WV",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "W8",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "VV",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "WC",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              UIName = "fight",
              ObjectName = "Btn_skill4",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "VAC",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "AB",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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
      Type = 3,
      ConditionVariable = "AB",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "W8",
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

          Key = "WA",
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

          Key = "WV",
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

          Key = "WC",
          Actions = {
            {

              UIName = "fight",
              ObjectName = "Btn_skill1",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill3",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill4",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill5",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill7",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill8",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            },
            {

              UIName = "fight",
              ObjectName = "TeamHeads",
              IsShow = true,
              Type = 32,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Type = 71,
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

          StoryId = 1020202,
          Actions = {
            {

              TimelineName = "timeline_n0202",
              Type = 7,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 1020201,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 100102021,
          Actions = {
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              PosKey = "V1",
              Rotation = 0,
              NPCId = 101212,
              Type = 0,
              Timeout = 0.0
            },
            {

              ObjName = "Change_/Change_bright/sc02_timeline_02_pre/sc02_bld_04a2_pre_reng_ani",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
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

          NPCId = 102146,
          Actions = {
            {

              ObjName = "timeline_n0205",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = true
        },
        {

          NPCId = 101212,
          Actions = {
            {

              TimelineName = "timeline_n0202",
              Fadein = 4.0,
              Fadeout = 2.0,
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

              StoryId = 1020202,
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
              TimeoutKey = "GduYYKOM"
            },
            {

              Intensity = 0.006,
              Type = 105,
              Timeout = 0.0
            },
            {

              mIdx = 10,
              mVisible = true,
              RoomColliderName = "sc02_zone_07",
              Type = 89,
              Timeout = 0.0
            },
            {

              mIdx = 13,
              mVisible = true,
              RoomColliderName = "sc02_zone_02",
              Type = 89,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 10102103,
          Actions = empty,
          FinishMarkVariable = "VV",
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

      ConditionActions = {
        {

          GroupId = 100202,
          Actions = {
            {

              GuideId = 101119,
              Type = 41,
              Timeout = 0.0,
              TimeoutKey = "SDS"
            },
            {

              GuideId = 101120,
              Type = 41,
              Timeout = 1.5,
              TimeoutKey = "SD"
            },
            {

              Type = 61,
              Timeout = 0.1,
              TimeoutKey = "AADAAD"
            },
            {

              Type = 60,
              Timeout = 1.4,
              TimeoutKey = "AWWE"
            },
            {

              UIName = "fight",
              ObjectName = "Btn_skill4",
              IsShow = true,
              Type = 32,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          GroupId = 100201,
          Actions = {
            {

              KeyName = "A1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 2.75,
              TimeoutKey = "fJSpwqVP"
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

      EventName = "AA",
      Actions = {
        {

          PosKey = "VV",
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
      FinishMarkVariable = "AB",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear",
      Actions = {
        {

          GroupID = 1,
          Type = 87,
          Timeout = 0.0
        },
        {

          TaskGroupId = 1021,
          Type = 21,
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

          TimelineName = "timeline_n0201",
          Actions = {
            {

              PosKey = "A1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 1.5,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.75,
              TimeoutKey = "mBmNObGN"
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_n0202",
          Actions = {
            {

              mIdx = 12,
              mVisible = false,
              RoomColliderName = "sc02_zone_07",
              Type = 89,
              Timeout = 2.0,
              TimeoutKey = "rjKAZrXY"
            },
            {

              mIdx = 13,
              mVisible = false,
              RoomColliderName = "sc02_zone_02",
              Type = 89,
              Timeout = 2.0,
              TimeoutKey = "HILiEiGy"
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

      StoryID = 100102021,
      Actions = {
        {

          Target = "Hero",
          Type = 37,
          Timeout = 0.0
        },
        {

          StoryId = 100102021,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.0,
          PlayStayTime = 0.0,
          PlayFadeOutTime = 0.0,
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
      Type = 37,
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
    [ 6 ] = {
      TimeLineId = "timeline_n0203",
      Name = "播放TimeLine结束"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 8,
    MonsterInfo = {
      [ 20103001 ] = 8
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}