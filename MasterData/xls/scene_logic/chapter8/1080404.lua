local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          GroupId = 10804401,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 10804404,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 10804405,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "safe6",
          NPCName = "对话",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638767075718805281,
          IsRemove = true,
          CustomEventName = "call",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "vigilador",
          Rotation = 90,
          NPCId = 10804101,
          NPCName = "监视者",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "talk01",
          Rotation = 15,
          NPCId = 10804401,
          NPCName = "01",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "talk02",
          Rotation = 60,
          NPCId = 10804402,
          NPCName = "02",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "talk11",
          Rotation = 0,
          NPCId = 10804403,
          NPCName = "11",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "talk12",
          Rotation = 180,
          NPCId = 10804404,
          NPCName = "12",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "talk41",
          Rotation = -30,
          NPCId = 10804406,
          NPCName = "41",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "talk51",
          Rotation = 90,
          NPCId = 10804407,
          NPCName = "51",
          Type = 0,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10804/1080404",
          Visible = true,
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
      NoPassForceDepressCameraMode = false,
      PassCamera = 1,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
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

          Target = "Hero",
          MagicId = 1080410401,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_07/Transparent",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10804/block1",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10804/block2",
          Visible = true,
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

      EventName = "call",
      Actions = {
        {

          StoryId = 4080605,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = true,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.5,
          TimeoutKey = "HgVmZYcR"
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
              TimeoutKey = "fdxOTZAy"
            },
            {

              Target = "Hero",
              MagicId = 1080410301,
              Level = 0,
              Type = 16,
              Timeout = 0.1,
              TimeoutKey = "YZorvfCW"
            },
            {

              CustomEventName = "firstEnter",
              Type = 19,
              Timeout = 0.0,
              TimeoutKey = "lRKhmANi"
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

              ObjName = "/Root/Level/10804/1080404/Fx_ceshifang (1)",
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

      EventName = "firstEnter",
      Actions = {
        {

          TimelineName = "timeline_10804_2Begin",
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
          Timeout = 0.0
        },
        {

          StoryId = 4080604,
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
          Timeout = 0.0,
          TimeoutKey = "vsHilszy"
        }
      },
      FinishMarkVariable = "reminded",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "reminded",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4080604,
          Actions = {
            {

              TimelineName = "timeline_10804_2Begin",
              Type = 7,
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
        },
        {

          Key = "vigilancia",
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080404/Fx_ceshifang (1)",
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
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "changeNPC",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          NPCId = 10804401,
          NPCName = "01",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 10804406,
          NPCName = "41",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 10804402,
          NPCName = "02",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 10804403,
          NPCName = "11",
          Type = 1,
          Timeout = 0.0
        },
        {

          NPCId = 10804404,
          NPCName = "12",
          Type = 1,
          Timeout = 0.0
        },
        {

          PosKey = "talk31",
          Rotation = 45,
          NPCId = 10804401,
          NPCName = "31",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "talk32",
          Rotation = 0,
          NPCId = 10804212,
          NPCName = "32",
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "talk42",
          Rotation = -90,
          NPCId = 10804405,
          NPCName = "42",
          Type = 0,
          Timeout = 0.0
        },
        {

          CustomEventName = "PREBOX10801",
          Type = 19,
          Timeout = 0.0
        },
        {

          Group = 10804401,
          Type = 65,
          Timeout = 0.0
        },
        {

          GroupId = 10804402,
          Type = 27,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "talked",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4080605,
          StepId = 0,
          Actions = {
            {

              TimelineName = "timeline_10804_obra",
              Fadein = 2.0,
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

              CustomEventName = "changeNPC",
              Type = 19,
              Timeout = 0.5,
              TimeoutKey = "BDfOlRaG"
            },
            {

              PosKey = "talk21",
              Rotation = 180,
              NPCId = 10804506,
              NPCName = "21",
              Type = 0,
              Timeout = 0.0
            },
            {

              PosKey = "talk22",
              Rotation = 180,
              NPCId = 10804512,
              NPCName = "22",
              Type = 0,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 4080605,
          StepId = 2,
          Actions = {
            {

              TimelineName = "timeline_10804_obra",
              Type = 7,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_10804_obraE",
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

          StoryId = 4080605,
          Actions = {
            {

              Group = 10804405,
              Type = 65,
              Timeout = 0.0
            },
            {

              GroupId = 10804403,
              Type = 27,
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
              Timeout = 0.1,
              TimeoutKey = "AQTFClEh"
            },
            {

              TimelineName = "timeline_10804_obraE",
              Type = 7,
              Timeout = 0.0
            },
            {

              TaskId = 1080405,
              Type = 5,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "talked",
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

          TimelineName = "timeline_10804_vigilador2",
          Fadein = 1.0,
          Fadeout = 0.0,
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
          StopStayTime = 1.4,
          StopFadeOutTime = 0.3,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 1.0,
          TimeoutKey = "RGMQqdVv"
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

              TimelineName = "timeline_10804_vigilador1",
              Type = 7,
              Timeout = 0.5,
              TimeoutKey = "vNaIHrUx"
            },
            {

              Target = "Hero",
              MagicId = 1080410201,
              Type = 103,
              Timeout = 0.5,
              TimeoutKey = "cxNxcQVp"
            },
            {

              Target = "Hero",
              MagicId = 1080410202,
              Type = 103,
              Timeout = 0.5,
              TimeoutKey = "iRNaMnrN"
            },
            {

              Target = "Hero",
              MagicId = 1080410302,
              Type = 103,
              Timeout = 0.6,
              TimeoutKey = "OHPVhbxr"
            },
            {

              PosKey = "vigilador",
              Rotation = 90,
              NPCId = 10804101,
              NPCName = "监视者",
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "EYPkEzvy"
            },
            {

              CustomEventName = "reset1",
              Type = 19,
              Timeout = 0.0
            },
            {

              CustomEventName = "reset2",
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

      EventName = "reset1",
      Actions = {
        {

          Target = "Hero",
          MagicId = 1080410201,
          Type = 103,
          Timeout = 1.0,
          TimeoutKey = "hjqKlFLY"
        },
        {

          Target = "Hero",
          MagicId = 1080410202,
          Type = 103,
          Timeout = 1.0,
          TimeoutKey = "ydEvvKVI"
        },
        {

          NPC = "Hero",
          Point = "tp1",
          Rotate = 90.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.0,
          TimeoutKey = "OhXMBcVi"
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
          TimeoutKey = "wGcLgCAm"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "talked",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "reset2",
      Actions = {
        {

          Group = 10804402,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "Oibujgwt"
        },
        {

          Group = 10804403,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "AdBricqS"
        },
        {

          Group = 10804405,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "MhOlPdBq"
        },
        {

          GroupId = 10804405,
          Type = 27,
          Timeout = 1.1,
          TimeoutKey = "HAKmtZAp"
        },
        {

          Group = 10804404,
          Type = 65,
          Timeout = 1.0,
          TimeoutKey = "ALCaBBKv"
        },
        {

          GroupId = 10804404,
          Type = 27,
          Timeout = 1.1,
          TimeoutKey = "MpdLTudb"
        },
        {

          NPC = "Hero",
          Point = "bornpoint",
          Rotate = 120.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.1,
          TimeoutKey = "KnilnYpK"
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
          TimeoutKey = "lHFrJAiz"
        },
        {

          PosKey = "safe6",
          NPCName = "UqdNOxYM",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638766143301445100,
          IsRemove = true,
          CustomEventName = "call",
          Type = 92,
          Timeout = 1.2,
          TimeoutKey = "zhLCuUeI"
        },
        {

          Key = "finishStory",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "move_start",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "gameFail",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "gameFail",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.5,
          TimeoutKey = "zhbiRYje"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "talked",
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

      Actions = {
        {

          TaskId = 1080406,
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
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "BOXEND10801",
      Actions = {
        {

          Variable = "10801",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10801CLOSE",
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

      EventName = "GBOX10801CLOSE",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuide/Fx_Common_BoxGuide10801",
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

      EventName = "GBOX10801OPEN",
      Actions = {
        {

          ObjName = "/Root/Level/BoxGuide/Fx_Common_BoxGuide10801",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10801",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      EventName = "PREBOX10801",
      Actions = {
        {

          TreasureChestId = 10801,
          PosKey = "BOX",
          Rotation = 180,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10801",
          Type = 124,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10801",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      ConditionActions = {
        {

          NPCId = 10804501,
          Actions = {
            {

              StoryId = 905080604,
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

          StoryId = 905080602,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080404SoundEffect/soundP1/Voice_sc08qianxingrenqun",
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

          StoryId = 905080603,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080404SoundEffect/soundP2/Voice_sc08qianxingrenqun",
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

          StoryId = 905080604,
          StepId = 0,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080404SoundEffect/soundP3/Voice_sc08qianxingrenqun",
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

          StoryId = 905080602,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080404SoundEffect/soundP1/Voice_sc08qianxingrenqun",
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

          StoryId = 905080603,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080404SoundEffect/soundP2/Voice_sc08qianxingrenqun",
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

          StoryId = 905080604,
          Actions = {
            {

              ObjName = "/Root/Level/10804/1080404SoundEffect/soundP3/Voice_sc08qianxingrenqun",
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
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10801OPEN",
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

          CustomEventName = "GBOX10801CLOSE",
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}