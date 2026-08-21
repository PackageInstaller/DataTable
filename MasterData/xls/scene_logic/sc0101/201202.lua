local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          KeyName = "guide",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 3,
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

      NoPassCamera = 117,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 117,
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

          Target = "Hero",
          MagicId = 4032189,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/tower2KQQ/FX_KQQ (2)",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/tower2KQQ/FX_KQQ (3)",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/tower2KQQ/FX_KQQ (4)",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10207",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "BOXAFTER10207",
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

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          StartRoomId = 9,
          TargetRoomId = 13,
          IsOpen = true,
          Type = 24,
          Timeout = 0.0
        },
        {

          PlatName = "elevator",
          IsMove = true,
          Anim = "ele1loop",
          IsAutoSave = true,
          Type = 18,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "gameover",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "elevator",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PlatName = "elevator",
              IsMove = true,
              Anim = "elevator",
              IsAutoSave = true,
              Type = 18,
              Timeout = 0.0
            },
            {

              AreaName = "elevator",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              GroupID = 2,
              Type = 86,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "battle2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "battle2",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "talk",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 2020901,
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

              TimelineName = "timeline_B0202_2",
              Fadein = 1.0,
              Fadeout = 1.0,
              IsCanSkip = true,
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
              Timeout = 0.0
            },
            {

              PlatName = "elevator",
              IsMove = true,
              Anim = "elevator",
              IsAutoSave = true,
              Type = 18,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "npc",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 2020902,
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

          Key = "elevator2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PlatName = "elevator2",
              IsMove = true,
              Anim = "elevator2",
              IsAutoSave = true,
              Type = 18,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
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

          Key = "guide2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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
        },
        {

          Key = "guidetp",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              KeyName = "tp4",
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

          Key = "BOXENTER",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "BOXSTORY1",
              Rotation = 0,
              NPCId = 102071,
              NPCName = "1",
              Type = 0,
              Timeout = 3.0,
              TimeoutKey = "mgWZOwCA"
            },
            {

              GroupID = 3,
              Type = 86,
              Timeout = 0.0
            },
            {

              PosKey = "B1",
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
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 3.0,
              TimeoutKey = "xZXlOdTU"
            },
            {

              NPCId = 102071,
              NPCName = "1",
              Type = 1,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "10207",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          Key = "eavesdrop",
          Actions = {
            {

              AreaName = "eavesdrop",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 10,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "emptywall",
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 20120201,
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
                    Id = 20120202,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "dianti",
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

          NPCId = 102104,
          Actions = empty,
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

      EventName = "dianti",
      Actions = {
        {

          TimelineName = "timeline_B0203",
          Fadein = 1.0,
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
          Timeout = 1.0,
          TimeoutKey = "DChyTFqE"
        },
        {

          PlatName = "elevator",
          IsMove = true,
          Anim = "down",
          IsAutoSave = true,
          Type = 18,
          Timeout = 0.0
        },
        {

          ResId = 201127,
          PosKey = "NPC1",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 2,
          Level = 0,
          NPCName = "N1",
          AutoSave = false,
          Type = 2,
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

      EventName = "BOXEND10207",
      Actions = {
        {

          Variable = "10207",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10207CLOSE",
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

      EventName = "PREBOX10207",
      Actions = {
        {

          TimelineName = "Timeline_Box10207Start",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10207",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BOXAFTER10207",
      Actions = {
        {

          TreasureChestId = 10218,
          PosKey = "LB2",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10219,
          PosKey = "LB3",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10220,
          PosKey = "LB4",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10221,
          PosKey = "LB1",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        },
        {

          GroupID = 3,
          Type = 87,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_Box10207End",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10207",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10207OPEN",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10207",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10207",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10207CLOSE",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10207",
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

      ConditionActions = {
        {

          TimelineName = "timeline_B0203",
          Actions = {
            {

              KeyName = "guide",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_B0202_2",
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

      StoryID = 100102091,
      Actions = {
        {

          StoryId = 100102091,
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
      Type = 37,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10207OPEN",
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

          CustomEventName = "GBOX10207CLOSE",
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = {
    [ 6 ] = {
      TimeLineId = "timeline_B0203",
      Name = "播放TimeLine结束"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 10,
    MonsterInfo = {
      [ 20103001 ] = 8,
      [ 20102801 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}