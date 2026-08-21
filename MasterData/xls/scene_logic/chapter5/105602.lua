local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/SceneNPC1_/1056and1058/105602",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level1/105602",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Configs = {
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560201",
              NpcId = 201203,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560202",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560203",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560204",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560205",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560206",
              NpcId = 201203,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560207",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560208",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560209",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560210",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560211",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560212",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560213",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560214",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560215",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560218",
              NpcId = 20120302,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560219",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560220",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560216",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            },
            {
              LevelObjName = "SceneNPC1",
              ObjName = "10560217",
              NpcId = 20120301,
              Camp = 4,
              Level = 1,
              Impenetrable = false
            }
          },
          Type = 104,
          Timeout = 2.0,
          TimeoutKey = "xrWJnDnR"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 10560201,
      NoPassCameraIsNewConfig = true,
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
                Id = 10510614,
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
        },
        {

          ContainerName = "Level",
          Names = {
            "L19"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L2"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          GroupId = 10560201,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 10560202,
          Type = 27,
          Timeout = 0.0
        },
        {

          Key = "TheEnd",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StoryId = 5051104,
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

          ContainerName = "Level",
          Names = {
            "L19"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 3.0,
          TimeoutKey = "gbmSNvFS"
        },
        {

          GroupID = 5,
          Type = 86,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_chapter4_5_elite",
          Type = 76,
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

          Key = "TheEnd",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Group = 10510614,
          Type = 65,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "TheEnd",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "C1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 10560202,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
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

          StoryId = 5051105,
          Actions = {
            {

              PosKey = "N1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              StoryId = 4051102,
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
        },
        {

          StoryId = 4051102,
          Actions = {
            {

              TaskId = 105604,
              Type = 5,
              Timeout = 0.5,
              TimeoutKey = "EXwrEvEb"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 1.0,
              TimeoutKey = "RnbqfREe"
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 1.0,
              TimeoutKey = "WNHTjgTO"
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 1.5,
              TimeoutKey = "YqUnLxCM"
            },
            {

              GroupID = 5,
              Type = 87,
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

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
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
    MonsterCount = 1,
    MonsterInfo = {
      [ 300100503 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}