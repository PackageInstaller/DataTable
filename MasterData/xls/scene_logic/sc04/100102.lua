local empty = {}
return
{
  Events = {
    {

      EventName = "OldFirstBegin",
      Actions = {
        {

          TimelineName = "timeline0_2down",
          Type = 7,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline0_2_drop",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = false,
          NotPauseLua = true,
          IsCloseTransparent = false,
          BlackIn = 0.5,
          Hold = 1.0,
          BlackOut = 0.5,
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

          Target = "Hero",
          Type = 37,
          Timeout = 0.0
        },
        {

          StoryId = 1000004,
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
          Timeout = 8.6,
          TimeoutKey = "KMIIjEso"
        },
        {

          Type = 61,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 10001013,
          Type = 103,
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

      NoPassCamera = 102,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 102,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          CustomEventName = "OldFirstBegin",
          Type = 19,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/Fx_Yunwu (1)",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 1000101,
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

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 403210033,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill2",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 10001015,
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

          StoryId = 1000004,
          Actions = {
            {

              TimelineName = "timeline0_2_drop",
              Type = 7,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              Type = 38,
              Timeout = 1.0,
              TimeoutKey = "WvxSlNpY"
            },
            {

              CustomEventName = "UIclose",
              Type = 19,
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

      ConditionActions = {
        {

          GroupId = 100002,
          Actions = {
            {

              Target = "Hero",
              MagicId = 100010110,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "hYRlWPFV"
            },
            {

              Type = 60,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 11,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 4100101,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 1,
                    Id = 4100102,
                    param = 2,
                    Name = "剩余",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 4100103,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "1",
                    Timeout = 0.0,
                    TimeoutKey = "",
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

              CustomEventName = "UIopen",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          GroupId = 100003,
          Actions = {
            {

              Target = "Hero",
              MagicId = 10001006,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "ETEVkNEm"
            },
            {

              Target = "Hero",
              MagicId = 100010105,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "WvIODHUU"
            },
            {

              Target = "Hero",
              MagicId = 1011339,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "UknOTKbi"
            },
            {

              Target = "Hero",
              MagicId = 1015799,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "nqllSCcz"
            },
            {

              Target = "Hero",
              MagicId = 10001015,
              Type = 103,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 8,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "video",
      Actions = {
        {

          Target = "Hero",
          Type = 37,
          Timeout = 1.6,
          TimeoutKey = "89741564"
        },
        {

          TimelineName = "TIMELINE0_1_3_0",
          Fadein = 0.0,
          Fadeout = 0.0,
          IsCanSkip = true,
          NotPauseLua = true,
          IsCloseTransparent = false,
          BlackIn = 0.3,
          Hold = 0.5,
          BlackOut = 0.3,
          IsShowUI = false,
          DelayDestroy = true,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 1.5,
          TimeoutKey = "TIMELINE0_1_3_0"
        },
        {

          ChangeTime = 1.0,
          Type = 75,
          Timeout = 0.0
        },
        {

          StoryId = 1000005,
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
          TimeoutKey = "1000005"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "1",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 6,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4100105,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "video",
                Timeout = 1.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 1.0,
          TimeoutKey = "4100105"
        },
        {

          TimelineName = "timeline0_4_monster",
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
          Timeout = 1.0,
          TimeoutKey = "timeline0_4_monster"
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

          TimelineName = "timeline0_2_drop",
          Actions = {
            {

              GroupId = 100002,
              Type = 42,
              Timeout = 4.3,
              TimeoutKey = "CrJewSzU"
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "TIMELINE0_1_3_0",
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            },
            {

              Type = 46,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          TimelineName = "timeline0_4_monster",
          Actions = {
            {

              GroupId = 100003,
              Type = 42,
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

      Actions = {
        {

          GroupId = 100002,
          Type = 42,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 18,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "UIclose",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill8",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "UltInfo",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "TeamHeads",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "JoystickContent",
          IsShow = false,
          Type = 32,
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

      EventName = "UIopen",
      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill1",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill3",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "TeamHeads",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "JoystickContent",
          IsShow = true,
          Type = 32,
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
  FinishiConditionDict = empty,
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 17,
    MonsterInfo = {
      [ 2010150115 ] = 17
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}