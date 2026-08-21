local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          GroupId = 107070301,
          Type = 27,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area06/build/sc06_build_61a_pre (1)/sc06_build_61a_m2",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area06/build/sc06_build_61a_pre (1)/sc06_build_61a_m3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_build_61a_pre (3)/sc06_build_61a_m2",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_build_61a_pre (3)/sc06_build_61a_m3",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          CustomEventName = "隐藏雕像",
          Type = 19,
          Timeout = 0.0
        },
        {

          TimelineName = "tl_10707034",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "tl_10707035",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          PosKey = "M5",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 5.0,
          StopLuaScript = true,
          BackToDefault = true,
          HideUI = true,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 1.0,
          TimeoutKey = "OvVFxZim"
        },
        {

          PosKey = "M7",
          NPCName = "M7",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = true,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638496561684097948,
          IsRemove = true,
          CustomEventName = "M7",
          Type = 92,
          Timeout = 0.0
        },
        {

          StoryId = 10707031,
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
          TimeoutKey = "vRdkIZuB"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 107070,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 107070,
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
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        },
        {

          Key = "K2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Target = "0_107070302_0",
              MagicId = 201051010204,
              Level = 1,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "0_107070302_1",
              MagicId = 201051010204,
              Level = 1,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "K3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Target = "0_107070303_0",
              MagicId = 201051010204,
              Level = 1,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "0_107070303_3",
              MagicId = 201051010204,
              Level = 1,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "jvQveejN"
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

          Key = "S1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              TimelineName = "tl_10707035",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              TimelineName = "tl_10707036",
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
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "S1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "M6",
              IsOpen = true,
              CameraStyle = 0,
              Duration = 5.0,
              StopLuaScript = true,
              BackToDefault = true,
              HideUI = true,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              TimelineName = "tl_10707034",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              StoryId = 10707032,
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
          FinishMarkVariable = "S2",
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

          Key = "S2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "M5",
              IsOpen = true,
              CameraStyle = 0,
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

              StoryId = 10707034,
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
              TimeoutKey = "xEEbvzXU"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "S2",
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

      EventName = "隐藏雕像",
      Actions = {
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b/sc06_prop_74b_pre (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b (1)/sc06_prop_74b_pre (4)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b (1)/sc06_prop_74b_pre (6)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b (1)/sc06_prop_74b_pre (8)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b (1)/sc06_prop_74b_pre (11)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b (1)/sc06_prop_74b_pre (12)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b (1)/sc06_prop_74b_pre (14)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b (1)/sc06_prop_74b_pre (16)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b (1)/sc06_prop_74b_pre (17)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b (1)/sc06_prop_74b_pre (19)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b/sc06_prop_74b_pre (8)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b/sc06_prop_74b_pre (9)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b/sc06_prop_74b_pre (13)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b/sc06_prop_74b_pre (14)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b/sc06_prop_74b_pre (16)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b/sc06_prop_74b_pre (17)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74b/sc06_prop_74b_pre (18)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74a/sc06_prop_74a_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc0604_area_digong/area05/build/sc06_prop_74a/sc06_prop_74a_pre (1)",
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

      EventName = "M7",
      Actions = {
        {

          StoryId = 10707033,
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
      FinishMarkVariable = "S1",
      ValidInTower = false,
      Type = 9,
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