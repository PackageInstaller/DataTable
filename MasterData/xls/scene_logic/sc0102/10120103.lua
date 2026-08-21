local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "timeline1_3_daozhuan",
          Fadein = 0.0,
          Fadeout = 3.0,
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

          TaskGroupId = 1011,
          Type = 21,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 403210041,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 10001015,
          Level = 0,
          Type = 16,
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

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 403210033,
          Type = 103,
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

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
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

          ObjName = "fx_wall",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "is_enter_maze2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "scene_timeline_weilan",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_day/Level1/Cube",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          PosKey = "focus",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 3.5,
          StopLuaScript = false,
          BackToDefault = false,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 1,
          OTSDuration = 3.5,
          Type = 62,
          Timeout = 0.5,
          TimeoutKey = "UVJelrpN"
        },
        {

          Key = "is_enter_maze2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "is_enter",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TaskId = 101101,
          Type = 5,
          Timeout = 1.0,
          TimeoutKey = "2"
        },
        {

          ChangeTime = 3.0,
          Type = 75,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_common",
          Type = 76,
          Timeout = 2.0,
          TimeoutKey = "3"
        },
        {

          Point = 1,
          Type = 109,
          Timeout = 0.0
        },
        {

          TipsId = 10110401,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          TipsId = 10110402,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          TipsId = 10110301,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          StoryId = 201104,
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
          Timeout = 2.5,
          TimeoutKey = "LNxYtfTf"
        },
        {

          TaskId = 201101,
          Type = 5,
          Timeout = 2.5,
          TimeoutKey = "MtcQkQNq"
        },
        {

          Type = 61,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "is_enter_maze2",
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

          Key = "story1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 101107,
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

              AreaName = "story1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "is_enter",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "monster2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 14,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 10110303,
                    param = 2,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10110301,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "remove35",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10110305,
                    param = 0,
                    Name = "全部杀死",
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
          ValidInTower = false
        },
        {

          Key = "monster1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10110302,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "fight",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10110300,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "energy1",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.5,
              TimeoutKey = "OqkuPAOf"
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

          Key = "monster1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Target = "God",
              MagicId = 403210034,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "God",
              MagicId = 403210036,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
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

          StoryId = 101107,
          Actions = {
            {

              Camera = 102,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 201103,
          Actions = empty,
          FinishMarkVariable = "noStoryConflict",
          ValidInTower = false
        },
        {

          StoryId = 201104,
          Actions = {
            {

              Type = 60,
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

      EventName = "nextEscala",
      Actions = {
        {

          GroupID = 1,
          Type = 87,
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

      EventName = "encharge2",
      Actions = {
        {

          CustomEventName = "nextEscala",
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

      EventName = "energy1",
      Actions = {
        {

          Target = "God",
          MagicId = 403210034,
          Type = 103,
          Timeout = 0.5,
          TimeoutKey = "ekVAdNpa"
        },
        {

          Target = "God",
          MagicId = 403210036,
          Type = 103,
          Timeout = 0.5,
          TimeoutKey = "ItMMDirX"
        },
        {

          Type = 61,
          Timeout = 0.5,
          TimeoutKey = "ElvNZPFA"
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 4,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            ActionTag = "连携",
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10110304,
                param = 2,
                Name = "全部杀死",
                CustomEventName = "encharge2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 1.1,
          TimeoutKey = "CWihLbvE"
        },
        {

          PosKey = "M5",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = true,
          BackToDefault = false,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 0.001,
          Type = 62,
          Timeout = 1.0,
          TimeoutKey = "VJuVgWvP"
        },
        {

          Target = "God",
          MagicId = 403210031,
          Level = 0,
          Type = 16,
          Timeout = 2.5,
          TimeoutKey = "ilrlmlME"
        },
        {

          HeroId = 1001001,
          Type = 29,
          Timeout = 3.4,
          TimeoutKey = "RKoPnTUq"
        },
        {

          GuideId = 10010201,
          Type = 41,
          Timeout = 3.5,
          TimeoutKey = "UehavVeY"
        },
        {

          Type = 60,
          Timeout = 3.6,
          TimeoutKey = "SGDnMhIw"
        },
        {

          Target = "God",
          MagicId = 403210035,
          Level = 0,
          Type = 16,
          Timeout = 3.6,
          TimeoutKey = "ZNnvMDfY"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "remove35",
      Actions = {
        {

          Target = "God",
          MagicId = 403210035,
          Type = 103,
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

      EventName = "fight",
      Actions = empty,
      FinishMarkVariable = "fight",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline1_3_henji",
          Actions = {
            {

              StoryId = 201104,
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

              TaskId = 201101,
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

          TimelineName = "timeline1_3_daozhuan",
          Actions = {
            {

              StoryId = 201103,
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
              Timeout = 0.1,
              TimeoutKey = "TxgKemOs"
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

          ObjName = "fx_wall",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TipsId = 10110301,
          Visible = false,
          Flip = false,
          Type = 15,
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

          GuideID = 10010202,
          Actions = {
            {

              GroupId = 100004,
              Type = 42,
              Timeout = 0.1,
              TimeoutKey = "XRISwQiI"
            }
          },
          ValidInTower = false
        },
        {

          GuideID = 10010201,
          Actions = {
            {

              Target = "Hero",
              MagicId = 10001015,
              Type = 103,
              Timeout = 5.0,
              TimeoutKey = "eFfVwtat"
            }
          },
          ValidInTower = false
        }
      },
      Type = 15,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ConditionVariableList = {
            "fight",
            "noStoryConflict"
          },
          Actions = {
            {

              GuideId = 10010202,
              Type = 41,
              Timeout = 0.5,
              TimeoutKey = "ndqrYwFK"
            }
          },
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline1_3_daozhuan",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 32,
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
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 3,
    MonsterCount = 22,
    MonsterInfo = {
      [ 20101401 ] = 9,
      [ 20101501 ] = 9,
      [ 20102901 ] = 4
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}