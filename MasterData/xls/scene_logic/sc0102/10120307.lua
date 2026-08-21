local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "NPC1",
          Rotation = 0,
          NPCId = 101110,
          Type = 0,
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

          ObjName = "scene_fx5",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "scene_fx5",
      IsNotCondition = true,
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

          ObjName = "scene_fx5",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "scene_fx5",
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

          TimelineName = "FX_mark1_3_4_prefab",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/Plat3_/Axis/GameObject",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "scene_fx7",
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          PlatName = "plat3",
          IsMove = true,
          Anim = "3up 1",
          IsAutoSave = false,
          Type = 18,
          Timeout = 0.0
        },
        {

          PosKey = "NPC1",
          Rotation = 0,
          NPCId = 101110,
          Type = 0,
          Timeout = 0.0
        },
        {

          Key = "is_int",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Type = 71,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "is_int",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "door1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              AreaName = "door1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "tips1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              ObjName = "scene_fx5",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "scene_fx5",
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

          Key = "monster1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PlayBgm = "bgm_modern_elite",
              Type = 76,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 7,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10130701,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10130702,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "1",
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

              AreaName = "monster1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            },
            {

              Type = 35,
              Timeout = 0.0
            },
            {

              ObjName = "scene_fx7",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "scene_fx5",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "is_authorized",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "tips1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TipsId = 100168,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        },
        {

          Key = "camera3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 105,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              AreaName = "camera3",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              Type = 34,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 122,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "VHSxxQxJ"
            },
            {

              ObjName = "/Root/LevelObj/Plat3_/Axis/GameObject",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
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

          NPCId = 101110,
          Actions = {
            {

              TipsId = 100156,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            },
            {

              PosKey = "NPC1",
              Rotation = 0,
              NPCId = 101110,
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "lSCjfylZ"
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "is_authorized",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101110,
          Actions = {
            {

              PlatName = "plat3",
              IsMove = true,
              Anim = "3up",
              IsAutoSave = false,
              Type = 18,
              Timeout = 0.0
            },
            {

              StoryId = 201317,
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
              Timeout = 3.0,
              TimeoutKey = "1"
            },
            {

              Key = "is_int",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Camera = 121,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              ObjName = "LevelObj/Plat3_/Axis/GameObject",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              KeyName = "tp3",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "is_authorized",
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

      EventName = "1",
      Actions = {
        {

          Type = 34,
          Timeout = 0.0
        },
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          StoryId = 201311,
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
          Timeout = 1.5,
          TimeoutKey = "TuhoPPIy"
        },
        {

          TimelineName = "timeline1_3henji",
          Fadein = 1.0,
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
          IsWhite = false,
          Type = 6,
          Timeout = 1.0,
          TimeoutKey = "2"
        },
        {

          ObjName = "scene_fx7",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_modern_common",
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

      EventName = "电梯启动",
      Actions = {
        {

          TipsId = 100156,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "is_authorized",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "电梯启动",
      Actions = {
        {

          PlatName = "plat3",
          IsMove = true,
          Anim = "3up",
          IsAutoSave = false,
          Type = 18,
          Timeout = 0.0
        },
        {

          StoryId = 201317,
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
          Timeout = 3.0,
          TimeoutKey = "pubXxKAP"
        },
        {

          Key = "is_int",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Camera = 121,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/Plat3_/Axis/GameObject",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          KeyName = "tp3",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          NPCName = "电梯开关",
          Type = 93,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "is_authorized",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          TimelineName = "FX_mark1_3_4_prefab",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = {
    [ 5 ] = {
      Name = "进入房间"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 7,
    MonsterInfo = {
      [ 20101301 ] = 1,
      [ 20101401 ] = 2,
      [ 20102901 ] = 1,
      [ 20101101 ] = 1,
      [ 20104001 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}