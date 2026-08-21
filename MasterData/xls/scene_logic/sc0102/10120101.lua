local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "TIMELINE1_1_1_0",
          Fadein = 0.0,
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

          CustomEventName = "显示场景漂浮物",
          Type = 19,
          Timeout = 15.0,
          TimeoutKey = "fNebPlio"
        },
        {

          StartRoomId = 5,
          TargetRoomId = 8,
          IsOpen = false,
          Type = 24,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4010212,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4010213,
          Level = 0,
          Type = 16,
          Timeout = 16.0,
          TimeoutKey = "1"
        },
        {

          CustomEventName = "1",
          Type = 19,
          Timeout = 0.0
        },
        {

          StartRoomId = 5,
          TargetRoomId = 8,
          IsOpen = false,
          Type = 24,
          Timeout = 0.0
        },
        {

          CustomEventName = "monster0",
          Type = 19,
          Timeout = 16.0,
          TimeoutKey = "2"
        },
        {

          Key = "close_tips",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ChangeTime = 0.0,
          Type = 75,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_elite",
          Type = 76,
          Timeout = 0.0
        },
        {

          CustomEventName = "隐藏场景漂浮物",
          Type = 19,
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

      NoPassCamera = 104,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 104,
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
          MagicId = 19991681,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          CustomEventName = "box",
          Type = 19,
          Timeout = 0.0
        },
        {

          PosKey = "EGG",
          NPCName = "WxczrXtC",
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
          NpcId = 638753899603935172,
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

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 403210033,
          Level = 0,
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ResId = 3001054,
          PosKey = "ball",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 4,
          Level = 99,
          NPCName = "1",
          AutoSave = false,
          Type = 2,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "pass1111111",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "camera2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 1091,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 104,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "close",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              StartRoomId = 5,
              TargetRoomId = 8,
              IsOpen = false,
              Type = 24,
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

          Key = "timeline1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          FinishMarkVariable = "is_book_fall",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "is_book_fall",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "camera2",
          Actions = {
            {

              Camera = 104,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera4",
          Actions = {
            {

              Camera = 113,
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

          StoryId = 6010101,
          Actions = {
            {

              TreasureChestId = 10110,
              PosKey = "NPC3",
              Rotation = 90,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "lOYczgta"
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

          StoryId = 101101,
          Actions = {
            {

              TimelineName = "timeline1_1shujia_new",
              Fadein = 2.0,
              Fadeout = 100.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = true,
              BlackIn = 1.0,
              Hold = 0.5,
              BlackOut = 1.0,
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

              ObjName = "scene_timeline_shujia1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.5,
              TimeoutKey = "1"
            },
            {

              StoryId = 201101,
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
              Timeout = 3.0,
              TimeoutKey = "2"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 101102,
          Actions = {
            {

              StoryId = 101111,
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

          StoryId = 101109,
          Actions = {
            {

              TimelineName = "timeline1_2_shujia",
              Type = 7,
              Timeout = 0.0
            },
            {

              CondId = 2012,
              CondValue = 1,
              Type = 31,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 101111,
          Actions = {
            {

              TimelineName = "timeline1_2_shujia",
              Type = 7,
              Timeout = 0.0
            },
            {

              TaskGroupId = 1011,
              Type = 21,
              Timeout = 0.0,
              TimeoutKey = "1"
            },
            {

              Key = "close_tips",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "FX_10120101",
              IsAutoSave = true,
              Type = 53,
              Timeout = 0.0
            },
            {

              GroupId = 100108,
              Type = 42,
              Timeout = 1.0,
              TimeoutKey = "3"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 201101,
          Actions = {
            {

              TimelineName = "timeline1_1shujia_new",
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

          NPCId = 101103,
          Actions = {
            {

              TimelineName = "timeline1_2_shujia",
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
              Timeout = 0.0
            },
            {

              StoryId = 101109,
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
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "is_in_task",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101103,
          Actions = {
            {

              TimelineName = "timeline1_2_shujia",
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
              Timeout = 0.0
            },
            {

              StoryId = 101102,
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
      Type = 6,
      ConditionVariable = "is_in_task",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Type = 12,
          Timeout = 0.0
        },
        {

          CustomEventName = "story",
          Type = 19,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_common",
          Type = 76,
          Timeout = 1.0,
          TimeoutKey = "bgm_modern_common"
        }
      },
      FinishMarkVariable = "pass1111111",
      ValidInTower = true,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          GroupId = 100108,
          Actions = {
            {

              GuideId = 101118,
              Type = 41,
              Timeout = 0.5,
              TimeoutKey = "2"
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

      EventName = "显示场景漂浮物",
      Actions = {
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a3_pre 1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a5_pre (2)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (357)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33b_pre/sc01_prp_13a_pre(4)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (358)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33b_pre/sc01_prp_13a_pre (1)(4)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_15c_pre(20)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (1)(3)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (355)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (322)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (2)(3)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (4)(2)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (3)(3)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre(3)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09b_pre(16)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_10a_pre(22)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a3_pre",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a5_pre",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_34a_pre/sc01_prp_13a_pre (2)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_34a_pre/sc01_prp_13a_pre",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09b_pre(19)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (331)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (332)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09b_pre(17)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (346)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09e_pre(18)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 2.0,
          TimeoutKey = "rWIWuRdj"
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09c_pre(10)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 2.0,
          TimeoutKey = "cUNYxHvR"
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09e_pre(17)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 2.0,
          TimeoutKey = "hOyjHCaN"
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09c_pre(9)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 2.0,
          TimeoutKey = "cjQJYUcB"
        },
        {

          ObjName = "/Root/Change_/Change_day/FX/Fx_sc01_c1_ray (1)/rays (9)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "float",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "float",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "显示场景漂浮物2",
      Actions = {
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a3_pre 1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a5_pre (2)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (357)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33b_pre/sc01_prp_13a_pre(4)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (358)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33b_pre/sc01_prp_13a_pre (1)(4)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_15c_pre(20)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (1)(3)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (355)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (322)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (2)(3)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (4)(2)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (3)(3)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre(3)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09b_pre(16)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_10a_pre(22)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a3_pre",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a5_pre",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_34a_pre/sc01_prp_13a_pre (2)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_34a_pre/sc01_prp_13a_pre",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09b_pre(19)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (331)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (332)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09b_pre(17)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (346)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09e_pre(18)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09c_pre(10)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09e_pre(17)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09c_pre(9)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          ObjName = "/Root/Change_/Change_day/FX/Fx_sc01_c1_ray (1)/rays (9)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "float",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "float",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "box",
      Actions = {
        {

          NPCName = "gtGmYlal",
          Type = 93,
          Timeout = 0.0
        },
        {

          PosKey = "NPC3",
          NPCName = "gtGmYlal",
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
          NpcId = 638625382765728889,
          IsRemove = true,
          CustomEventName = "boxPre",
          Type = 92,
          Timeout = 0.25,
          TimeoutKey = "vRcdOUnH"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10110",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "monster0",
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
            WallObjPath = "",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10110100,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 101101,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 1011010,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "",
                Timeout = 0.0,
                AIGroupId = 101101,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "monster0",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "story",
      Actions = {
        {

          StoryId = 101101,
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
          TimeoutKey = "101101"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "1",
      Actions = {
        {

          ObjName = "Scene/00_Background/Group_01",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/00_Background/Group_02",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/00_Background/Group_03",
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

      EventName = "boxPre",
      Actions = {
        {

          StoryId = 6010101,
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

      EventName = "boxEnd",
      Actions = {
        {

          Variable = "10110",
          Type = 128,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10110",
          IsAutoSave = false,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide104",
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

      EventName = "隐藏场景漂浮物",
      Actions = {
        {

          Key = "float",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a3_pre 1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a5_pre (2)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (357)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33b_pre/sc01_prp_13a_pre(4)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (358)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33b_pre/sc01_prp_13a_pre (1)(4)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_15c_pre(20)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (1)(3)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (355)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (322)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (2)(3)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (4)(2)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre (3)(3)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_33a_pre/sc01_prp_13a_pre(3)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09b_pre(16)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_10a_pre(22)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a3_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_02a5_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_34a_pre/sc01_prp_13a_pre (2)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_34a_pre/sc01_prp_13a_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09b_pre(19)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (331)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (332)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09b_pre(17)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_13a_pre (346)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09e_pre(18)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09c_pre(10)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09e_pre(17)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/02_YXS/sc01_area_02/Prop/sc01_prp_09c_pre(9)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_day/FX/Fx_sc01_c1_ray (1)/rays (9)",
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

      EventName = "2",
      Actions = {
        {

          ObjName = "Scene/00_Background/Group_01",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/00_Background/Group_02",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/00_Background/Group_03",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_day/02_YXS_Timeline",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_day/sc01_chapter_01_pre",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_day/Level1",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "scene_timeline_TIMELINE1_1_1",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_day/TimelineObj",
          Visible = false,
          IsAutoSave = true,
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

      EventName = "彩蛋",
      Actions = {
        {

          EggID = 1009,
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

          TimelineName = "TIMELINE1_1_1_0",
          Actions = {
            {

              Target = "Hero",
              MagicId = 4010213,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              CustomEventName = "2",
              Type = 19,
              Timeout = 0.0
            },
            {

              Key = "2",
              Type = 52,
              Timeout = 0.0
            },
            {

              CustomEventName = "monster0",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "timeline_end",
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "monster0",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "TIMELINE1_1_1_0",
          Actions = {
            {

              Target = "Hero",
              MagicId = 4010213,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              CustomEventName = "2",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "timeline_end",
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "monster0",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "TIMELINE1_1_1_0",
          Actions = {
            {

              CustomEventName = "显示场景漂浮物2",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          TimelineName = "timeline1_1shujia_new",
          Actions = {
            {

              TimelineName = "timeline1_2_shujia",
              Fadein = 1.0,
              Fadeout = 1.0,
              IsCanSkip = false,
              NotPauseLua = false,
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

              StoryId = 101102,
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
              TimeoutKey = "TZZZTnmx"
            },
            {

              NPC = "Hero",
              Point = "NPC4",
              Rotate = -90.0,
              TransmitTime = 0.0,
              Type = 26,
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

          TaskId = 201202,
          Actions = {
            {

              StoryId = 101111,
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
      Type = 14,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          GuideId = 101115,
          Type = 41,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 16,
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
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 7,
    MonsterInfo = {
      [ 20101501 ] = 6,
      [ 20101401 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}