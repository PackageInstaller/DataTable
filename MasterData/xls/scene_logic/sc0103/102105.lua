return
{
  Events = {
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

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 4,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10230101,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "",
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

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          SkillLevel = 4,
          TowerValid = false,
          Type = 45,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4032189,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "MG2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "A1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TimelineName = "timeline_n0214",
              Fadein = 3.0,
              Fadeout = 3.0,
              IsCanSkip = false,
              NotPauseLua = true,
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

              StoryId = 2020402,
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

              AreaName = "A1",
              RemoveForever = true,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "MG2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 1020402,
          Actions = {
            {

              Group = 10230105,
              Type = 65,
              Timeout = 1.5,
              TimeoutKey = "sda"
            },
            {

              FadeIn = 1.0,
              Hold = 1.5,
              FadeOut = 1.0,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              CustomEventName = "BOX",
              Type = 19,
              Timeout = 1.5,
              TimeoutKey = "rhnZHyta"
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

      ConditionActions = {
        {

          StoryId = 6020301,
          Actions = {
            {

              CustomEventName = "PREBOX10201",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "PREBOX10234",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "BOX10233",
              Type = 19,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
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

          Direction = 1,
          Type = 51,
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

      EventName = "Q1",
      Actions = {
        {

          StoryId = 1020402,
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
          Timeout = 2.0,
          TimeoutKey = "DWD"
        },
        {

          FadeIn = 1.0,
          Hold = 1.5,
          FadeOut = 1.0,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Group = 10230101,
          Type = 65,
          Timeout = 1.5,
          TimeoutKey = "SDASD"
        },
        {

          NPC = "Hero",
          Point = "M1",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.5,
          TimeoutKey = "GrGdytik"
        },
        {

          TaskId = 102103,
          Type = 5,
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
                Id = 10230105,
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
          Timeout = 1.0,
          TimeoutKey = "WEQWE"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOX10233",
      Actions = {
        {

          PosKey = "NPC1",
          Rotation = 0,
          NPCId = 102011,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10233",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BOXEND10233",
      Actions = {
        {

          Variable = "10233",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10234",
          Type = 19,
          Timeout = 0.1,
          TimeoutKey = "qHgaLBlr"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOX10234",
      Actions = {
        {

          PosKey = "NPC1",
          Rotation = 0,
          NPCId = 102012,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10234",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "BOXEND10234",
      Actions = {
        {

          Variable = "10234",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10201",
          Type = 19,
          Timeout = 0.1,
          TimeoutKey = "FlnKLdZQ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOXEND10201",
      Actions = {
        {

          Variable = "10201",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10201CLOSE",
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

      EventName = "BOX10201",
      Actions = {
        {

          PosKey = "NPC1",
          Rotation = 0,
          NPCId = 102013,
          NPCName = "1",
          Type = 0,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10201",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "PREBOX10234",
      Actions = {
        {

          CustomEventName = "BOX10234",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10233",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "PREBOX10201",
      Actions = {
        {

          CustomEventName = "BOX10201",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10234",
      IsNotCondition = false,
      IsForeverVariable = true
    },
    {

      EventName = "BOX",
      Actions = {
        {

          PosKey = "NPC1",
          Rotation = 180,
          NPCId = 102014,
          NPCName = "2",
          Type = 0,
          Timeout = 0.0
        },
        {

          CustomEventName = "BOX10233",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10234",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10201",
          Type = 19,
          Timeout = 0.0
        },
        {

          Key = "ShowBox",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Type = 134,
          Timeout = 0.1,
          TimeoutKey = "zLUeOKsu"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10201",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10201OPEN",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10201",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10201",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "GBOX10201CLOSE",
      Actions = {
        {

          ObjName = "/Root/LevelObj/BoxGuideFx/Fx_Common_BoxGuide10201",
          IsAutoSave = false,
          Type = 53,
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

          CustomEventName = "GBOX10201OPEN",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 39,
      ConditionVariable = "ShowBox",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10201CLOSE",
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
    MonsterWave = 1,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0,
    EndPerform = true,
    Conditions = {
      {
        RefreshCondition = 0,
        Id = 1021010,
        param = 0,
        Name = "全部杀死",
        CustomEventName = "Q1",
        Timeout = 0.0,
        AIGroupId = 0,
        AIGroup = 0,
        AIDiffcultyTag = 0
      }
    },
  },
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 1020402,
      Name = "剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 5,
    MonsterInfo = {
      [ 20103705 ] = 4,
      [ 20104103 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}