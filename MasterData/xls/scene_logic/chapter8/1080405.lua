local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "vigilador",
          Rotation = 180,
          NPCId = 10804101,
          NPCName = "监视者",
          Type = 0,
          Timeout = 0.0
        },
        {

          GroupId = 10804502,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 10804503,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 10804504,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 10804505,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "npc1",
          Rotation = 60,
          NPCId = 10804502,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "npc4",
          Rotation = 180,
          NPCId = 10804505,
          NPCName = "4",
          Type = 0,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10804/1080405",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10804/1080404",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      NoPassCamera = 1,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = true,
      PassCamera = 1,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
      Actions = {
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

          PosKey = "vigiladorCmr",
          IsOpen = true,
          CameraStyle = 0,
          Duration = 0.0,
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

          StoryId = 4080606,
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
          Timeout = 0.5,
          TimeoutKey = "lonFqoEj"
        },
        {

          ObjName = "/Root/Level/10804/1080403",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1080410401,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_01/Transparent",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1080401,
          Level = 1,
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

          Key = "vigilancia",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Target = "Hero",
              MagicId = 1080410302,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410101,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410901,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "XFcuoaRN"
            },
            {

              Target = "Hero",
              MagicId = 1080410301,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "lEiQcgOe"
            }
          },
          ValidInTower = false
        },
        {

          Key = "vigilancia",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405/Fx_ceshifang",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Level/10804/1080405/Fx_ceshifang (1)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "safeArea1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405/Fx_ceshifang",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "safeArea2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405/Fx_ceshifang (1)",
              Visible = true,
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

          Key = "vigilancia",
          Actions = {
            {

              Target = "Hero",
              MagicId = 1080410901,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410301,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410302,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410201,
              Type = 103,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 1080410202,
              Type = 103,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4080606,
          StepId = 2,
          Actions = {
            {

              PosKey = "tp4",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 1,
              OTSDuration = -1.0,
              Type = 62,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080606,
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

          StoryId = 4080606,
          Actions = {
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.0
            },
            {

              KeyName = "tp4",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              Key = "finishStory",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080606,
          Actions = {
            {

              Camera = 1,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
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

      EventName = "found",
      Actions = {
        {

          Key = "gameOver",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1080410901,
          Type = 103,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1080410301,
          Type = 103,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 1080410302,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_10804_vigilador3",
          Fadein = 1.0,
          Fadeout = 0.0,
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

          NPCId = 10804101,
          NPCName = "监视者",
          Type = 1,
          Timeout = 0.0
        },
        {

          StoryId = 4080613,
          EnableBlackFade = true,
          DelayDestroy = false,
          PlayFadeInTime = 0.0,
          PlayStayTime = 0.0,
          PlayFadeOutTime = 0.0,
          StopFadeInTime = 0.3,
          StopStayTime = 1.0,
          StopFadeOutTime = 0.3,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 1.0,
          TimeoutKey = "TKHkfHQJ"
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

          StoryId = 4080613,
          Actions = {
            {

              NPC = "Hero",
              Point = "bornpoint",
              Rotate = -90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.5,
              TimeoutKey = "aazMylKf"
            },
            {

              Target = "Hero",
              MagicId = 1080410201,
              Type = 103,
              Timeout = 0.5,
              TimeoutKey = "YVYeyWPl"
            },
            {

              Target = "Hero",
              MagicId = 1080410202,
              Type = 103,
              Timeout = 0.5,
              TimeoutKey = "vNyXPqjO"
            },
            {

              Target = "Hero",
              MagicId = 1080410302,
              Type = 103,
              Timeout = 0.6,
              TimeoutKey = "zzUeEdyr"
            },
            {

              TimelineName = "timeline_10804_vigilador3",
              Type = 7,
              Timeout = 0.5,
              TimeoutKey = "HPJPGYFp"
            },
            {

              PosKey = "vigilador",
              Rotation = 180,
              NPCId = 10804101,
              NPCName = "监视者",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "wxqtzkrd"
            },
            {

              Key = "gameOver",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 1.1,
              TimeoutKey = "otXOTDfl"
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

      EventName = "cantHear",
      Actions = {
        {

          Type = 46,
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

          TaskId = 1080407,
          Type = 5,
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

      EventName = "Nixon",
      Actions = {
        {

          PosKey = "P3",
          Rotation = 0,
          NPCId = 10804501,
          NPCName = "偷听用",
          Type = 0,
          Timeout = 0.0
        },
        {

          NPCId = 10804501,
          NPCName = "偷听用",
          Type = 1,
          Timeout = 45.0,
          TimeoutKey = "biYshmtq"
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

          NPCId = 10804501,
          Actions = {
            {

              StoryId = 905080607,
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
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 905080605,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP1/Voice_sc08qianxingrenqun",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080606,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP2/Voice_sc08qianxingrenqun",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080607,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP3/Voice_sc08qianxingrenqun",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080608,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP4/Voice_sc08qianxingrenqun",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080609,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP5/Voice_sc08qianxingrenqun",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080610,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP6/Voice_sc08qianxingrenqun",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080611,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundF2/Voice_sc08qianxingrenqun",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
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

          StoryId = 905080605,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP1/Voice_sc08qianxingrenqun",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080606,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP2/Voice_sc08qianxingrenqun",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080607,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP3/Voice_sc08qianxingrenqun",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080608,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP4/Voice_sc08qianxingrenqun",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080609,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP5/Voice_sc08qianxingrenqun",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080610,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundP6/Voice_sc08qianxingrenqun",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 905080611,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080405SoundEffect/soundF2/Voice_sc08qianxingrenqun",
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
      Type = 5,
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