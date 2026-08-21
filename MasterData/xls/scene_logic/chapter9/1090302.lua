local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 116,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 113,
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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 6,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 109030201,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 109030202,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb",
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

          TimelineName = "Timeline_AirWall1090302",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          CustomEventName = "preprebox10902",
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

          Key = "barrierLen",
          SyncValType = 1,
          Value = 7.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
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

          Direction = 4,
          Type = 51,
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

      EventName = "qb",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 2.0,
          TimeoutKey = "ubquNpXs"
        },
        {

          StoryId = 34010503,
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

          PosKey = "tp4",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 2.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 2.0,
          Type = 62,
          Timeout = 2.0,
          TimeoutKey = "ufqHHxtq"
        },
        {

          PosKey = "Focus",
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

          Group = 1090302001,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "hiBAdcKD"
        },
        {

          Camera = 113,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 2.0,
          TimeoutKey = "NKozzces"
        },
        {

          CustomEventName = "prebox10902",
          Type = 19,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 2.0,
          TimeoutKey = "YykpqhGU"
        },
        {

          Variable = "Open",
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 30,
          Timeout = 0.0
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

      EventName = "preprebox10902",
      Actions = {
        {

          ObjName = "/Root/Level_/BoxModel10902",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10902",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "Box10902",
      Actions = {
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 2.5,
          TimeoutKey = "ijBDBmWN"
        },
        {

          TreasureChestId = 10902,
          PosKey = "Box",
          Rotation = 92,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "boxend10902",
          Type = 124,
          Timeout = 3.5,
          TimeoutKey = "WHeBccLb"
        },
        {

          GroupId = 1090302002,
          Type = 27,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level_/BoxModel10902",
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

      EventName = "boxend10902",
      Actions = {
        {

          Variable = "10902",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10902CLOSE",
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

      EventName = "BoxStory10902",
      Actions = {
        {

          StoryId = 36010301,
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
          TimeoutKey = "GgbJiMVu"
        },
        {

          TimelineName = "Timeline_Box_10902",
          Fadein = 1.0,
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

          ObjName = "/Root/Scene/Zone_02/Zone_02b/Building_02b/sc09_build07_pre/sc09_build07_pre0/Transparent/sc09_build_07_mod_transparent",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_02/Zone_02b/Building_02b/sc09_build07_pre/sc09_build07_pre0/Transparent/sc09_build_07_mod_transparent",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 2.0,
          TimeoutKey = "TylRkOBr"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10902OPEN",
      Actions = {
        {

          ObjName = "/Root/Level_/BoxGuide/Fx_Common_BoxGuide10902",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10902",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10902CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level_/BoxGuide/Fx_Common_BoxGuide10902",
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

      EventName = "prebox10902",
      Actions = {
        {

          PosKey = "BOXSTORY",
          NPCName = "RGpkSoeQ",
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
          NpcId = 638854130872958993,
          IsRemove = true,
          CustomEventName = "BoxStory10902",
          Type = 92,
          Timeout = 0.0
        },
        {

          Type = 134,
          Timeout = 1.0,
          TimeoutKey = "mxeOyyrf"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10902",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10902OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "Open",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10902CLOSE",
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

      ConditionActions = {
        {

          StoryId = 36010301,
          Actions = {
            {

              PosKey = "BOXSTORY",
              Rotation = 0,
              NPCId = 109021,
              NPCName = "Box",
              Type = 0,
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
    EventCount = 1,
    MonsterCount = 6,
    MonsterInfo = {
      [ 20105901 ] = 1,
      [ 20106001 ] = 2,
      [ 20105801 ] = 1,
      [ 20106201 ] = 1,
      [ 20106101 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}