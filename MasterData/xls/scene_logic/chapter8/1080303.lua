local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 1080202,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = true,
      PassCamera = 1080202,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
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

          KeyName = "fakeTp3",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          GroupID = 1,
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

          Key = "fight",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "M1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.0,
              StopLuaScript = true,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.5,
              TimeoutKey = "YnUaNRcs"
            },
            {

              StoryId = 5080402,
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
              TimeoutKey = "ccNvEYSg"
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 12,
                SendWave = false,
                WaveStyle = 0,
                WallObjPath = "emptywall",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 10803101,
                    param = 2,
                    Name = "剩余",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10803101,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "win",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.5,
              TimeoutKey = "PnxHUvUG"
            }
          },
          ValidInTower = false
        },
        {

          Key = "fakeTp3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
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

              CustomEventName = "2楼",
              Type = 19,
              Timeout = 0.3,
              TimeoutKey = "MhSEBmkr"
            },
            {

              NPC = "Hero",
              Point = "fakeTp4",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.4,
              TimeoutKey = "yNPsMToY"
            },
            {

              Point = "choice3",
              Type = 3,
              Timeout = 0.5,
              TimeoutKey = "uRBKmXOi"
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

      EventName = "win",
      Actions = {
        {

          PosKey = "fakeTp3",
          NPCName = "AtldVeWX",
          NpcParams = {
            InteractionArea = -1.0,
            UseEffect = "Fx_Transmit3_idel|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638732437724197701,
          IsRemove = false,
          Type = 92,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
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

      EventName = "2楼",
      Actions = {
        {

          TimelineName = "timeline_10803_ignoreEnemy",
          Fadein = 0.0,
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

          StoryId = 4080404,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = true,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        },
        {

          AreaName = "escape",
          RemoveForever = true,
          Type = 9,
          Timeout = 0.0
        },
        {

          PosKey = "choice1",
          Rotation = 180,
          NPCId = 10803301,
          NPCName = "演出枪手1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "choice4",
          Rotation = 0,
          NPCId = 10803302,
          NPCName = "演出枪手2",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "choice2",
          Rotation = 120,
          NPCId = 10803303,
          NPCName = "演出匕首1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "choice3",
          Rotation = -120,
          NPCId = 10803304,
          NPCName = "演出匕首2",
          Type = 0,
          Timeout = 0.0
        },
        {

          Type = 71,
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

          StoryId = 4080404,
          Actions = {
            {

              TimelineName = "timeline_10803_ignoreEnemy",
              Type = 7,
              Timeout = 0.0
            },
            {

              CustomEventName = "胜利1",
              Type = 19,
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

      EventName = "胜利1",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
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
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "regret",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              NPCId = 10803301,
              NPCName = "枪手1",
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 10803304,
              NPCName = "枪手2",
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 10803302,
              NPCName = "匕首1",
              Type = 1,
              Timeout = 0.0
            },
            {

              NPCId = 10803303,
              NPCName = "匕首2",
              Type = 1,
              Timeout = 0.0
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10803301,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "胜利2",
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

              PosKey = "regretLook",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 1.5,
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

              Point = 4,
              Type = 109,
              Timeout = 0.0
            },
            {

              Type = 71,
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

      EventName = "胜利2",
      Actions = {
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "fought",
      ValidInTower = true,
      Type = 9,
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

      Actions = {
        {

          ObjName = "/Root/Level/10802/scene_timeline_1080202_halfOpenTimeline",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_06/Building_06/down/sc08_build_17b_pre8/sc08_build_17c_01_mod",
          Visible = true,
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
    EventCount = 2,
    MonsterCount = 16,
    MonsterInfo = {
      [ 20105701 ] = 6,
      [ 20205501 ] = 4,
      [ 20205601 ] = 6
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}