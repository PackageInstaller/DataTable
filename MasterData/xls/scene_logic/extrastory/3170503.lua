local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Key = "qian_dark",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TimelineName = "TimeLine_juese_317050301",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "TimeLine_317050301",
          Fadein = 1.0,
          Fadeout = 1.0,
          IsCanSkip = true,
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
        },
        {

          StoryId = 3217801,
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

          Key = "nightSwitch",
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

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 2,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 17016,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.1,
          TimeoutKey = "cRLMEVZB"
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 4,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 17017,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.1,
          TimeoutKey = "qaqGTMXx"
        },
        {

          ObjName = "/Root/Level/sc05_prp_60c_pre (18)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/sc05_prp_60c_pre (19)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/sc05_prp_60c_pre(3) (1)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ContainerName = "Level",
          Names = {
            "L13"
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
            "L14"
          },
          States = {
            "1"
          },
          SaveType = 0,
          Type = 97,
          Timeout = 0.0
        },
        {

          TimelineName = "TimeLine_scene_317050303",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          IsSkip = true,
          Type = 36,
          Timeout = 0.0
        },
        {

          GroupId = 1708,
          Type = 27,
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

              Target = "0_17017_0",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "0_17017_1",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "0_17017_2",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "0_17017_3",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "crystal_clear",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2217806,
          Actions = {
            {

              PosKey = "P1",
              Rotation = 0,
              NPCId = 301710,
              NPCName = "爆破",
              Type = 0,
              Timeout = 0.0
            },
            {

              CustomEventName = "爆破",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2217508,
          Actions = empty,
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

          StoryId = 100217802,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2217807,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 13,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 1,
                    Id = 17021,
                    param = 1,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 1,
                    Id = 17022,
                    param = 1,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 17023,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "qb3",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              TimelineName = "TimeLine_317050302",
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
              Timeout = 0.0
            },
            {

              Camera = 118,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "bGKWqQsl"
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

          NPCId = 301721,
          Actions = {
            {

              StoryId = 2217806,
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

      Actions = {
        {

          Direction = 2,
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

      EventName = "qb",
      Actions = {
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 301721,
          NPCName = "水晶清除",
          Type = 0,
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

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          StoryId = 2217807,
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
          TimeoutKey = "DcwdAgsn"
        },
        {

          NPC = "Hero",
          Point = "N1",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "RJeogwlb"
        },
        {

          TimelineName = "TimeLine_juese_317050301",
          IsPlay = false,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "esdgwsCE"
        },
        {

          TimelineName = "TimeLine_juese_317050302",
          IsPlay = true,
          Type = 110,
          Timeout = 1.0,
          TimeoutKey = "aUJGufEo"
        },
        {

          Key = "qian_dark",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          NPCId = 301724,
          NPCName = "专家",
          Type = 1,
          Timeout = 1.0,
          TimeoutKey = "GeoqaPlG"
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

          StoryId = 100217802,
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
          Timeout = 0.5,
          TimeoutKey = "TFLeMmxF"
        },
        {

          TaskId = 3170502,
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

      EventName = "爆破",
      Actions = {
        {

          TimelineName = "TimeLine_317050304",
          Fadein = 0.0,
          Fadeout = 1.0,
          IsCanSkip = false,
          NotPauseLua = false,
          IsCloseTransparent = true,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.5,
          BeforeHold = 1.0,
          BeforeBlackOut = 0.5,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          Key = "crystal_clear",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/sc05_prp_60c_pre (18)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 4.0,
          TimeoutKey = "TMLpAtko"
        },
        {

          ObjName = "/Root/Level/sc05_prp_60c_pre (19)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 4.0,
          TimeoutKey = "ETgVhPuu"
        },
        {

          NPCId = 301710,
          NPCName = "爆破",
          Type = 1,
          Timeout = 1.0,
          TimeoutKey = "fpEUaKWn"
        },
        {

          NPC = "Hero",
          Point = "P3",
          Rotate = -20.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "HgNnbdDZ"
        },
        {

          PosKey = "P2",
          Rotation = -30,
          NPCId = 301724,
          NPCName = "专家",
          Type = 0,
          Timeout = 5.0,
          TimeoutKey = "kgEIILiX"
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

          TimelineName = "TimeLine_317050304",
          Actions = {
            {

              PosKey = "P2",
              Rotation = -30,
              NPCId = 301724,
              NPCName = "专家",
              Type = 0,
              Timeout = 0.0
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

          TimelineName = "TimeLine_317050302",
          Actions = {
            {

              TimelineName = "TimeLine_juese_317050302",
              IsPlay = false,
              Type = 110,
              Timeout = 0.0
            },
            {

              Pos = 2,
              IsGoOut = true,
              Type = 78,
              Timeout = 0.0
            },
            {

              HeroId = 1001004,
              Type = 29,
              Timeout = 0.1,
              TimeoutKey = "UriItbUI"
            },
            {

              Target = "0_17021_0",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "0_17021_1",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "0_17021_2",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
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

          StoryId = 2217508,
          StepId = 0,
          Actions = empty,
          ValidInTower = false
        },
        {

          StoryId = 100217802,
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

          StoryId = 2217807,
          StepId = 0,
          Actions = {
            {

              Key = "qian_dark",
              SyncValType = 2,
              Value = false,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
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
    EventCount = 3,
    MonsterCount = 19,
    MonsterInfo = {
      [ 20204601 ] = 5,
      [ 20304402 ] = 2,
      [ 20204301 ] = 7,
      [ 20104501 ] = 3,
      [ 20204401 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}