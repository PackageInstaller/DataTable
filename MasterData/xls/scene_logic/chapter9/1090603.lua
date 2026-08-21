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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          StoryId = 35011202,
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

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          PosKey = "Guide1",
          NPCName = "Guide",
          NpcParams = {
            InteractionArea = 0.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638841378561676998,
          IsRemove = true,
          Type = 92,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_AirWall1090603",
          IsPlay = true,
          Type = 110,
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 15.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
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

          Key = "EnterSpawnEnemy",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Camera = 102,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              PosKey = "Guide1",
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

              KeyName = "Guide1",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
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

          Key = "Fight",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 5,
                MonsterCount = 34,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 109060301,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb1",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 109060302,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb2",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 109060303,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb3",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 109060304,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb4",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 109060305,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb5",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 0.2,
              TimeoutKey = "xuYkghmI"
            },
            {

              NPCName = "Guide",
              Type = 93,
              Timeout = 0.0
            },
            {

              GroupId = 1090603001,
              Type = 27,
              Timeout = 0.0
            },
            {

              PlayBgm = "bgm_chapter_ex1_elite",
              Type = 76,
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

      EventName = "qb1",
      Actions = {
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 13.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.5,
          TimeoutKey = "SkYEBcsU"
        },
        {

          GroupId = 1090603002,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "iWArepMe"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb2",
      Actions = {
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 11.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.5,
          TimeoutKey = "UNuKjHVY"
        },
        {

          GroupId = 1090603003,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "hkkuelNa"
        },
        {

          Group = 1090603001,
          Type = 65,
          Timeout = 0.3,
          TimeoutKey = "OkENtHBj"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb3",
      Actions = {
        {

          GroupId = 1090603004,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "tVTfeMfx"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb4",
      Actions = {
        {

          Group = 1090603002,
          Type = 65,
          Timeout = 0.1,
          TimeoutKey = "JpklFzYU"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb5",
      Actions = {
        {

          Camera = 111,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.5,
          TimeoutKey = "YFLRWFQD"
        },
        {

          Group = 1090603003,
          Type = 65,
          Timeout = 0.1,
          TimeoutKey = "bNorlOCy"
        },
        {

          Group = 1090603004,
          Type = 65,
          Timeout = 0.1,
          TimeoutKey = "GrcsxWHt"
        },
        {

          GroupID = 2,
          Type = 87,
          Timeout = 0.0
        },
        {

          PosKey = "tp4",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 3.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = true,
          OTSCameraStyle = 0,
          OTSDuration = 3.0,
          Type = 62,
          Timeout = 1.0,
          TimeoutKey = "QVyxzHxC"
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 2.5,
          TimeoutKey = "vxkHnekK"
        },
        {

          TimelineName = "Timeline_AirWall1090603",
          IsPlay = false,
          Type = 110,
          Timeout = 2.0,
          TimeoutKey = "cfeHbegI"
        },
        {

          Direction = 4,
          Type = 51,
          Timeout = 2.5,
          TimeoutKey = "XXMMqRuJ"
        },
        {

          TaskId = 1090601,
          Type = 5,
          Timeout = 2.0,
          TimeoutKey = "UhvOvbDt"
        },
        {

          PlayBgm = "bgm_chapterEX1_common",
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

      ConditionActions = {
        {

          Key = "tp3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              TaskId = 1090602,
              Type = 5,
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
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 34,
    MonsterInfo = {
      [ 20205601 ] = 5,
      [ 20106201 ] = 6,
      [ 20205501 ] = 10,
      [ 20105601 ] = 3,
      [ 20106101 ] = 2,
      [ 20105801 ] = 2,
      [ 20105501 ] = 2,
      [ 20106001 ] = 2,
      [ 20105901 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}