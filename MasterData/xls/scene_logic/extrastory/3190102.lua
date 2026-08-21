local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          Key = "wave1",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "wave2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "wave3",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "wave4",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "progress",
          SyncValType = 2,
          Value = false,
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

      NoPassCamera = 319010201,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 319010201,
      PassCameraIsNewConfig = true,
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

          ObjName = "/Root/Level1/Plat1_",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level1/Plat2_",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level1/Plat3_",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "TimeLine_juese_319010201",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          GroupId = 1906,
          Type = 27,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "M3",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.5,
          TimeoutKey = "iASgxLqw"
        },
        {

          StoryId = 2219132,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.0,
          PlayStayTime = 0.0,
          PlayFadeOutTime = 0.0,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.5,
          TimeoutKey = "LUZPlzGX"
        },
        {

          StoryId = 32019000,
          BarrageStyle = 2,
          Alpha = 0.0,
          Speed = 200,
          Type = 113,
          Timeout = 0.0
        },
        {

          CustomEventName = "关闭战斗UI",
          Type = 19,
          Timeout = 0.0
        },
        {

          Camera = 319010201,
          IsNewConfig = true,
          IsForceDepressCameraMode = true,
          Type = 11,
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

          StoryId = 2219132,
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

              Target = "God",
              MagicId = 3190001,
              Level = 1,
              Type = 16,
              Timeout = 1.25,
              TimeoutKey = "VIFqDpLI"
            },
            {

              Enable = true,
              Type = 17,
              Timeout = 1.0,
              TimeoutKey = "qoSvxISP"
            },
            {

              Camera = 319,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "SIOjfpWZ"
            },
            {

              NPC = "Hero",
              Point = "M1",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.75,
              TimeoutKey = "ysUfGRRa"
            },
            {

              GroupId = 31901,
              Type = 42,
              Timeout = 2.0,
              TimeoutKey = "gVAnggLh"
            },
            {

              StoryId = 32019201,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 0.0
            },
            {

              TaskId = 3190102,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219133,
          Actions = {
            {

              TimelineName = "TimeLine_juese_319010203",
              IsPlay = true,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "iLHcRSJe"
            },
            {

              StoryId = 2219134,
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
              Timeout = 4.0,
              TimeoutKey = "QJxDLwGu"
            },
            {

              NPC = "Hero",
              Point = "M2",
              Rotate = -90.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.75,
              TimeoutKey = "lypTSRxY"
            },
            {

              PosKey = "N1",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 0.0,
              StopLuaScript = true,
              BackToDefault = true,
              HideUI = true,
              HasOTSConfig = false,
              OTSCameraStyle = 0,
              OTSDuration = 0.0,
              Type = 62,
              Timeout = 1.0,
              TimeoutKey = "KeaaRzHC"
            },
            {

              Group = 1906,
              Type = 65,
              Timeout = 1.0,
              TimeoutKey = "MiVtNVQi"
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

              CustomEventName = "关闭战斗UI",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219134,
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

              TimelineName = "TimeLine_juese_319010203",
              IsPlay = false,
              Type = 110,
              Timeout = 1.25,
              TimeoutKey = "MBMsQKQR"
            },
            {

              TimelineName = "TimeLine_juese_319010204",
              IsPlay = true,
              Type = 110,
              Timeout = 1.25,
              TimeoutKey = "hvkPphoe"
            },
            {

              StoryId = 2219135,
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
              Timeout = 4.5,
              TimeoutKey = "VeGzpDRy"
            },
            {

              StoryId = 32019203,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 1.0,
              TimeoutKey = "ErIBMKur"
            },
            {

              CustomEventName = "关闭战斗UI",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219135,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.5,
              TimeoutKey = "oXDUqyFc"
            },
            {

              TimelineName = "TimeLine_juese_319010204",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "zilQNiqe"
            },
            {

              TimelineName = "TimeLine_juese_319010205",
              IsPlay = true,
              Type = 110,
              Timeout = 1.4,
              TimeoutKey = "MJyzzDqj"
            },
            {

              StoryId = 2219136,
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
              TimeoutKey = "OSBALwXL"
            },
            {

              TimelineName = "TimeLine_juese_319010202",
              IsPlay = true,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "ooPqEKZO"
            },
            {

              TimelineName = "TimeLine_juese_319010201",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "jjPxbrkl"
            },
            {

              StoryId = 32019204,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
              Timeout = 1.0,
              TimeoutKey = "eYdDegcs"
            },
            {

              CustomEventName = "关闭战斗UI",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2219136,
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

              NPC = "Hero",
              Point = "tp2",
              Rotate = 180.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 1.25,
              TimeoutKey = "LkUNEFWo"
            },
            {

              Target = "God",
              MagicId = 3190001,
              Level = 1,
              Type = 16,
              Timeout = 1.25,
              TimeoutKey = "yyteitMd"
            },
            {

              Enable = true,
              Type = 17,
              Timeout = 1.0,
              TimeoutKey = "tmYMYLGI"
            },
            {

              Camera = 319,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "UJZOoLrq"
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 0.75,
              TimeoutKey = "zKiIXJeZ"
            },
            {

              TimelineName = "TimeLine_juese_319010202",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "JKtCElxU"
            },
            {

              GroupId = 1907,
              Type = 27,
              Timeout = 1.0,
              TimeoutKey = "uHPyxtCf"
            },
            {

              TimelineName = "TimeLine_juese_319010205",
              IsPlay = false,
              Type = 110,
              Timeout = 0.75,
              TimeoutKey = "yLkoXuJr"
            },
            {

              Key = "bb_switch",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              StoryId = 3219111,
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
              TimeoutKey = "WtaHuVDH"
            },
            {

              StyleIndex = 2,
              InitValue = 40,
              UpInterval = 1,
              UpSpeed = 0,
              CurrRoomFinalValue = 100,
              AllRoomFinalValue = 100,
              IsNeedAnimation = true,
              Type = 101,
              Timeout = 2.0,
              TimeoutKey = "fdPEHcDp"
            },
            {

              Key = "progress",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              TimelineName = "TimeLine_juese_319010206",
              IsPlay = true,
              Type = 110,
              Timeout = 0.75,
              TimeoutKey = "gAsyhzcg"
            },
            {

              TaskId = 3190104,
              Type = 5,
              Timeout = 0.0
            },
            {

              CustomEventName = "关闭战斗UI",
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

      Actions = {
        {

          Enable = false,
          Type = 17,
          Timeout = 0.0,
          TimeoutKey = ""
        },
        {

          Target = "God",
          MagicId = 3190002,
          Level = 1,
          Type = 16,
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

          GroupId = 31901,
          Actions = {
            {

              CustomEventName = "td_guide",
              Type = 122,
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

      EventName = "1w",
      Actions = {
        {

          Key = "wave1",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "wave2",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 3190002,
          Level = 1,
          Type = 16,
          Timeout = 1.0,
          TimeoutKey = "OJtfmXhY"
        },
        {

          Enable = false,
          Type = 17,
          Timeout = 1.0,
          TimeoutKey = "vIsefDLx"
        },
        {

          StoryId = 2219133,
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

          Camera = 319010201,
          IsNewConfig = true,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          TaskId = 3190103,
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

      EventName = "2w",
      Actions = {
        {

          Key = "wave2",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "wave3",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
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

          Group = 1907,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "ZTnKbKuf"
        },
        {

          GroupId = 1908,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "eFLDWUrL"
        },
        {

          ObjName = "/Root/Scene/Zone_01/sc05_area_01_pre/sc05_cpn_01_ground_01_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Key = "bb_switch",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StoryId = 3219112,
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
          TimeoutKey = "vtohhCFZ"
        },
        {

          PlatPath = "plat2",
          Speed = 1.0,
          AnimName = "319RLR",
          IsMove = true,
          Type = 112,
          Timeout = 2.0,
          TimeoutKey = "AGWxtlRb"
        },
        {

          PlatPath = "plat1",
          Speed = 1.0,
          AnimName = "319LRL",
          IsMove = true,
          Type = 112,
          Timeout = 2.0,
          TimeoutKey = "dgQfLaCd"
        },
        {

          PlatPath = "plat3",
          Speed = 1.0,
          AnimName = "319LRL",
          IsMove = true,
          Type = 112,
          Timeout = 2.0,
          TimeoutKey = "gEbJrZSJ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "3w",
      Actions = {
        {

          Key = "wave3",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "wave4",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
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

          Group = 1908,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "lAgOQCmf"
        },
        {

          GroupId = 1904,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "QgKrEtiJ"
        },
        {

          Key = "bb_switch",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StoryId = 3219113,
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
          TimeoutKey = "CDjsUIwZ"
        },
        {

          PlatPath = "plat1",
          Speed = 0.0,
          AnimName = "319LRL",
          IsMove = false,
          Type = 112,
          Timeout = 0.0
        },
        {

          PlatPath = "plat2",
          Speed = 0.0,
          AnimName = "319RLR",
          IsMove = false,
          Type = 112,
          Timeout = 0.0
        },
        {

          PlatPath = "plat3",
          Speed = 0.0,
          AnimName = "319LRL",
          IsMove = false,
          Type = 112,
          Timeout = 0.0
        },
        {

          PlatPath = "plat1",
          Speed = 1.0,
          AnimName = "319LRL",
          IsMove = true,
          Type = 112,
          Timeout = 2.0,
          TimeoutKey = "HAEFEttj"
        },
        {

          PlatPath = "plat2",
          Speed = 1.0,
          AnimName = "319RLR",
          IsMove = true,
          Type = 112,
          Timeout = 2.0,
          TimeoutKey = "XDbruWMI"
        },
        {

          PlatPath = "plat3",
          Speed = 1.0,
          AnimName = "319LRL",
          IsMove = true,
          Type = 112,
          Timeout = 2.0,
          TimeoutKey = "auvuseoA"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "4w",
      Actions = {
        {

          Key = "wave4",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          TaskId = 3190105,
          Type = 5,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
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

      EventName = "td_guide",
      Actions = {
        {

          GuideId = 319001,
          Type = 41,
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

      EventName = "关闭战斗UI",
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
          ObjectName = "JoystickContent",
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

          StoryId = 2219134,
          StepId = 0,
          Actions = {
            {

              StoryId = 32019202,
              BarrageStyle = 1,
              Alpha = 1.0,
              Speed = 200,
              Type = 113,
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

          ConditionVariableList = {
            0,
            0,
            0
          },
          Key = "W1",
          IsEveryStepCheck = true,
          SuccessEvent = "1w",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0,
            0,
            0,
            0,
            0
          },
          Key = "W2",
          IsEveryStepCheck = true,
          SuccessEvent = "2w",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0,
            0,
            0
          },
          Key = "W3",
          IsEveryStepCheck = true,
          SuccessEvent = "3w",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        },
        {

          ConditionVariableList = {
            0,
            0,
            0,
            0,
            0,
            0
          },
          Key = "W4",
          IsEveryStepCheck = true,
          SuccessEvent = "4w",
          FailEvent = "",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 33,
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