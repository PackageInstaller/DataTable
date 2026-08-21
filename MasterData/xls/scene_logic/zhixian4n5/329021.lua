local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          Rotation = -15,
          NPCId = 3029211,
          NPCName = "唯实社",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "唯实社交互",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638696109129741297,
          IsRemove = true,
          CustomEventName = "member",
          Type = 92,
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

      NoPassCamera = 118,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 118,
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

          StoryId = 2229202,
          Actions = {
            {

              KeyName = "M3",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            },
            {

              PosKey = "M3",
              NPCName = "薪对话",
              NpcParams = {
                InteractionArea = 3.3,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638707393569718765,
              IsRemove = true,
              CustomEventName = "xinTalk",
              Type = 92,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229203,
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

      EventName = "member",
      Actions = {
        {

          PosKey = "M3",
          Rotation = 165,
          NPCId = 3029311,
          NPCName = "薪",
          Type = 0,
          Timeout = 0.5,
          TimeoutKey = "JiMQlgco"
        },
        {

          StoryId = 2229202,
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

      EventName = "xinTalk",
      Actions = {
        {

          StoryId = 2229203,
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

      ConditionActions = {
        {

          StoryId = 2229202,
          StepId = 2,
          Actions = {
            {

              PosKey = "M3",
              IsOpen = true,
              CameraStyle = 1,
              Duration = -1.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 1,
              OTSDuration = -1.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              Point = "M3",
              Type = 3,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2229202,
          StepId = 3,
          Actions = {
            {

              Point = "M4",
              Type = 3,
              Timeout = 0.0
            },
            {

              BackToDefault = false,
              Type = 63,
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