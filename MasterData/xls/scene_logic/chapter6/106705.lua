local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          GroupId = 10670501,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "rvdkArLl"
        },
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 106999,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          TipsId = 10670063,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          KeyName = "tp2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

      NoPassCamera = 106000,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 106000,
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

          TreasureChestId = 10610,
          PosKey = "BOX1",
          Rotation = 180,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10610",
          Type = 124,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10611",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "AfterBOX10611",
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

      ConditionActions = {
        {

          Key = "trg1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 5,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                ActionTag = "1",
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 10670201,
                    param = 1,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 106705001,
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
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "trg2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 3,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                ActionTag = "2",
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 106705002,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "over",
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

          Key = "BOX",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              CustomEventName = "PBOX10611",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "10614",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 5061102,
          Actions = {
            {

              GroupId = 1063,
              Type = 42,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 10630302,
          Actions = {
            {

              PosKey = "tp4",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.0,
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

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              TaskId = 106202,
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

          StoryId = 6060801,
          Actions = {
            {

              GroupId = 10670502,
              Type = 27,
              Timeout = 0.0
            },
            {

              GroupId = 10670503,
              Type = 27,
              Timeout = 3.0,
              TimeoutKey = "jwwbHjUx"
            },
            {

              TreasureChestId = 10614,
              PosKey = "LB3",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              Type = 124,
              Timeout = 2.0,
              TimeoutKey = "BPbWGxYf"
            },
            {

              TreasureChestId = 10624,
              PosKey = "LB4",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              Type = 124,
              Timeout = 2.0,
              TimeoutKey = "lgyWawLq"
            },
            {

              TreasureChestId = 10625,
              PosKey = "LB5",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              Type = 124,
              Timeout = 2.0,
              TimeoutKey = "NeddSRYl"
            },
            {

              TreasureChestId = 10626,
              PosKey = "LB6",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              Type = 124,
              Timeout = 5.0,
              TimeoutKey = "TSyHNSmB"
            },
            {

              TreasureChestId = 10627,
              PosKey = "LB7",
              Rotation = 0,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              Type = 124,
              Timeout = 5.0,
              TimeoutKey = "vVrpvbjV"
            },
            {

              TimelineName = "timeline_box10611",
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
              Timeout = 6.0,
              TimeoutKey = "HgXXVkmS"
            },
            {

              TimelineName = "timeline_box10611",
              Type = 7,
              Timeout = 10.0,
              TimeoutKey = "qiTFqLAm"
            }
          },
          FinishMarkVariable = "10614",
          ValidInTower = true
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

          NPCId = 1061002,
          Actions = {
            {

              Tips = "后补光点（可以去掉小游戏）",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/Level_01/sc06_build_40_pre (1)/TL_WaterWell",
              PlatCount = 0,
              Type = 96,
              Timeout = 1.0,
              TimeoutKey = "kKnfsJec"
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

          Direction = 2,
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

      EventName = "over",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          KeyName = "tp2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

      EventName = "PREBOX10611",
      Actions = {
        {

          PosKey = "LB1",
          NPCName = "ZSgoFVxK",
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
          NpcId = 638666721596519684,
          IsRemove = true,
          CustomEventName = "BOX10611STORY1",
          Type = 92,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10611",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BOX10611STORY1",
      Actions = {
        {

          StoryId = 6060801,
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

      EventName = "AfterBOX10611",
      Actions = {
        {

          TreasureChestId = 10614,
          PosKey = "LB3",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10624,
          PosKey = "LB4",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10625,
          PosKey = "LB5",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10626,
          PosKey = "LB6",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10627,
          PosKey = "LB7",
          Rotation = 0,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          Type = 124,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10611",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10610OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/Level_01/BoxGuideFx/Fx_Common_BoxGuide10610",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10610",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10610CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/Level_01/BoxGuideFx/Fx_Common_BoxGuide10610",
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

      EventName = "GBOX10611OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/Level_01/BoxGuideFx/Fx_Common_BoxGuide10611",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10611",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10611CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/Level_01/BoxGuideFx/Fx_Common_BoxGuide10611",
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

      EventName = "BOXEND10610",
      Actions = {
        {

          Variable = "10610",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10610CLOSE",
          Type = 19,
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

      EventName = "PBOX10611",
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
                Id = 106706003,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "BOX10611",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.1,
          TimeoutKey = "lbQdGWzL"
        },
        {

          TimelineName = "TIMELINE_BOX1061102",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10611",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BOX10611",
      Actions = {
        {

          TreasureChestId = 10611,
          PosKey = "BOX2",
          Rotation = 180,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10611",
          Type = 124,
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

      EventName = "BOXEND10611",
      Actions = {
        {

          Variable = "10611",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10611CLOSE",
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

      Actions = {
        {

          CustomEventName = "GBOX10610OPEN",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10611OPEN",
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

          CustomEventName = "GBOX10610CLOSE",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10611CLOSE",
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

          TimelineName = "timeline_box10611",
          Actions = {
            {

              TimelineName = "TIMELINE_BOX1061102",
              IsPlay = true,
              Type = 110,
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
    MonsterCount = 9,
    MonsterInfo = {
      [ 20204401 ] = 2,
      [ 20104901 ] = 1,
      [ 20204901 ] = 2,
      [ 20205001 ] = 3,
      [ 20105001 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}