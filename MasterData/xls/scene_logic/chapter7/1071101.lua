local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "scene_timeline_107110101",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          GroupId = 107110100,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupID = 3,
          Type = 86,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_chapter7_common",
          Type = 76,
          Timeout = 0.0
        },
        {

          BUSName = "HallReverb",
          BUSLevel = 1.0,
          Type = 127,
          Timeout = 0.0
        },
        {

          Direction = 3,
          Type = 51,
          Timeout = 0.0
        },
        {

          Index = 3,
          Type = 72,
          Timeout = 0.5,
          TimeoutKey = "AcrjLrnY"
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

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 1070903,
          Level = 1,
          Type = 16,
          Timeout = 0.75,
          TimeoutKey = "oxoOlKaY"
        },
        {

          Target = "God",
          MagicId = 1070904,
          Level = 1,
          Type = 16,
          Timeout = 0.75,
          TimeoutKey = "vbSLqiGA"
        },
        {

          StoryId = 5071701,
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
          Timeout = 2.0,
          TimeoutKey = "YLHFbWId"
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

          Key = "point_count",
          SyncValType = 1,
          Value = 16.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "gap_time",
          SyncValType = 1,
          Value = 7.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "increase_time",
          SyncValType = 1,
          Value = 22.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "start_target_num",
          SyncValType = 1,
          Value = 1.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "max_target_num",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "max_time",
          SyncValType = 1,
          Value = 999999.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
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

      NoPassCamera = 1070900,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1070900,
      PassCameraIsNewConfig = true,
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

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          TaskGroupId = 10711,
          Type = 21,
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
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "Execution_hit",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "阶段1重来",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "阶段2重来",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "Execution_hit",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "over",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StoryId = 5071709,
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

          GroupID = 3,
          Type = 87,
          Timeout = 0.0
        },
        {

          KeyName = "tp3",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          Index = 3,
          Type = 73,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "over",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "Execution_start",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "尝试恢复墙壁",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "Execution_start",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "Execution_end",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "尝试隐藏墙壁",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "Execution_end",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "fight",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          AreaName = "cam1",
          RemoveForever = false,
          Type = 9,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "phase2",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "fight",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "showup",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 1,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 1071101001,
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
            },
            {

              StoryId = 5071703,
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

              GroupID = 1,
              Type = 86,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.15,
              TimeoutKey = "rCsvjKGB"
            },
            {

              Type = 60,
              Timeout = 5.0,
              TimeoutKey = "sdnvWTiI"
            },
            {

              TaskId = 1071101,
              Type = 5,
              Timeout = 0.0
            },
            {

              PlayBgm = "bgm_chapter6_elite",
              Type = 76,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "showup",
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

          Key = "cam1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 5071702,
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

              Type = 71,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "dialog",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "dialog",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "victory",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "intro",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "focus1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 1.0,
              TimeoutKey = "rMuJMNzc"
            },
            {

              StoryId = 5071707,
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

              Type = 71,
              Timeout = 0.0
            },
            {

              GroupId = 107110101,
              Type = 27,
              Timeout = 0.0
            },
            {

              TaskId = 1071102,
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

      ConditionActions = {
        {

          Key = "cam1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1071101,
              IsNewConfig = true,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area07/sc06_area_digong_07_pre/sc06_area_digong_07_m2_mod/sc06_area_digong_07_m2_02",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
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

          Key = "cam1",
          Actions = {
            {

              Camera = 107070,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_ Complete/area07/sc06_area_digong_07_pre/sc06_area_digong_07_m2_mod/sc06_area_digong_07_m2_02",
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
      Type = 4,
      ConditionVariable = "showup",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "cam1",
          Actions = {
            {

              Camera = 1071301,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Scene/sc0604_area_digong/area07/sc06_area_digong_07_pre/sc06_area_digong_07_m2_mod/sc06_area_digong_07_m2_03",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              StoryId = 5071706,
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

              Key = "Stone_state",
              SyncValType = 1,
              Value = 0.0,
              selectIdx = 1,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "showup",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "阶段1重来",
      Actions = {
        {

          FadeIn = 0.0,
          Hold = 1.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Type = 69,
          Timeout = 0.5,
          TimeoutKey = "YBkSXPQL"
        },
        {

          NPC = "Hero",
          Point = "reborn",
          Rotate = -90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "NmKpiztQ"
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
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 1071101001,
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
          Timeout = 1.25,
          TimeoutKey = "qeXoVQYN"
        },
        {

          Type = 61,
          Timeout = 0.0
        },
        {

          Type = 60,
          Timeout = 2.0,
          TimeoutKey = "TtmzSKOh"
        },
        {

          GuideId = 1071101,
          Type = 41,
          Timeout = 2.0,
          TimeoutKey = "fgpnOMnm"
        },
        {

          GuideId = 1071101,
          Type = 67,
          Timeout = 4.5,
          TimeoutKey = "EfcHtiwH"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "phase2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "阶段2重来",
      Actions = {
        {

          FadeIn = 0.0,
          Hold = 1.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Type = 69,
          Timeout = 0.5,
          TimeoutKey = "UulmFgJv"
        },
        {

          NPC = "Hero",
          Point = "reborn2",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "PTifTfhP"
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
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 1071101001,
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
          Timeout = 1.0,
          TimeoutKey = "qHBPLHIY"
        },
        {

          Group = 107110100,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "YDoMHzlj"
        },
        {

          Group = 107110101,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "ALXnsARb"
        },
        {

          GroupId = 107110100,
          Type = 27,
          Timeout = 0.75,
          TimeoutKey = "wiYRphwh"
        },
        {

          GroupId = 107110101,
          Type = 27,
          Timeout = 0.75,
          TimeoutKey = "oDjzjcPr"
        },
        {

          Target = "1_107110100_0",
          MagicId = 300107702,
          Level = 1,
          Type = 16,
          Timeout = 1.0,
          TimeoutKey = "jvMXWilB"
        },
        {

          GroupID = 2,
          Type = 87,
          Timeout = 0.5,
          TimeoutKey = "RjZIkwAW"
        },
        {

          Camera = 1071301,
          IsNewConfig = true,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.5,
          TimeoutKey = "EdrfSBbO"
        },
        {

          GroupID = 3,
          Type = 86,
          Timeout = 0.5,
          TimeoutKey = "muNXHLCq"
        },
        {

          Type = 71,
          Timeout = 0.5,
          TimeoutKey = "GVIQVLYU"
        },
        {

          Index = 3,
          Type = 72,
          Timeout = 0.5,
          TimeoutKey = "NCUsBjbe"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "phase2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "尝试恢复墙壁",
      Actions = {
        {

          ObjName = "/Root/Change_/Change_ Complete/area07/sc06_area_digong_07_pre/sc06_area_digong_07_m2_mod/sc06_area_digong_07_m2_02",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "phase2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "尝试隐藏墙壁",
      Actions = {
        {

          ObjName = "/Root/Change_/Change_ Complete/area07/sc06_area_digong_07_pre/sc06_area_digong_07_m2_mod/sc06_area_digong_07_m2_02",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "phase2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          GuideID = 1071101,
          Actions = {
            {

              StoryId = 5071710,
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
              Timeout = 1.5,
              TimeoutKey = "PtZvWBMT"
            },
            {

              KeyName = "T0",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
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

      Actions = {
        {

          TaskId = 1071103,
          Type = 5,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 35,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      StoryID = 1001071701,
      RepeatExecute = false,
      Actions = {
        {

          StoryId = 1001071701,
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
    EventCount = 3,
    MonsterCount = 3,
    MonsterInfo = {
      [ 20105303 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}