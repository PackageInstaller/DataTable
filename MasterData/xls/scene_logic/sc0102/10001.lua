local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "A1",
          Rotation = 0,
          NPCId = 102149,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC",
          Rotation = 0,
          NPCId = 101201,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC1",
          Rotation = 0,
          NPCId = 101202,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "A3",
          Rotation = 0,
          NPCId = 102152,
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false
    },
    {

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      Actions = {
        {

          ResId = 300100202,
          PosKey = "C1",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 4,
          Level = 1,
          AutoSave = false,
          Type = 1,
          Timeout = 0.0
        },
        {

          ResId = 300100202,
          PosKey = "C2",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 4,
          Level = 1,
          AutoSave = false,
          Type = 1,
          Timeout = 0.0
        },
        {

          Point = "center",
          Type = 2,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false
    },
    {

      ConditionActions = {
        {

          Key = "M0",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "M0",
              RemoveForever = false,
              Type = 8,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline2_lock",
              Fadein = 1.5,
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
              Type = 5,
              Timeout = 0.0
            },
            {

              StoryId = 1012002,
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
              Type = 9,
              Timeout = 1.5
            }
          },
          FinishMarkVariable = "is_paly_timeline",
          ValidInTower = false
        },
        {

          Key = "M1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "M1",
              RemoveForever = false,
              Type = 8,
              Timeout = 0.0
            },
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 10,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "M2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "M2",
              RemoveForever = false,
              Type = 8,
              Timeout = 0.0
            },
            {

              Camera = 104,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 10,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false
    },
    {

      ConditionActions = {
        {

          StoryId = 0,
          Actions = {
            {

              TimelineName = "timeline2_lock",
              Type = 6,
              Timeout = 0.0
            },
            {

              Type = 11,
              Timeout = 0.0
            },
            {

              TaskId = 100201,
              Type = 4,
              Timeout = 0.0
            },
            {

              isVictory = true,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101202,
          Actions = {
            {

              ObjName = "scene_timeline0",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 10,
              Timeout = 0.0
            },
            {

              NPCId = 101202,
              Type = 1,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "is_interact",
          ValidInTower = false
        },
        {

          NPCId = 101201,
          Actions = {
            {

              StoryId = 1012003,
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

              RefreshCfg = {
                Weight = 100,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 0,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 0,
                    param = 0,
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 0,
                    param = 0,
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 0,
                    param = 0,
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0
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
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false
    },
    {

      Actions = {
        {

          Type = 14,
          Timeout = 18.0
        },
        {

          InputId = 0,
          Type = 4,
          Timeout = 0.0
        },
        {

          TipsId = 100112,
          Visible = true,
          Type = 15,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false
    }
  },
  MonsterRefreshCfg = {
    Weight = 100,
    MonsterGroupId = 0,
    MonsterWave = 5,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0,
    EndPerform = true,
    Conditions = {
      {
        RefreshCondition = 0,
        Id = 0,
        param = 0,
        Timeout = 0.0,
        AIGroupId = 0,
        AIGroup = 0
      },
      {
        RefreshCondition = 0,
        Id = 0,
        param = 0,
        Timeout = 0.0,
        AIGroupId = 0,
        AIGroup = 0
      },
      {
        RefreshCondition = 0,
        Id = 0,
        param = 0,
        Timeout = 0.0,
        AIGroupId = 0,
        AIGroup = 0
      },
      {
        RefreshCondition = 0,
        Id = 0,
        param = 0,
        Timeout = 0.0,
        AIGroupId = 0,
        AIGroup = 0
      },
      {
        RefreshCondition = 0,
        Id = 0,
        param = 0,
        Timeout = 0.0,
        AIGroupId = 0,
        AIGroup = 0
      }
    },
  },
  FinishiConditionDict = empty,
}