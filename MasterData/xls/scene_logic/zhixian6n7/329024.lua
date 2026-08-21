return
{
  Events = {
    {

      StoryID = 100229801,
      Actions = {
        {

          StoryId = 100229801,
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

      ConditionActions = {
        {

          StoryId = 100229801,
          Actions = {
            {

              TimelineName = "timeline_32902_begin",
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

              StoryId = 2229801,
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
              TimeoutKey = "QNGTNfeV"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229802,
          Actions = {
            {

              TaskId = 3290602,
              Type = 5,
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

          StoryId = 2229801,
          Actions = {
            {

              TimelineName = "timeline_32902_begin",
              Type = 7,
              Timeout = 0.0
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              KeyName = "M1",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              TaskGroupId = 32906,
              Type = 21,
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

      NoPassCamera = 113,
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

          PosKey = "FBI",
          NPCName = "开门",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638751238232789486,
          IsRemove = true,
          CustomEventName = "open",
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

      EventName = "open",
      Actions = {
        {

          Camera = 113,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0,
          TimeoutKey = "InowTwKV"
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 2,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 3,
            SendWave = false,
            WaveStyle = 0,
            WallObjPath = "emptywall",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 29211,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "play2229802",
                Timeout = 1.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
            MonsterLockEnemyInfoList = {
              {
                Target = "3290201",
                Weight = 1,
                Behit = 0,
                IgnoreDistance = false
              },
              {
                Target = "Hero",
                Weight = 1,
                Behit = 1,
                IgnoreDistance = false
              }
            },
          },
          Type = 8,
          Timeout = 0.5,
          TimeoutKey = "TVlEQVPB"
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 29212,
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
          TimeoutKey = "OYRqAnVj"
        },
        {

          ObjName = "/Root/Level/Level_01/sc06_build_31a_pre/TL_door1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          CustomEventName = "shock",
          Type = 19,
          Timeout = 2.0,
          TimeoutKey = "efedLjmL"
        },
        {

          PlayBgm = "bgm_chapter6_common",
          Type = 76,
          Timeout = 0.5,
          TimeoutKey = "BYAJdtrs"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "play2229802",
      Actions = {
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          HeroId = 1001024,
          Type = 29,
          Timeout = 0.5,
          TimeoutKey = "IyhoTtiU"
        },
        {

          NPC = "Hero",
          Point = "M2",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "USIdAkgP"
        },
        {

          Group = 29212,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "nSYIrauN"
        },
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 3029241,
          NPCName = "傀儡师傅",
          Type = 0,
          Timeout = 0.5,
          TimeoutKey = "uqftOuan"
        },
        {

          StoryId = 2229802,
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
          TimeoutKey = "FlNrKUHO"
        },
        {

          PlayBgm = "storybgm_057",
          Type = 76,
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

      EventName = "shock",
      Actions = {
        {

          Type = 71,
          Timeout = 0.0
        },
        {

          Type = 61,
          Timeout = 0.0
        },
        {

          StoryId = 3229801,
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

          Point = "M1",
          Type = 3,
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

          StoryId = 2229801,
          StepId = 2,
          Actions = {
            {

              TimelineName = "timeline_32902_begin",
              Type = 7,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229801,
          StepId = 8,
          Actions = {
            {

              Camera = 1,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "M1",
              IsOpen = true,
              CameraStyle = 0,
              Duration = -1.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = -1.0,
              Type = 62,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229801,
          StepId = 11,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              KeyName = "fake",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 3229801,
          StepId = 1,
          Actions = {
            {

              PosKey = "M1cmr",
              IsOpen = true,
              CameraStyle = 0,
              Duration = -1.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = true,
              HasOTSConfig = true,
              OTSCameraStyle = 1,
              OTSDuration = -1.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              Point = "M1",
              Type = 3,
              Timeout = 0.5,
              TimeoutKey = "kgWSTMDI"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 3229801,
          StepId = 2,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 0.5,
              TimeoutKey = "ALGcrqwx"
            },
            {

              TaskId = 3290601,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 3229801,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 0.5,
              TimeoutKey = "QIwEdOmR"
            },
            {

              TaskId = 3290601,
              Type = 5,
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

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 35,
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
    [ 4 ] = {
      StoryId = 2229802,
      Name = "4.剧情结束"
    }
  },
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 4,
    MonsterInfo = {
      [ 20103706 ] = 3,
      [ 3290201 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}