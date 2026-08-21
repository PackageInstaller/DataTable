local empty = {}
return
{
  Events = {
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

          ResId = 10120901,
          PosKey = "center",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 4,
          Level = 99,
          NPCName = "npc",
          AutoSave = false,
          Type = 2,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4032107,
          Level = 0,
          Type = 16,
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

      Actions = {
        {

          PosKey = "center1",
          Rotation = 0,
          NPCId = 101111,
          Type = 0,
          Timeout = 0.0
        },
        {

          PlayBgm = "storybgm_003",
          Type = 76,
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

      ConditionActions = {
        {

          NPCId = 101111,
          Actions = {
            {

              TipsId = 100171,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              PosKey = "center1",
              Rotation = 0,
              NPCId = 101111,
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "tips1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101111,
          Actions = {
            {

              TipsId = 100184,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              PosKey = "center1",
              Rotation = 0,
              NPCId = 101111,
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "tips1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Target = "Hero",
          MagicId = 4032108,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
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

          StoryId = 201318,
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
      FinishMarkVariable = "maze2",
      ValidInTower = true,
      Type = 1,
      ConditionVariable = "maze2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 9901,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 9901,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = empty,
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "maze2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "dialog",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 201307,
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

              AreaName = "dialog",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "dialog1",
          ValidInTower = true
        }
      },
      Type = 3,
      ConditionVariable = "dialog1",
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = {
    [ 5 ] = {
      Name = "进入房间"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}