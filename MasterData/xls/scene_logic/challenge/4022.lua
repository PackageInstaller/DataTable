local empty = {}
return
{
  Events = {
    {

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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 6010999,
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
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_bright/Level1/guandao",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_bright/Level1/PGZZ/sc05_prp_62_pre0 (1)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Camera = 105040101,
          IsNewConfig = true,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          Intensity = 0.05,
          Type = 105,
          Timeout = 0.0
        },
        {

          Type = 60,
          Timeout = 0.0
        },
        {

          GroupId = 402201,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 402202,
          Type = 27,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 120,
          Timeout = 0.0
        },
        {

          Type = 48,
          Timeout = 0.0
        },
        {

          Target = "God",
          MagicId = 402101,
          Level = 0,
          Type = 16,
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

      NoPassCamera = 105040101,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 105040101,
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

          ObjName = "Change_/Change_bright/Level1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/grassrender_simple_grass01",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/grassrender_simple_ntr_14",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/grassrender_simple_ntr_15",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/grassrender_simple_ntr_16",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          PlayBgm = "bgm_chapter4_5_elite",
          Type = 76,
          Timeout = 0.0
        },
        {

          PlayBgm = "scene_sc03_SFX",
          ChangeTime = 0.0,
          Type = 82,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level_/105601Block",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 402103,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = true,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "RunOut",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0,
          TimeoutKey = "789525267985"
        },
        {

          CustomEventName = "关卡回档",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "RunOut",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K04",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          FinishMarkVariable = "K04",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K04",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K01",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Bridge/K01",
              PlatCount = 0,
              Type = 96,
              Timeout = 0.0
            },
            {

              StoryId = 5050902,
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

              Key = "K01",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K01",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K02",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K02",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "WIN",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
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
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "DEAD1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              CustomEventName = "关卡回档",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "DEAD2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              CustomEventName = "关卡回档",
              Type = 19,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "DEAD3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              CustomEventName = "关卡回档",
              Type = 19,
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

          Key = "K06",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Target = "Hero",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 0.5,
              TimeoutKey = "k61"
            },
            {

              Target = "Hero",
              MagicId = 10560103,
              Level = 0,
              Type = 16,
              Timeout = 1.7,
              TimeoutKey = "k62"
            },
            {

              Path = "Bridge/K06",
              PlatCount = 2,
              PlatList = {
                "plat1",
                "plat2"
              },
              Type = 96,
              Timeout = 0.5,
              TimeoutKey = "k63"
            },
            {

              Key = "K06",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K06",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K03",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K03",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K08",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Bridge/K08",
              PlatCount = 2,
              PlatList = {
                "plat7",
                "plat8"
              },
              Type = 96,
              Timeout = 0.5,
              TimeoutKey = "k81"
            },
            {

              Target = "Hero",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 2.5,
              TimeoutKey = "k82"
            },
            {

              Target = "Hero",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 4.0,
              TimeoutKey = "k83"
            },
            {

              Key = "K08",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K08",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K05",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Target = "Hero",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 0.5,
              TimeoutKey = "k51"
            },
            {

              Target = "Hero",
              MagicId = 10560103,
              Level = 0,
              Type = 16,
              Timeout = 1.0,
              TimeoutKey = "k52"
            },
            {

              Path = "Bridge/K05",
              PlatCount = 1,
              PlatList = {
                "plat1"
              },
              Type = 96,
              Timeout = 0.5,
              TimeoutKey = "k53"
            },
            {

              Key = "K05",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K05",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "T1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 7,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 4022001,
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
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "K06",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 8,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 4022002,
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
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "K02",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 1,
                MonsterCount = 8,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 4022003,
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

          Key = "K10",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Bridge/K10",
              PlatCount = 1,
              PlatList = {
                "plat9"
              },
              Type = 96,
              Timeout = 0.0,
              TimeoutKey = "DnVvofWG"
            },
            {

              Camera = 105606,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              Target = "Hero",
              MagicId = 10560103,
              Level = 0,
              Type = 16,
              Timeout = 0.0,
              TimeoutKey = "SiwXchoT"
            },
            {

              NPC = "0_6010999_0",
              Point = "BP3",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            },
            {

              Key = "K10",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/Bridge_2/Bridge_2_1/sc05_bld_50a_pre (15)/FX05_glass_crack_1-4",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/Bridge_2/Bridge_2_1/sc05_bld_50a_pre (17)/FX05_glass_crack_1-4",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/Bridge_1/sc05_bld_50a_pre (16)/FX05_glass_crack_1-4",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              NPC = "0_105601_0",
              Point = "BP3",
              Rotate = 0.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K10",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "CAM1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 105040103,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/GroupCtrlObj/FX_SC05_boom_1",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.5,
              TimeoutKey = "MyqBmHQR"
            },
            {

              Target = "Hero",
              MagicId = 100455,
              Level = 0,
              Type = 16,
              Timeout = 0.5,
              TimeoutKey = "eizWxGZS"
            },
            {

              Key = "runout",
              SyncValType = 2,
              Value = true,
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
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "K07",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Path = "Bridge/K07",
              PlatCount = 4,
              PlatList = {
                "plat3",
                "plat4",
                "plat5",
                "plat6"
              },
              Type = 96,
              Timeout = 1.0,
              TimeoutKey = "k71"
            },
            {

              Target = "Hero",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 1.0,
              TimeoutKey = "k72"
            },
            {

              Target = "Hero",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 2.0,
              TimeoutKey = "k73"
            },
            {

              Target = "Hero",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 4.0,
              TimeoutKey = "k74"
            },
            {

              Target = "Hero",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 5.0,
              TimeoutKey = "k75"
            },
            {

              Target = "Hero",
              MagicId = 10560102,
              Level = 0,
              Type = 16,
              Timeout = 6.0,
              TimeoutKey = "k76"
            },
            {

              Key = "K07",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = true,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            }
          },
          FinishMarkVariable = "",
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "K07",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          ObjName = "Scene/grassrender_simple_grass01",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/grassrender_simple_ntr_14",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/grassrender_simple_ntr_15",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/grassrender_simple_ntr_16",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      EventName = "runout2",
      Actions = {
        {

          FadeIn = 0.0,
          Hold = 1.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "BP1",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0,
          TimeoutKey = "dfgert"
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 105601,
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
          Timeout = 1.5,
          TimeoutKey = "sgdcdver"
        },
        {

          Type = 69,
          Timeout = 0.0
        },
        {

          Path = "Bridge/K09",
          PlatCount = 0,
          Type = 96,
          Timeout = 1.1,
          TimeoutKey = "bvsevefg"
        },
        {

          Key = "RunOut",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ObjName = "Bridge/K10",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "TeCegwmX"
        },
        {

          ObjName = "Bridge/K08",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "JErdALTR"
        },
        {

          ObjName = "Bridge/K07",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "GPQtbvWb"
        },
        {

          ObjName = "Bridge/K06",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "mdmVRPRj"
        },
        {

          ObjName = "Bridge/K05",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "EEihouGs"
        },
        {

          ObjName = "Bridge/K04",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "BPkvLpHi"
        },
        {

          ObjName = "Bridge/K03",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "DXJwcKFi"
        },
        {

          ObjName = "Bridge/K02",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "vVDAojLR"
        },
        {

          ObjName = "Bridge/K01",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "JuXoAORg"
        },
        {

          Camera = 105040103,
          IsNewConfig = true,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "BP1",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 1.2,
          TimeoutKey = "TrkdQRDP"
        },
        {

          Key = "K01",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "sKvtPoTK"
        },
        {

          Key = "K02",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "eLGCSGPq"
        },
        {

          Key = "K03",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "iirNgPyQ"
        },
        {

          Key = "K04",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "ZqadjrQF"
        },
        {

          Key = "K05",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "bfukIowS"
        },
        {

          Key = "K06",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "zvIkkpKw"
        },
        {

          Key = "K07",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "AfrKhYTO"
        },
        {

          Key = "K08",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "YcCzNmeT"
        },
        {

          Key = "K10",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 1.0,
          TimeoutKey = "hKIekfHI"
        },
        {

          Key = "GUIDE",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          ObjName = "Bridge/Bridge_2/Bridge_2_1/sc05_bld_50a_pre (15)/FX05_glass_crack_1-4",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "EbRHDmtJ"
        },
        {

          ObjName = "Bridge/Bridge_2/Bridge_2_1/sc05_bld_50a_pre (17)/FX05_glass_crack_1-4",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "ZcgMoeDy"
        },
        {

          ObjName = "Bridge/Bridge_1/sc05_bld_50a_pre (16)/FX05_glass_crack_1-4",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "RSEOxgiy"
        },
        {

          ObjName = "Bridge/Plat1_/sc05_bld_50a_pre (4)/FX05_glass_crack_1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "xqRZxbBG"
        },
        {

          ObjName = "Bridge/Plat1_/sc05_bld_50a_pre (2)/FX05_glass_crack_1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "YUHTfaJw"
        },
        {

          GroupId = 402202,
          Type = 27,
          Timeout = 1.1,
          TimeoutKey = "xJfFfCXc"
        },
        {

          Group = 402202,
          Type = 65,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "runout",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "runout1",
      Actions = {
        {

          Type = 22,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "bornpoint",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          Type = 69,
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 6010999,
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
          Timeout = 0.0
        },
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "bornpoint",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.2,
          TimeoutKey = "zLXCkoeN"
        },
        {

          Group = 402201,
          Type = 65,
          Timeout = 0.0
        },
        {

          GroupId = 402201,
          Type = 27,
          Timeout = 0.5,
          TimeoutKey = "UAdEwktG"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "runout",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "关卡回档",
      Actions = {
        {

          CustomEventName = "runout1",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "runout2",
          Type = 19,
          Timeout = 0.0
        },
        {

          TipsId = 105501,
          Visible = true,
          Flip = false,
          Type = 15,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4032991,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        },
        {

          Key = "k61",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k62",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k63",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k81",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k82",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k83",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k51",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k52",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k53",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k71",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k72",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k73",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k74",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k75",
          Type = 52,
          Timeout = 0.0
        },
        {

          Key = "k76",
          Type = 52,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 4032190,
          Level = 1,
          Type = 16,
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

      EventName = "dead1",
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 6010999,
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
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "dead1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "dead2",
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
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 105601,
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
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "dead2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          GuideID = 1050101,
          Actions = {
            {

              Camera = 105040104,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 15,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          ArchiveNumber = 1,
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
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 105601,
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
              Timeout = 0.0
            },
            {

              Path = "Bridge/K09",
              PlatCount = 9,
              PlatList = {
                "plat1",
                "plat2",
                "plat3",
                "plat4",
                "plat5",
                "plat6",
                "plat7",
                "plat8",
                "plat9"
              },
              Type = 96,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              ObjName = "Bridge/K01",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/K02",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/K03",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/K04",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/K05",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/K06",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/K07",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/K08",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Bridge/K10",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              FadeIn = 0.0,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 27,
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
    EventCount = 9,
    MonsterCount = 29,
    MonsterInfo = {
      [ 300100501 ] = 6,
      [ 20104602 ] = 23
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = true
}