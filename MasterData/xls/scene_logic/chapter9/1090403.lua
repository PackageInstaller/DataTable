local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 118,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 116,
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

          Key = "3001086Complete",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_AirWall1090403",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          CustomEventName = "PreBox10903",
          Type = 19,
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
          Value = 13.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0,
          TimeoutKey = "FOfwVrCO"
        },
        {

          GroupId = 1090403001,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "RLbpkLEh"
        },
        {

          GroupId = 1090403003,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "ASkJoeuP"
        },
        {

          GroupId = 1090403004,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 1090403006,
          Type = 27,
          Timeout = 0.0
        },
        {

          Key = "barrierLen",
          SyncValType = 1,
          Value = 10.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "OCRrguHT"
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
    },
    {

      Actions = {
        {

          Key = "3001086Complete",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = true,
          Type = 23,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 5,
            MonsterCount = 23,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 109040301,
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
                Id = 109040302,
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
                Id = 109040303,
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
                Id = 109040304,
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
                Id = 109040305,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 3.0,
          TimeoutKey = "TbCOhrhC"
        },
        {

          StoryId = 35010703,
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
          TimeoutKey = "jbScjqdc"
        },
        {

          PosKey = "FightFocus",
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
          Timeout = 3.0,
          TimeoutKey = "tgSzMdQM"
        },
        {

          Group = 1090403004,
          Type = 65,
          Timeout = 0.0,
          TimeoutKey = "szDGddZX"
        },
        {

          GroupId = 1090403005,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "oeYOCXgX"
        },
        {

          Camera = 210,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 2.0,
          TimeoutKey = "DfhndyGh"
        },
        {

          GroupId = 1090403002,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "fhKwsKPH"
        },
        {

          GroupId = 1090403008,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "JiBjzWmX"
        },
        {

          TipsId = 10904021,
          Visible = false,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "3001086Complete",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.5,
          TimeoutKey = "CGdVlkxs"
        },
        {

          StoryId = 35010704,
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
          Timeout = 1.0,
          TimeoutKey = "xNNbWBog"
        },
        {

          TimelineName = "Timeline_AirWall1090403",
          IsPlay = false,
          Type = 110,
          Timeout = 1.5,
          TimeoutKey = "BXOYFvMT"
        },
        {

          TaskId = 1090404,
          Type = 5,
          Timeout = 1.5,
          TimeoutKey = "KRJlWuOz"
        },
        {

          PosKey = "tp4",
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
          Timeout = 0.5,
          TimeoutKey = "sbHsHjDz"
        },
        {

          Group = 1090403003,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "DckKemZj"
        },
        {

          Group = 1090403001,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "EroktqRh"
        },
        {

          Group = 1090403002,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "yexyrlVr"
        },
        {

          Group = 1090403007,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "TVecesKx"
        },
        {

          Group = 1090403010,
          Type = 65,
          Timeout = 0.5,
          TimeoutKey = "icixbXSD"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb1",
      Actions = {
        {

          Group = 1090403005,
          Type = 65,
          Timeout = 0.0
        },
        {

          GroupId = 1090403007,
          Type = 27,
          Timeout = 0.5,
          TimeoutKey = "gVVzczYI"
        },
        {

          GroupId = 1090403009,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "OnZZplaT"
        },
        {

          Group = 1090403003,
          Type = 65,
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

      EventName = "qb2",
      Actions = {
        {

          GroupId = 1090403010,
          Type = 27,
          Timeout = 0.0
        },
        {

          Group = 1090403002,
          Type = 65,
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

      EventName = "qb3",
      Actions = {
        {

          Group = 1090403008,
          Type = 65,
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

      EventName = "qb4",
      Actions = {
        {

          Group = 1090403009,
          Type = 65,
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

          Key = "ENTER",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "Scene_Timeline_109040301",
              Fadein = 1.0,
              Fadeout = 2.0,
              IsCanSkip = true,
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

              StoryId = 35010702,
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

              TipsId = 10904021,
              Visible = true,
              Flip = false,
              Type = 15,
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

      EventName = "PreBox10903",
      Actions = {
        {

          TreasureChestId = 10903,
          PosKey = "BOX",
          Rotation = 220,
          IsPlayEffectAndSound = true,
          IsCanOpen = false,
          CustomEventName = "BoxEnd10903",
          Type = 124,
          Timeout = 0.0
        },
        {

          TimelineName = "Timeline_Box_10903",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10903",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BoxEnd10903",
      Actions = {
        {

          Variable = "10903",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10903CLOSE",
          Type = 19,
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

      EventName = "Box10903",
      Actions = {
        {

          TreasureChestId = 10903,
          IsCanOpen = true,
          Type = 125,
          Timeout = 0.0
        },
        {

          PosKey = "BOX",
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
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10903OPEN",
      Actions = {
        {

          ObjName = "/Root/Level_/BoxGuide/Fx_Common_BoxGuide10903",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10903",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10903CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level_/BoxGuide/Fx_Common_BoxGuide10903",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

          Key = "BOXFIGHT",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
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
                    Id = 109040306,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "Box10903",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
              Timeout = 1.0,
              TimeoutKey = "YWTMMMqM"
            },
            {

              PosKey = "BOX",
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

              TimelineName = "Timeline_Box_10903",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "anBNjluo"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "10903",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10903OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10903CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 40,
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
    EventCount = 2,
    MonsterCount = 24,
    MonsterInfo = {
      [ 20205601 ] = 2,
      [ 20105801 ] = 4,
      [ 20106201 ] = 8,
      [ 20105501 ] = 3,
      [ 20106101 ] = 3,
      [ 20106001 ] = 1,
      [ 20105901 ] = 1,
      [ 20205501 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}