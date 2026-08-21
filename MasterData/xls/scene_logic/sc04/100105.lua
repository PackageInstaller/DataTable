local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PlayBgm = "bgm_future_aten",
          Type = 76,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu2",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "TIMELINE3_1_1_0",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
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

          ResId = 10330101,
          PosKey = "bornpoint",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 2,
          Level = 0,
          NPCName = "111",
          AutoSave = false,
          Type = 2,
          Timeout = 0.0
        },
        {

          IsSkip = true,
          Type = 36,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/scenes/Sc0001_area_a1/Part_01_a1/zhuzi_sixone_2/Sc00_build_04A_pre222",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/scenes/Sc0001_area_a1/Part_01_a1/zhuzi_sixone_2/half_left (1)/Sc00_build_04B_pre146",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/scenes/Sc0001_area_a1/Part_01_a1/zhuzi_sixone_2/half_left/Sc00_build_04B_pre143",
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

      NoPassCamera = 20108101,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 20108101,
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

          SkillLevel = 8,
          TowerValid = false,
          Type = 45,
          Timeout = 0.0
        },
        {

          Target = "1001001",
          MagicId = 40321891,
          Level = 1,
          Type = 16,
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

          StoryId = 100103172,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.0,
          StopStayTime = 0.0,
          StopFadeOutTime = 0.0,
          NoSkipStory = false,
          IsSettleStory = true,
          Type = 10,
          Timeout = 1.5,
          TimeoutKey = "oUmBYZlg"
        },
        {

          Key = "aten_2_end",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "aten_2_end",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "aten_tips",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Tips = "1030",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "aten_tips",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "replay",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "重新开始",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "replay",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 100103172,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 100103171,
          Actions = {
            {

              TimelineName = "TIMELINE3_1_1_0",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = true,
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

      EventName = "开关场景物体",
      Actions = {
        {

          ObjName = "/Root/LevelObj/qiao",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu2",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "103307—1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu(1)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/xingzoumian/room1/wall",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "103307",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      EventName = "重新开始",
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

          CustomEventName = "第一段",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "NlLztpcj"
        },
        {

          CustomEventName = "第二段",
          Type = 19,
          Timeout = 0.5,
          TimeoutKey = "EGkKhvOK"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "第一段",
      Actions = {
        {

          NPC = "ATEN",
          Point = "M2",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "bornpoint2",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          Target = "ATEN",
          MagicId = 103314,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 103314,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "state2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "第二段",
      Actions = {
        {

          NPC = "Hero",
          Point = "bornpoint3",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          NPC = "ATEN",
          Point = "M3",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 103314,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "ATEN",
          MagicId = 103315,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "state2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "1",
      Actions = {
        {

          TimelineName = "TIMELINE3_BOSS_0",
          Fadein = 0.0,
          Fadeout = 0.0,
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

          Target = "Hero",
          Type = 37,
          Timeout = 0.0
        },
        {

          Group = 1019031,
          Type = 65,
          Timeout = 0.0
        },
        {

          Key = "H1001001_103307",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "bornpoint2",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.1,
          TimeoutKey = "VLWluhlE"
        },
        {

          Camera = 103307,
          IsNewConfig = false,
          IsForceDepressCameraMode = true,
          Type = 11,
          Timeout = 0.0
        },
        {

          Type = 61,
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

          HeroId = 1001001,
          Type = 29,
          Timeout = 0.0
        },
        {

          Target = "1001001",
          MagicId = 103314,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Transparent/Sc00_02A_transparent",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          TimelineName = "TIMELINE3_BOSS_0",
          Actions = {
            {

              ResId = 20102602,
              PosKey = "M2_0",
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Rotation = 180,
              Camp = 4,
              Level = 99,
              NPCName = "ATEN",
              AutoSave = false,
              Type = 2,
              Timeout = 0.0
            },
            {

              CustomEventName = "开关场景物体",
              Type = 19,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/LevelObj/Fx_Yunwu2",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/LevelObj/Fx_Yunwu",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              PlayBgm = "scene_ambience_earthquake_SFX",
              ChangeTime = 2.0,
              Type = 82,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline_Aten_State2_open",
          Actions = {
            {

              Type = 60,
              Timeout = 0.0
            },
            {

              StoryId = 2031702,
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

          TimelineName = "TIMELINE3_1_1_0",
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 1019031,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "1",
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

              Target = "Hero",
              Type = 38,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/scenes/Sc0001_area_a1/Part_01_a1/zhuzi_sixone_2/Sc00_build_04A_pre222",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/scenes/Sc0001_area_a1/Part_01_a1/zhuzi_sixone_2/half_left (1)/Sc00_build_04B_pre146",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/scenes/Sc0001_area_a1/Part_01_a1/zhuzi_sixone_2/half_left/Sc00_build_04B_pre143",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              StoryId = 2031701,
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

          GuideID = 1033071,
          Actions = {
            {

              Tips = "1011",
              Duration = 4.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "is_guide",
          ValidInTower = false
        }
      },
      Type = 15,
      ConditionVariable = "is_guide",
      IsNotCondition = true,
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
    [ 7 ] = {
      StoryId = 100103172,
      Name = "剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 1,
    MonsterInfo = {
      [ 20102601 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}