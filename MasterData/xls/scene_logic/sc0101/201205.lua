return
{
  Events = {
    {

      Actions = {
        {

          Key = "in_daze",
          SyncValType = 1,
          Value = 1.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ResId = 20103901,
          PosKey = "NPC1",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 2,
          Level = 999,
          NPCName = "NPC",
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

          TimelineName = "timeline_B0208",
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
          Timeout = 1.0,
          TimeoutKey = "1"
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

          Key = "battle",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
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
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 20120501,
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

          Key = "battle1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 5,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 20120503,
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

          Key = "battle1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              ResId = 20103506,
              PosKey = "NPC2",
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Rotation = 180,
              Camp = 2,
              Level = 999,
              NPCName = "2",
              AutoSave = false,
              Type = 2,
              Timeout = 0.0
            },
            {

              ResId = 20103506,
              PosKey = "NPC3",
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Rotation = 180,
              Camp = 2,
              Level = 999,
              NPCName = "3",
              AutoSave = false,
              Type = 2,
              Timeout = 0.0
            },
            {

              ResId = 20103506,
              PosKey = "NPC4",
              OffsetX = 0.0,
              OffsetZ = 0.0,
              Rotation = 180,
              Camp = 2,
              Level = 999,
              NPCName = "4",
              AutoSave = false,
              Type = 2,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_B0207",
              Fadein = 1.0,
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

              StoryId = 2021002,
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

          Key = "talk",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 1021003,
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

          StoryId = 2020903,
          Actions = {
            {

              TimelineName = "timeline_B0207",
              Type = 7,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 1021003,
          Actions = {
            {

              Key = "in_daze",
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
        },
        {

          StoryId = 100102102,
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
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 1022029,
          Actions = {
            {

              NPCId = 1022029,
              NPCName = "chazhen",
              Type = 1,
              Timeout = 0.0
            },
            {

              TreasureChestId = 10208,
              PosKey = "B1",
              Rotation = 180,
              IsPlayEffectAndSound = true,
              IsCanOpen = true,
              CustomEventName = "boxEnd",
              Type = 124,
              Timeout = 1.0,
              TimeoutKey = "jkDSucZw"
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
      Type = 6,
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

      EventName = "over",
      Actions = {
        {

          TimelineName = "timeline_B0213",
          Fadein = 1.0,
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
          Timeout = 1.5,
          TimeoutKey = "mWyYlpyz"
        },
        {

          TaskId = 102204,
          Type = 5,
          Timeout = 0.0
        },
        {

          Key = "gameover",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 15.0,
          TimeoutKey = "ZuWtVETs"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "box",
      Actions = {
        {

          PosKey = "B1",
          Rotation = 0,
          NPCId = 1022029,
          NPCName = "chazhen",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10208",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "boxEnd",
      Actions = {
        {

          Variable = "10208",
          Type = 128,
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

          TimelineName = "timeline_B0213",
          Actions = {
            {

              StoryId = 100102102,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = true,
              Type = 10,
              Timeout = 0.0
            },
            {

              Key = "ZuWtVETs",
              Type = 52,
              Timeout = 0.1,
              TimeoutKey = "DTMHYkWL"
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
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 100102102,
      Name = "剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 9,
    MonsterInfo = {
      [ 20103001 ] = 6,
      [ 20102701 ] = 2,
      [ 20101201 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}