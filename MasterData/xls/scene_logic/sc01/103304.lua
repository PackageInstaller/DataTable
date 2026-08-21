local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          PosKey = "NPC_book",
          Rotation = 0,
          NPCId = 103303,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC_book2",
          Rotation = 0,
          NPCId = 103304,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC_kongzhitai",
          Rotation = 0,
          NPCId = 101105,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC_kongzhitai2",
          Rotation = 0,
          NPCId = 101106,
          Type = 0,
          Timeout = 0.0
        },
        {

          CustomEventName = "close",
          Type = 19,
          Timeout = 0.0,
          TimeoutKey = "yHpFVXZj"
        },
        {

          KeyName = "NPC_book",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          ObjName = "FX_Sc0101_fuwen",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
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

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ResId = 10330101,
          PosKey = "bornpoint",
          OffsetX = 0.0,
          OffsetZ = 0.0,
          Rotation = 0,
          Camp = 4,
          Level = 999,
          NPCName = "1",
          AutoSave = false,
          Type = 2,
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

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          SkillLevel = 8,
          TowerValid = false,
          Type = 45,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj2/fx_henji4",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TreasureChestId = 10310,
          PosKey = "BOX1",
          Rotation = 180,
          IsPlayEffectAndSound = true,
          IsCanOpen = true,
          CustomEventName = "BOXEND10310",
          Type = 124,
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

          Key = "tips",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              CustomEventName = "save",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "1open",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "platdown2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PlatName = "plat2",
              IsMove = true,
              Anim = "c3p2_down 1",
              IsAutoSave = false,
              Type = 18,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0,
              TimeoutKey = "1"
            },
            {

              Type = 60,
              Timeout = 1.4,
              TimeoutKey = "2"
            }
          },
          ValidInTower = false
        },
        {

          Key = "platdown4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PlatName = "plat4",
              IsMove = true,
              Anim = "c3p4_down",
              IsAutoSave = false,
              Type = 18,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0,
              TimeoutKey = "1"
            },
            {

              Type = 60,
              Timeout = 1.4,
              TimeoutKey = "2"
            }
          },
          ValidInTower = false
        },
        {

          Key = "tips",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TipsId = 100188,
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

          Key = "camera4",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 117,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "focus",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "focus1",
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
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 3.0,
              TimeoutKey = "1"
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

          Key = "book",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              StoryId = 2031306,
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

              PosKey = "NPC_book(Copy1)",
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
            },
            {

              BackToDefault = true,
              Type = 63,
              Timeout = 3.0,
              TimeoutKey = "VOAkPNZf"
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 213,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "timeline",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              TimelineName = "timeline3_3shujia3",
              Fadein = 1.5,
              Fadeout = 1.5,
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
              Timeout = 1.5,
              TimeoutKey = "1"
            },
            {

              StoryId = 2031307,
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
              TimeoutKey = "2"
            },
            {

              KeyName = "NPC_book2",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PlatName = "plat3",
              IsMove = true,
              Anim = "c3p3_loop",
              IsAutoSave = false,
              Type = 18,
              Timeout = 0.0
            },
            {

              PlatName = "plat5",
              IsMove = true,
              Anim = "c3p5_loop",
              IsAutoSave = false,
              Type = 18,
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

          Key = "fall",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              FadeIn = 0.0,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "fall1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              NPC = "Hero",
              Point = "fall1",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.2,
              TimeoutKey = "3"
            },
            {

              Type = 60,
              Timeout = 1.1,
              TimeoutKey = "2"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "is_save",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "fall",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              FadeIn = 0.0,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              NPC = "Hero",
              Point = "fall2",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              NPC = "Hero",
              Point = "fall2",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.2,
              TimeoutKey = "3"
            },
            {

              Type = 60,
              Timeout = 1.1,
              TimeoutKey = "2"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "is_save",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "fall",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "1open",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "fall",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "2open",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "all_down2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              PlatName = "plat7",
              IsMove = true,
              Anim = "c3_platgame2_down",
              IsAutoSave = false,
              Type = 18,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0,
              TimeoutKey = "1"
            },
            {

              Type = 60,
              Timeout = 1.4,
              TimeoutKey = "2"
            },
            {

              ObjName = "/Root/LevelObj2/Plat2_/Axis (1)/",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/LevelObj2/Plat2_/Axis (1)/",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.4,
              TimeoutKey = "nSmWmzVP"
            },
            {

              CustomEventName = "fall_timer",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "2open",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "all_down1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Type = 61,
              Timeout = 0.0,
              TimeoutKey = "1"
            },
            {

              PlatName = "plat6",
              IsMove = true,
              Anim = "c3_platgame1_down",
              IsAutoSave = false,
              Type = 18,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 1.4,
              TimeoutKey = "2"
            },
            {

              CustomEventName = "fall_timer",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "1open",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "camera",
          Actions = {
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "tips",
          Actions = {
            {

              TipsId = 100188,
              Visible = false,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "camera4",
          Actions = {
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
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

          StoryId = 1031304,
          Actions = {
            {

              TaskId = 103304,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 1031305,
          Actions = {
            {

              TaskId = 103305,
              Type = 5,
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

          NPCId = 101105,
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

              CustomEventName = "1open",
              Type = 19,
              Timeout = 1.5,
              TimeoutKey = "KagZADta"
            },
            {

              CustomEventName = "2open",
              Type = 19,
              Timeout = 1.5,
              TimeoutKey = "VGZNYRkS"
            },
            {

              NPCId = 101105,
              Type = 1,
              Timeout = 1.5,
              TimeoutKey = "miXMZRAl"
            },
            {

              NPCId = 101106,
              Type = 1,
              Timeout = 1.5,
              TimeoutKey = "vqMyalsO"
            }
          },
          FinishMarkVariable = "",
          ValidInTower = true
        },
        {

          NPCId = 101106,
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

              CustomEventName = "2open",
              Type = 19,
              Timeout = 1.5,
              TimeoutKey = "frjddRIH"
            },
            {

              CustomEventName = "1open",
              Type = 19,
              Timeout = 1.5,
              TimeoutKey = "rcSOWrkW"
            },
            {

              NPCId = 101105,
              Type = 1,
              Timeout = 1.5,
              TimeoutKey = "HNlrUwEE"
            },
            {

              NPCId = 101106,
              Type = 1,
              Timeout = 1.5,
              TimeoutKey = "CKatBfes"
            }
          },
          FinishMarkVariable = "",
          ValidInTower = true
        },
        {

          NPCId = 103303,
          Actions = {
            {

              Key = "BOOK_off",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              Point = "tp1",
              Type = 3,
              Timeout = 0.0,
              TimeoutKey = ""
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
                WallObjPath = "",
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10330305,
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
              Timeout = 2.0,
              TimeoutKey = "dsfaewsf"
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
                WallObjPath = "",
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10330304,
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
              Timeout = 2.0,
              TimeoutKey = "sdaasderf"
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
                WallObjPath = "",
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10330303,
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
              Timeout = 2.0,
              TimeoutKey = "dfvwedf"
            },
            {

              ObjName = "scene_timeline_shujia2",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              Key = "BOOK_on",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 4.0,
              TimeoutKey = "ArkOAHEu"
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 103304,
          Actions = {
            {

              StoryId = 1031305,
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
              TimeoutKey = "CVqOofGe"
            },
            {

              Point = "tp1",
              Type = 3,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Type = 12,
              Timeout = 0.0
            },
            {

              ObjName = "scene_timeline_shujia3",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Type = 71,
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

          StoryId = 1031304,
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
          TimeoutKey = "OMdYLaMV"
        },
        {

          ObjName = "FX_Sc0101_fuwen (1)",
          IsAutoSave = true,
          Type = 53,
          Timeout = 0.0
        },
        {

          ObjName = "FX_Sc0101_fuwen",
          IsAutoSave = true,
          Type = 53,
          Timeout = 0.0
        },
        {

          Camera = 111,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 87,
          Timeout = 0.0
        },
        {

          Type = 22,
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

      EventName = "1open",
      Actions = {
        {

          ObjName = "LevelObj2/PlatGame1",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/Plat3_/Axis (1)",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/Plat5_/Axis (1)",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline3_3pingtai",
          Fadein = 2.0,
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

          ObjName = "/Root/LevelObj2/Plat6_",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj2/Plat6_/Cube",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "1open",
      ValidInTower = true,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "2open",
      Actions = {
        {

          ObjName = "LevelObj2/PlatGame2",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/Plat3_/Axis (2)",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/Plat5_/Axis (2)",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj2/Plat7_",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj2/Plat7_/Cube",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "2open",
      ValidInTower = true,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "close",
      Actions = {
        {

          ObjName = "LevelObj2/PlatGame2",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/PlatGame1",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/Plat3_/Axis (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/Plat3_/Axis (2)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/Plat5_/Axis (1)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj2/Plat5_/Axis (2)",
          Visible = false,
          IsAutoSave = true,
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

      EventName = "save",
      Actions = empty,
      FinishMarkVariable = "is_save",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "2open",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "fall_timer",
      Actions = {
        {

          FadeIn = 0.0,
          Hold = 0.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.4,
          TimeoutKey = "TbOmiXLI"
        },
        {

          NPC = "Hero",
          Point = "fall1",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.4,
          TimeoutKey = "mLYHtWUJ"
        },
        {

          NPC = "Hero",
          Point = "fall1",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.6,
          TimeoutKey = "3"
        },
        {

          Type = 60,
          Timeout = 1.5,
          TimeoutKey = "2"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "提示未开启1",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "1open",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "提示未开启2",
      Actions = empty,
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "2open",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "BOXEND10310",
      Actions = {
        {

          Variable = "10310",
          Type = 128,
          Timeout = 0.0
        },
        {

          CustomEventName = "GBOX10310CLOSE",
          Type = 19,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "GBOX10310CLOSE",
      Actions = {
        {

          ObjName = "/Root/LevelObj2/BoxGuideFx/Fx_Common_BoxGuide10310",
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

      EventName = "GBOX10310OPEN",
      Actions = {
        {

          ObjName = "/Root/LevelObj2/BoxGuideFx/Fx_Common_BoxGuide10310",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "10310",
      IsNotCondition = true,
      IsForeverVariable = true
    },
    {

      Actions = {
        {

          ObjName = "/Root/LevelObj2/fx_henji4",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      ConditionActions = {
        {

          ConditionVariableList = {
            "1open",
            "2open"
          },
          Actions = {
            {

              TipsId = 10330401,
              Visible = false,
              Flip = false,
              Type = 15,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 31,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          CustomEventName = "GBOX10310OPEN",
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

          CustomEventName = "GBOX10310CLOSE",
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 3,
    MonsterCount = 6,
    MonsterInfo = {
      [ 20103001 ] = 2,
      [ 20101501 ] = 3,
      [ 20101101 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}