local empty = {}
return
{
  StoryId = 34011305,
  AlphaEffectEnd = true,
  Steps = {
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "5001368",
        CharIcon = "npc_g_36_",
        Sound = "ex1-14alatuosi_22",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_1",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_Memory_2",
          show = {
            Enable = true
          },
          hide = empty,
          playSpeed = 1.0,
          Pos = {
            0.0,
            0.0,
            0.0
          },
          effectAlpha = 0.6
        }
      },
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "5001368",
        CharIcon = "npc_g_36_",
        Sound = "ex1-14alatuosi_25",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_2",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1001026",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            BodyAnim = {
              {
                InsertAnim = "B_shake"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_serious"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 1.01
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.31
              },
              {
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 0.24
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.58
              },
              {
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 1.94
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.54
              },
              {
                InsertAnim = "M_sad"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 0.57
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.07
              },
              {
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 2.06
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "M_sad"
              }
            },
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "1001026",
        Sound = "ex1-14feinamina_14",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_3",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter01_08",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1001026",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            BodyAnim = {
              {
                InsertAnim = "B_sing"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_think"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.47
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.16
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.11
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.25
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.52
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.43
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.54
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.13
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.39
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.56
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.57
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.95
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.21
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.66
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.11
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.61
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.21
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.88
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.48
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.75
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.03
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.49
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.64
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.56
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.18
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.84
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.95
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.38
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.2
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.85
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.46
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.85
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.89
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.51
              },
              {
                InsertAnim = "M_sad"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.15
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.94
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.8
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.28
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.99
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.01
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.02
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.04
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.58
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.95
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.03
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.27
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.88
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.35
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.37
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.54
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.62
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.59
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.26
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.32
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.46
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.26
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.51
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.14
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.21
              },
              {
                InsertAnim = "M_sad"
              }
            },
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "1001026",
        Sound = "ex1-14feinamina_15",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_4",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1001026",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = empty,
            MouthAnim_TC = empty,
            MouthAnim_EN = empty,
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_5",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      ChangeScene = {
        OpenAnimTime = 1.0,
        CloseAnim = true
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001014",
            ChangeParentName = "",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.24
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.47
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.45
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.61
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.71
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.21
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.79
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.84
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.87
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "M_idle"
              }
            },
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "1001014",
        Sound = "ex1-13luogesi_12",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_6",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Res = "Fx_St_Memory_2",
          show = empty,
          hide = {
            Enable = true
          },
          playSpeed = 1.0,
          Pos = {
            0.0,
            0.0,
            0.0
          },
          effectAlpha = 1.0
        }
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 1.0
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001028",
            ChangeParentName = "",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            MoveData = {
              0.0,
              4.0,
              0.0
            },
            Grey = 255,
            LoopAnimName = "idle",
            LoopAnimName1 = "",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_sad"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
              }
            },
            noLoopAnim = empty,
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "5001368",
        Sound = "ex1-13alatuosi_14",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_7",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001028",
            ChangeParentName = "",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            MoveData = {
              0.0,
              4.0,
              0.0
            },
            Grey = 255,
            LoopAnimName = "idle",
            LoopAnimName1 = "",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              }
            },
            noLoopAnim = empty,
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "5001368",
        Sound = "ex1-13alatuosi_15",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_8",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001028",
            ChangeParentName = "",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            MoveData = {
              0.0,
              4.0,
              0.0
            },
            Grey = 255,
            LoopAnimName = "idle",
            LoopAnimName1 = "",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
              }
            },
            noLoopAnim = empty,
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "5001368",
        Sound = "ex1-13alatuosi_16",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_9",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001028",
            ChangeParentName = "",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            MoveData = {
              0.0,
              4.0,
              0.0
            },
            Grey = 255,
            LoopAnimName = "idle",
            LoopAnimName1 = "",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
              }
            },
            noLoopAnim = empty,
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "5001368",
        Sound = "ex1-13alatuosi_17",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_10",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001014",
            ChangeParentName = "",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_sad"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.56
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.73
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.86
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.48
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.22
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.72
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.17
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "M_idle"
              }
            },
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "1001014",
        Sound = "ex1-13luogesi_13",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_11",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001028",
            ChangeParentName = "",
            UseConfigPosInfo = true,
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            MoveData = {
              0.0,
              4.0,
              0.0
            },
            Grey = 100,
            LoopAnimName = "idle",
            LoopAnimName1 = "",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_nod"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_sad"
              }
            },
            MouthAnim = empty,
            MouthAnim_TC = empty,
            MouthAnim_EN = empty,
            noLoopAnim = empty,
          }
        },
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "34011305_12",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter00_06",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      }
    }
  },
}