local empty = {}
return
{
  StoryId = 101205,
  Steps = {
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "UIstory_black",
        BgScale = 1.0,
        InsertAnimList = empty,
        ExtraBgScale = 1.0
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          AnimTime = 0.6
        },
        HideEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "Sound_compere_loop",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter_library_compere",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      ChangeScene = {
        OpenAnim = true,
        OpenEffect = 3,
        OpenAnimTime = 4.0,
        Title = "101205_1"
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (1)"
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      WorldDicId = -1,
      Talking = {
        Level = 2,
        ShowEffect = {
          AnimTime = 0.6
        },
        HideEffect = {
          Enable = true,
          AnimTime = 0.6
        },
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
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "UIStory_trans",
        NotFullImage = true,
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 1.0,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
            IsReset = true,
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_hand"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_idle"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.73
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.57
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.32
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
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
        CharName = "5001001",
        Sound = "1-4ningsha-4",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_2",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_001",
            SoundVolume = 0.7,
            FadeInTime = 3.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "Sound_compere_loop",
            Delay = 0.5,
            SoundVolume = 1.0,
            HideSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      Selection = {
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = empty,
        NoBranch = true,
        Jump = 5,
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 1.0
      }
    },
    {
      JumpId = 5,
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
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
          AnimTime = 0.6
        },
        HideEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Selection = {
        Branch = true,
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = {
          {
            Content = "101205_3",
            Jump = 7
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      JumpId = 7,
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
            BodyAnim = {
              {
                InsertAnim = "B_box"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.0
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
                InsertAnimLifeTime = 1.65
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.21
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
        CharName = "5001001",
        Sound = "1-4ningsha-5",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_4",
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
            RoleImg = "SP_1001001",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.5,
              0.0,
              0.9
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
                InsertAnim = "E_surprise"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "M_surprise"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_surprise"
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
        CharName = "1001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_5",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Selection = {
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = empty,
        NoBranch = true,
        Jump = 10,
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      JumpId = 10,
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
            RoleImg = "SP_1001008",
            ChangeParentName = "Talk",
            PosInfo = {
              0.2,
              -0.6,
              0.0,
              0.9
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
                InsertAnim = "E_serious"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_serious"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.23
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.14
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.14
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.3
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.2
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
        CharName = "1001008",
        Sound = "1-4yileishian-43",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_6",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
                InsertAnim = "E_think"
              },
              {
                InsertAnim = "E_open",
                InsertAnimDelay = 3.5
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.5
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.34
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.87
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.13
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.4
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.23
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
        CharName = "1001019",
        Sound = "1-4ningsha-6",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_7",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
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
          AnimTime = 0.6
        },
        HideEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Selection = {
        Branch = true,
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = {
          {
            Content = "101205_8",
            Jump = 14
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      JumpId = 14,
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
            RoleImg = "SP_1001008",
            ChangeParentName = "Talk",
            PosInfo = {
              0.2,
              -0.6,
              0.0,
              0.9
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
                InsertAnim = "E_surprise"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_serious"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.26
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.78
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.2
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
        CharName = "1001008",
        Sound = "1-4yileishian-44",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_9",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
                InsertAnim = "E_idle"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.68
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.22
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.43
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
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
        CharName = "1001019",
        Sound = "1-4ningsha-7",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_10",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Selection = {
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = empty,
        NoBranch = true,
        Jump = 17,
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      JumpId = 17,
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.5
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.5
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.23
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.46
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.65
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.12
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.95
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.25
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
        CharName = "1001019",
        Sound = "1-4ningsha-8",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_11",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
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
                InsertAnim = "E_down"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.0
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
                InsertAnimLifeTime = 0.65
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.21
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
        CharName = "1001019",
        Sound = "1-4ningsha-9",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_12",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              AnimTime = 0.6
            },
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_13",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter00_06",
            Delay = 1.0,
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
                InsertAnim = "E_serious"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_serious"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.39
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.23
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
        CharName = "1001019",
        Sound = "1-4ningsha-10",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_14",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              AnimTime = 0.6
            },
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_15",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      MustPlay = true,
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_16",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter00_05",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter00_05",
            Delay = 0.75,
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter00_05",
            Delay = 1.5,
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      ChangeScene = {
        OpenAnimTime = 1.0,
        CloseAnim = true,
        CloseDelay = 1.0
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (1.5)"
      }
    },
    {
      AutoPlay = true,
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_hand"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_serious",
                InsertAnimLifeTime = 5.0
              },
              {
                InsertAnim = "E_think",
                InsertAnimLifeTime = 5.0
              },
              {
                InsertAnim = "E_open"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 2.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 4.0
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.22
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.77
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.23
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.77
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.55
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.53
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.54
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.27
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.31
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.53
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 5.06
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.22
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
        CharName = "1001019",
        Sound = "1-4ningsha-11",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_17",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 2.0,
        CloseAnim = true
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (2)"
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "UIStory_black",
        BgScale = 1.0,
        InsertAnimList = empty,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001019",
            ChangeParentName = "",
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_idle"
              }
            },
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_18",
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
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "UIStory_trans",
        NotFullImage = true,
        BgScale = 1.0,
        InsertAnimList = empty,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
                InsertAnim = "E_idle"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 8.0
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.24
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.58
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.38
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.77
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.27
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.52
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.21
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
        CharName = "1001019",
        Sound = "1-4ningsha-12",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_19",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 2.0
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (3)"
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
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
                InsertAnim = "E_down"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_serious"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.42
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.74
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.36
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.44
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.84
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.22
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
        CharName = "1001019",
        Sound = "1-4ningsha-13",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_20",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_21",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
                InsertAnim = "E_think"
              },
              {
                InsertAnim = "E_open",
                InsertAnimDelay = 4.0
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 1.5
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
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 1.79
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.18
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
        CharName = "1001019",
        Sound = "1-4ningsha-14",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_22",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_23",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
                InsertAnim = "E_down"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.5
              },
              {
                InsertAnim = "M_serious"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.35
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.67
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.81
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.38
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.45
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.22
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
        CharName = "1001019",
        Sound = "1-4ningsha-15",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_24",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
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
                InsertAnim = "E_serious"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_serious"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.42
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.13
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.14
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.51
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.49
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.33
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.2
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
        CharName = "1001019",
        Sound = "1-4ningsha-16",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_25",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              AnimTime = 0.6
            },
            MoveData = {
              3.0,
              4.0,
              0.4
            },
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_26",
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
            RoleImg = "SP_1001001",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.5,
              0.0,
              0.9
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
            BodyAnim = {
              {
                InsertAnim = "B_shake"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.47
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.23
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
        CharName = "1001001",
        Sound = "1-4ling-24",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_27",
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
            RoleImg = "SP_1001001",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.5,
              0.0,
              0.9
            },
            ShowEffect = {
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.5
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
                InsertAnimLifeTime = 2.03
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
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
        CharName = "1001001",
        Sound = "1-4ling-25",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_28",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
                InsertAnim = "E_down"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.75
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.76
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              }
            },
          },
          {
            SubLevel = 1,
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001",
            ChangeParentName = "",
            PosInfo = {
              0.0,
              0.0,
              0.0,
              0.0
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            IsMove = true,
            MoveData = {
              3.0,
              4.0,
              0.5
            },
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
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
        CharName = "1001019",
        Sound = "1-4ningsha-17",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_29",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
              AnimTime = 0.6
            },
            HideEffect = {
              Enable = true,
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_box"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_sigh"
              },
              {
                InsertAnim = "E_open",
                InsertAnimDelay = 3.0
              }
            },
            MouthAnim = {
              {
                InsertAnim = "M_sigh"
              }
            },
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_30",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (4)"
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
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
                InsertAnim = "E_down"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 3.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 3.26
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.22
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
        CharName = "1001019",
        Sound = "1-4ningsha-18",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          HeadRes = "",
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_31",
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
            RoleImg = "SP_1001019",
            ChangeParentName = "Talk",
            PosInfo = {
              0.3,
              -0.3,
              0.0,
              0.9
            },
            ShowEffect = {
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
                InsertAnim = "E_serious"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 3.5
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.72
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.44
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.96
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.22
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
        CharName = "1001019",
        Sound = "1-4ningsha-19",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101205_32",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_001",
            SoundVolume = 1.0,
            FadeOutTime = 10.0,
            HideSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      ChangeScene = {
        OpenAnimTime = 1.0,
        CloseAnim = true,
        CloseDelay = 1.5
      }
    }
  },
  TimelineRes = "storytimeline101205"
}