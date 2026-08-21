local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Configs = {
            {
              LevelObjName = "SceneNPC1",
              ObjName = "317020201",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "317020202",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            }
          },
          Type = 104,
          Timeout = 0.0
        },
        {

          Key = "qian_dark",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "nightSwitch",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
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

      NoPassCamera = 113,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 117,
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

          ObjName = "SceneNPC1_/3170202",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 5,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 17006,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb",
                Timeout = 2.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.5,
          TimeoutKey = "iTZWKUgP"
        },
        {

          ObjName = "/Root/Level/18/sc05_prp_55c_pre(10)/sc05_prp_55c_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          Key = "Z1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Camera = 117,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "aikZnboN"
            },
            {

              TimelineName = "TimeLine_317020201",
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

          StoryId = 100217201,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0,
              TimeoutKey = "QCCwmRih"
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

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "monster_hate",
      Actions = {
        {

          Key = "hate",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Target = "0_17006_0",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_17006_1",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_17006_2",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_17006_3",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "0_17006_4",
          MagicId = 40104404,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "hate",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          TaskId = 3170201,
          Type = 5,
          Timeout = 0.0
        },
        {

          StoryId = 100217201,
          EnableBlackFade = true,
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

          StoryId = 100217201,
          StepId = 0,
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
      Type = 12,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCName = "317020201",
          Actions = {
            {

              CustomEventName = "monster_hate",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "hit",
          ValidInTower = false
        },
        {

          NPCName = "317020202",
          Actions = {
            {

              CustomEventName = "monster_hate",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "hit",
          ValidInTower = false
        }
      },
      Type = 30,
      ConditionVariable = "hit",
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
    EndPerform = true
  },
  FinishiConditionDict = empty,
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 5,
    MonsterInfo = {
      [ 20204401 ] = 1,
      [ 20204301 ] = 2,
      [ 20204601 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}