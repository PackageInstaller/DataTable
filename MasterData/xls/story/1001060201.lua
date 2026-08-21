local empty = {}
return
{
  StoryId = 1001060201,
  Steps = {
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
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter_chapter6_compere",
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
        OpenEffectStyle = "StoryTitleObj2",
        OpenAnimTime = 4.5,
        Title = "1001060201_1"
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "UIstory_trans",
        NotFullImage = true,
        BgScale = 1.0,
        InsertAnimList = empty,
        LocationName = "",
        LocationNameLanguageId = "1001060201_2",
        ExtraBgScale = 1.0
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060201_3",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_055",
            SoundVolume = 0.6,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 1.0
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (1)"
      }
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
        Content = "1001060201_4",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
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
        Content = "1001060201_5",
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
            RoleImg = "SP_1001021",
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
            BodyAnim = {
              {
                InsertAnim = "cell_off"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.5
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.92
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
        CharName = "1001021",
        Sound = "6-2azi_1",
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
        Content = "1001060201_6",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_white",
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
          effectAlpha = 1.0
        }
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter06_05",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 1.0,
        CloseAnim = true
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (2)"
      }
    },
    {
      UseSpineRes = true,
      WorldDicId = -1,
      Background = {
        Image = "UIstory_black",
        BgScale = 1.0,
        InsertAnimList = empty,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001021",
            ChangeParentName = "",
            UseConfigPosInfo = true,
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
      WorldDicId = -1,
      Background = {
        Image = "UIstory_trans",
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
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001021",
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
              Delay = 0.2,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            BodyAnim = {
              {
                InsertAnim = "cell_off"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.9
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.65
              },
              {
                InsertAnim = "M_smile",
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
        CharName = "1001021",
        Sound = "6-2azi_2",
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
        Content = "1001060201_7",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_white",
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
          effectAlpha = 1.0
        }
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter06_05",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 1.0,
        CloseAnim = true
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
      Background = {
        Image = "UIstory_black",
        BgScale = 1.0,
        InsertAnimList = empty,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001021",
            ChangeParentName = "",
            UseConfigPosInfo = true,
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060201_8",
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
      WorldDicId = -1,
      Background = {
        Image = "UIstory_trans",
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
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001021",
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
            BodyAnim = {
              {
                InsertAnim = "cell_off"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.1
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.48
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.41
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.38
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
        CharName = "1001021",
        Sound = "6-2azi_3",
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
        Content = "1001060201_9",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_white",
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
          effectAlpha = 1.0
        }
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter06_05",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 1.0
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
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001021",
            ChangeParentName = "",
            UseConfigPosInfo = true,
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
            Grey = 255,
            LoopAnimName = "idle",
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_idle",
                InsertAnimLifeTime = 6.5
              },
              {
                InsertAnim = "E_sad"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 5.6
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.9
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.1
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 5.39
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.79
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
        CharName = "1001021",
        Sound = "6-2azi_4",
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
        Content = "1001060201_10",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "",
            UseConfigPosInfo = true,
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060201_11",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Res = "Fx_St_fog",
          show = {
            Enable = true
          },
          hide = empty,
          playSpeed = 0.5,
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
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (5)"
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
            RoleImg = "SP_1001021",
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
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 3.1
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 3.61
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
        CharName = "1001021",
        Sound = "6-2azi_5",
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
        Content = "1001060201_12",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "",
            UseConfigPosInfo = true,
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060201_13",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
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
        Content = "1001060201_14",
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
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1001021",
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.2
              },
              {
                InsertAnim = "M_surprise"
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
                InsertAnimLifeTime = 2.47
              },
              {
                InsertAnim = "M_surprise",
                InsertAnimLifeTime = 0.19
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
        CharName = "1001021",
        Sound = "6-2azi_6",
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
        Content = "1001060201_15",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Res = "Fx_St_fog",
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
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (6)"
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
            RoleImg = "SP_1001021",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.4
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.6
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
                InsertAnimLifeTime = 1.48
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.81
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.11
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.34
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.44
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.3
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.16
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.79
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
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
        CharName = "1001021",
        Sound = "6-2azi_7",
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
        Content = "1001060201_16",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 7.4
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.17
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.27
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.74
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.11
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.43
              },
              {
                InsertAnim = "M_sad",
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
        CharName = "1001021",
        Sound = "6-2azi_8",
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
        Content = "1001060201_17",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_think"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.1
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 1.1
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.5
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
                InsertAnimLifeTime = 0.84
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.59
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.74
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.32
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.19
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
        CharName = "1001021",
        Sound = "6-2azi_9",
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
        Content = "1001060201_18",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_think"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_smile"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.7
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.7
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.21
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.07
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.33
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.97
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.19
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
        CharName = "1001021",
        Sound = "6-2azi_10",
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
        Content = "1001060201_19",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.1
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.6
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 3.39
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.14
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.85
              },
              {
                InsertAnim = "M_smile",
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
        CharName = "1001021",
        Sound = "6-2azi_11",
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
        Content = "1001060201_20",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_aim"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.8
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.21
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 3.74
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.07
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.92
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.27
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.19
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
        CharName = "1001021",
        Sound = "6-2azi_12",
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
        Content = "1001060201_21",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_think"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.1
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 7.8
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
                InsertAnimLifeTime = 1.63
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.22
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.59
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.69
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.3
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 5.92
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
        CharName = "1001021",
        Sound = "6-2azi_13",
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
        Content = "1001060201_22",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
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
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.7
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
                InsertAnimLifeTime = 5.21
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.19
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
        CharName = "1001021",
        Sound = "6-2azi_14",
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
        Content = "1001060201_23",
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
            RoleImg = "SP_1001021",
            ChangeParentName = "Talk",
            UseConfigPosInfo = true,
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060201_24",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter04_17",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      ChangeScene = {
        OpenAnimTime = 1.0,
        CloseAnim = true
      }
    },
    {
      UseSpineRes = true,
      MustPlay = true,
      StepCD = 2.5,
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060201_25",
        hasStyledText = true,
        ContentLength = 30,
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_thick_fog",
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
          effectAlpha = 1.0
        }
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 1.0,
        CloseAnim = true
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (7)"
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      WorldDicId = -1,
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001021",
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
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.1
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.1
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 1.1
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.4
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 3.37
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.19
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
        CharName = "1001021",
        Sound = "6-2azi_15",
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
        Content = "1001060201_26",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_thick_fog",
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
        OpenAnimTime = 1.0,
        CloseAnim = true,
        CloseDelay = 1.5
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (8)"
      }
    }
  },
  TimelineRes = "storytimeline_1001060201",
  HideGlobalHero = true
}