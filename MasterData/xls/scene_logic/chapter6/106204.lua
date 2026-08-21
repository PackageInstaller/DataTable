local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          StoryId = 4060305,
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
          TimeoutKey = "WaaqXbjA"
        },
        {

          GroupId = 10620401,
          Type = 27,
          Timeout = 0.0
        },
        {

          Type = 61,
          Timeout = 0.0
        },
        {

          TaskGroupId = 1061,
          Type = 21,
          Timeout = 0.0
        },
        {

          Type = 71,
          Timeout = 0.1,
          TimeoutKey = "cXJjeTJu"
        },
        {

          GroupID = 1,
          Type = 86,
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

      NoPassCamera = 106000,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 106000,
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

          PosKey = "q6",
          IsOpen = true,
          CameraStyle = 0,
          Duration = 0.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
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

          Key = "trg3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 5060207,
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
              TimeoutKey = "CFRYJrHO"
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "hero",
              Rotate = -70.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.0,
              TimeoutKey = "uoTIvTWr"
            },
            {

              HeroId = 1001021,
              Type = 29,
              Timeout = 1.0,
              TimeoutKey = "ziCnsJjl"
            },
            {

              TimelineName = "timeline_10620401",
              Fadein = 0.0,
              Fadeout = 3.0,
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
              Timeout = 1.25,
              TimeoutKey = "VoPEZohk"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "clear",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4060305,
          Actions = {
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0,
              TimeoutKey = "umUkCZAY"
            },
            {

              Type = 60,
              Timeout = 0.5,
              TimeoutKey = "cLEdVqVI"
            },
            {

              GroupId = 1062,
              Type = 42,
              Timeout = 0.75,
              TimeoutKey = "hWFudTkM"
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
                    Id = 106204001,
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
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 5060206,
          Actions = {
            {

              PosKey = "f2",
              IsOpen = false,
              CameraStyle = 0,
              Duration = 3.0,
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

              Type = 60,
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

          NPCId = 10610201,
          Actions = {
            {

              StoryId = 4060203,
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
          FinishMarkVariable = "",
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

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        },
        {

          KeyName = "tp4",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
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

      ConditionActions = {
        {

          GroupId = 1062,
          Actions = {
            {

              Type = 60,
              Timeout = 0.0
            },
            {

              Enable = true,
              Type = 17,
              Timeout = 0.0
            },
            {

              SkillLevel = 1,
              TowerValid = false,
              Type = 45,
              Timeout = 0.0
            },
            {

              BackToDefault = false,
              Type = 63,
              Timeout = 0.0
            },
            {

              GuideId = 106001,
              Type = 41,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 8,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          PosKey = "npc3",
          Rotation = 180,
          NPCId = 10610201,
          NPCName = "社员1",
          Type = 0,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "clear",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOX10602",
      Actions = {
        {

          TreasureChestId = 10602,
          PosKey = "BOX1",
          Rotation = 180,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10602",
          Type = 124,
          Timeout = 0.5,
          TimeoutKey = "AbhPVLwp"
        },
        {

          PosKey = "BOX1",
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
          TimeoutKey = "aHIuyThU"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOXEND10602",
      Actions = {
        {

          Variable = "10602",
          Type = 128,
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

      EventName = "prebox10602",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10602",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_10620401",
          Actions = empty,
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

          GuideID = 106001,
          Actions = {
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              GuideId = 106002,
              Type = 41,
              Timeout = 1.0,
              TimeoutKey = "YhQcKyyx"
            },
            {

              Type = 60,
              Timeout = 1.0,
              TimeoutKey = "GtPzYpvT"
            }
          },
          ValidInTower = false
        },
        {

          GuideID = 106002,
          Actions = {
            {

              StoryId = 5060205,
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
              TimeoutKey = "HcJrVGRG"
            }
          },
          ValidInTower = false
        }
      },
      Type = 15,
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
      [ 20205001 ] = 3
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}