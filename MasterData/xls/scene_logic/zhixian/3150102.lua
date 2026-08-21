local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "Level/zhixian315/timeline/timeline_315010104",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/timeline/timeline_315010206",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/timeline/timeline_315010206",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.5,
          TimeoutKey = "zuWhvdkr"
        },
        {

          ObjName = "Level/zhixian315/Plat/Plat31502_",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "yVFwVWCS"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 10403,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 10403,
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

          GroupId = 1502,
          Type = 27,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Section_02/Zone_02/sc03_02_anim_01 (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Section_02/Zone_02/sc03_02_anim_02 (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Section_02/Zone_02/sc03_prp_04a_pre (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/Section_02/Component/Plat999_",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc03_zone_02/Building/sc03_02_anim_06",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/sc03_02_anim_06 (1)",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/timeline/timeline_315010208",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0,
          TimeoutKey = "oNYdfMHk"
        },
        {

          ObjName = "Level/Section_02/Zone_02_1",
          Visible = true,
          IsAutoSave = true,
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

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Key = "skillDelay",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Path = "Level/Section_02/Zone_02/sc03_prp_04a_pre/switch_on",
          Rewind = 99999.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/Plat/Plat31503_",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/Plat/Plat31504_",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Level/zhixian315/Plat/Plat31505_",
          Visible = true,
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

          StoryId = 3215102,
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

          KeyName = "destination2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

          Target = "Hero",
          MagicId = 403231502,
          Level = 0,
          Type = 16,
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

          Key = "trapTrigger",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "timeline_315010203",
              Fadein = 1.0,
              Fadeout = 2.0,
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
              Timeout = 0.0
            },
            {

              Path = "Level/zhixian315/timeline/timeline_315010202",
              Plat = "Plat31503,Plat31504,Plat31505,",
              Rewind = 99999.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "Level/zhixian315/timeline/timeline_315010204",
              Plat = "Plat7",
              Rewind = 99999.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 1.75,
              TimeoutKey = "zmimRfmT"
            },
            {

              Camera = 31501,
              IsNewConfig = true,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 1.5,
              TimeoutKey = "HBQfikqd"
            },
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
                    Id = 15001,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "clear",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 10.0,
              TimeoutKey = "CzdJZHlf"
            },
            {

              Type = 71,
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

          Key = "plat0",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Path = "Level/zhixian315/timeline/timeline_315010202",
              Plat = "Plat31503,Plat31504,Plat31505,",
              Rewind = 99999.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "plat2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
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

          Key = "dest0",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear",
      Actions = {
        {

          Path = "Level/zhixian315/timeline/timeline_315010202",
          Plat = "Plat31503,Plat31504,Plat31505,",
          Rewind = 99999.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/zhixian315/timeline/timeline_315010204",
          Plat = "Plat7",
          Rewind = 99999.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Path = "Level/Section_02/Zone_02/sc03_prp_04a_pre/switch_on",
          Rewind = 99999.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          Camera = 10403,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 2.5,
          TimeoutKey = "KSQYkECw"
        },
        {

          ResId = 10210105,
          PosKey = "switch",
          Camp = 4,
          Rotation = 0,
          Level = 0,
          NPCName = "switch",
          Cd = 99999.0,
          IgnoreLock = false,
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Type = 55,
          Timeout = 0.5,
          TimeoutKey = "vEdYhYTk"
        },
        {

          PosKey = "focus_1",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 1.5,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 0.0
        },
        {

          Path = "Level/zhixian315/timeline/timeline_315010205",
          PlatCount = 1,
          PlatList = {
            "Plat7"
          },
          Type = 96,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 403231501,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 403231502,
          Level = 0,
          Type = 16,
          Timeout = 2.0,
          TimeoutKey = "kYSSdKGV"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "Plat7_over",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_315010203",
          Actions = {
            {

              StoryId = 3215103,
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
              Timeout = 5.0,
              TimeoutKey = "iAshGkpU"
            }
          },
          ValidInTower = false
        }
      },
      Type = 10,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCName = "switch",
          HitType = 0,
          Actions = {
            {

              NpcName = "switch",
              CanHit = true,
              Type = 77,
              Timeout = 0.0
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              Direction = 3,
              Type = 51,
              Timeout = 0.0
            },
            {

              Path = "Level/Section_02/Zone_02/sc03_prp_04a_pre/switch_on",
              Rewind = 99999.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              PosKey = "focus2_1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
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

              ObjName = "Level/zhixian315/timeline/timeline_315010209",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 19,
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
    MonsterCount = 3,
    MonsterInfo = {
      [ 20104201 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}