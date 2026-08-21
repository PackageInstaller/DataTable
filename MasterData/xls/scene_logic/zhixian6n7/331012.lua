return
{
  Events = {
    {

      NoPassCamera = 33101,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 33101,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          TimelineName = "scene_timeline_331102",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          StoryId = 2231107,
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
          Timeout = 0.2,
          TimeoutKey = "LHCBsrul"
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

          Key = "focus",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              PosKey = "M1",
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
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 2.0,
              TimeoutKey = "jigJgXag"
            },
            {

              TaskId = 3310104,
              Type = 5,
              Timeout = 1.0,
              TimeoutKey = "OPcFmjDj"
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

          Key = "enemy",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
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
                WallObjPath = "2",
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 31122,
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

      EventName = "谈话",
      Actions = {
        {

          StoryId = 100231102,
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

          TaskId = 3310105,
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

      EventName = "clear",
      Actions = {
        {

          PosKey = "M1",
          NPCName = "dQlCZWLY",
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
          NpcId = 638727108032908126,
          IsRemove = true,
          CustomEventName = "谈话",
          Type = 92,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
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
      StoryId = 100231102,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 4,
    MonsterInfo = {
      [ 20105201 ] = 1,
      [ 20204601 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}