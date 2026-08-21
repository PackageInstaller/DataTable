local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 8,
            SendWave = false,
            WaveStyle = 0,
            WallObjPath = "emptywall",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10812201,
                param = 4,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 10812202,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear",
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
          Enable = false,
          Type = 119,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "tp1",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10804",
          Type = 19,
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

          TimelineName = "timeline_10812_scan",
          Fadein = 0.0,
          Fadeout = 1.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = true,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.3,
          BeforeBlackOut = 0.3,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          StoryId = 5081601,
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
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_10812_scan",
          Actions = {
            {

              Target = "Hero",
              Enable = true,
              Type = 119,
              Timeout = 3.5,
              TimeoutKey = "aImPLdVF"
            },
            {

              HeroId = 1001025,
              Type = 29,
              Timeout = 3.5,
              TimeoutKey = "NUjrwBgp"
            },
            {

              TimelineName = "timeline_10812_scan",
              Type = 7,
              Timeout = 6.5,
              TimeoutKey = "oQenzQwu"
            }
          },
          ValidInTower = false
        }
      },
      Type = 32,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          TaskId = 1081202,
          Type = 5,
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
    },
    {

      EventName = "PREBOX10804",
      Actions = {
        {

          TreasureChestId = 10804,
          PosKey = "BOX",
          Rotation = -90,
          IsPlayEffectAndSound = true,
          IsCanOpen = false,
          CustomEventName = "BOXEND10804",
          Type = 124,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10804",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10804OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuide/Fx_Common_BoxGuide10804",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10804",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10804CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuide/Fx_Common_BoxGuide10804",
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

      EventName = "BOX10804",
      Actions = {
        {

          TreasureChestId = 10804,
          IsCanOpen = true,
          Type = 125,
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

      EventName = "BOXEND10804",
      Actions = {
        {

          Variable = "10804",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10804CLOSE",
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

          CustomEventName = "GBOX10804OPEN",
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

          CustomEventName = "GBOX10804CLOSE",
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

          Key = "BOXFIGHT",
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10812203,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "BOX10804",
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
        }
      },
      Type = 3,
      ConditionVariable = "10804",
      IsNotCondition = true,
      IsForeverVariable = true
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
    MonsterCount = 11,
    MonsterInfo = {
      [ 20105701 ] = 6,
      [ 20205501 ] = 1,
      [ 20105601 ] = 1,
      [ 20205601 ] = 1,
      [ 20105501 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}