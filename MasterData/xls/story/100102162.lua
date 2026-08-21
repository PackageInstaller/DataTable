local empty = {}
return
{
  StoryId = 100102162,
  Steps = {
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg2_19",
        BgScale = 1.0,
        InsertAnimList = empty,
        IsShake = true,
        ShakeData = {
          2.0,
          20.0,
          30.0,
          0.0,
          0.0
        },
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
        BackgroundBlurType = 1,
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_1",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Res = "Fx_St_Zerohit_01",
          show = {
            Enable = true,
            Delay = 0.5
          },
          hide = empty,
          playSpeed = 1.0,
          Pos = {
            0.0,
            0.0
          },
          effectAlpha = 1.0
        },
        {
          Res = "Fx_St_Ash_02",
          show = {
            Enable = true
          },
          hide = empty,
          playSpeed = 1.0,
          Pos = {
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
            Sound = "sfx_chapter02_35",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter02_36",
            Delay = 1.0,
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "scene_ambience_earthquake_SFX",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_2",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter02_38",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter02_39",
            Delay = 1.0,
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter02_38",
            Delay = 2.0,
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter02_31",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "scene_ambience_earthquake_SFX",
            SoundVolume = 1.0,
            HideSound = true,
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
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "weapon",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_serious"
              }
            },
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
                InsertAnimLifeTime = 0.2
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
        CharName = "1001001",
        Sound = "2-16ling-4",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_3",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      ChangeScene = {
        OpenAnimTime = 1.0,
        CloseAnim = true,
        CloseDelay = 1.5
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      MustPlay = true,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg2_50",
        BgScale = 1.0,
        InsertAnimList = empty,
        IsShake = true,
        ShakeData = {
          2.0,
          100.0,
          50.0,
          0.0,
          0.0
        },
        Grey = 150,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
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
              Enable = true,
              AnimTime = 0.6
            },
            Grey = 100,
            LoopAnimName = "weapon",
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
      Effects = {
        {
          Res = "Fx_St_Eye_03",
          show = {
            Enable = true
          },
          hide = empty,
          playSpeed = 1.0,
          Pos = {
            0.0,
            0.0
          },
          effectAlpha = 1.0
        },
        {
          Res = "Fx_St_Ash_02",
          show = empty,
          hide = {
            Enable = true
          },
          playSpeed = 1.0,
          Pos = {
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
            IsBGM = true,
            Sound = "storybgm_030",
            SoundVolume = 0.5,
            FadeInTime = 5.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter02_37",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      Camera = {
        BackgroundMove = true,
        Start = {
          200.0,
          700.0,
          3.0
        },
        End = {
          200.0,
          700.0,
          3.0,
          0.0
        },
        IsContinuous = true,
        EaseType = 1
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 1.0
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      MustPlay = true,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg2_50",
        BgScale = 1.0,
        InsertAnimList = empty,
        Grey = 150,
        FadeTime = 1.5,
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
      Camera = {
        BackgroundMove = true,
        Start = {
          200.0,
          700.0,
          3.0
        },
        End = {
          -200.0,
          700.0,
          3.0,
          0.8
        },
        IsContinuous = true,
        EaseType = 4
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      MustPlay = true,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg2_50",
        BgScale = 1.0,
        InsertAnimList = empty,
        Grey = 150,
        FadeTime = 1.5,
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
      Camera = {
        BackgroundMove = true,
        Start = {
          -200.0,
          700.0,
          3.0
        },
        End = {
          400.0,
          700.0,
          3.0,
          0.8
        },
        IsContinuous = true,
        EaseType = 4
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg2_50",
        BgScale = 1.0,
        InsertAnimList = empty,
        Grey = 150,
        FadeTime = 1.5,
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
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_Vague",
          show = {
            Enable = true
          },
          hide = empty,
          playSpeed = 1.0,
          Pos = {
            0.0,
            0.0
          },
          effectAlpha = 1.0
        }
      },
      Camera = {
        BackgroundMove = true,
        Start = {
          400.0,
          700.0,
          3.0
        },
        End = {
          200.0,
          700.0,
          3.0,
          0.8
        },
        IsContinuous = true,
        EaseType = 4
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg2_50",
        BgScale = 1.0,
        InsertAnimList = empty,
        Grey = 250,
        FadeTime = 1.5,
        ExtraBgScale = 1.0
      },
      Talking = {
        Level = 2,
        ShowEffect = {
          Enable = true,
          Delay = 1.0,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "5001023",
        Sound = "2-16daliwu-1",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_4",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_Vague",
          show = empty,
          hide = {
            Enable = true
          },
          playSpeed = 1.0,
          Pos = {
            0.0,
            0.0
          },
          effectAlpha = 1.0
        }
      },
      Camera = {
        BackgroundMove = true,
        Start = {
          200.0,
          700.0,
          3.0
        },
        End = {
          100.0,
          500.0,
          2.0,
          30.0
        },
        IsContinuous = true,
        EaseType = 1
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
        CharName = "5001023",
        Sound = "2-16daliwu-2",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_5",
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
        CharName = "",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_6",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter02_39",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter02_40",
            Delay = 1.0,
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter02_39",
            Delay = 2.0,
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_7",
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
        CharName = "",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_8",
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
        CharName = "5001023",
        Sound = "2-16daliwu-3",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_9",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Res = "Fx_St_Vague",
          show = empty,
          hide = {
            Enable = true
          },
          playSpeed = 1.0,
          Pos = {
            0.0,
            0.0
          },
          effectAlpha = 1.0
        }
      },
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg2_41",
        BgScale = 1.0,
        InsertAnimList = empty,
        Grey = 250,
        FadeTime = 2.0,
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
        CharName = "",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_10",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter02_40",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          }
        },
      },
      Camera = {
        BackgroundMove = true,
        Start = {
          70.0,
          300.0,
          1.5
        },
        End = {
          0.0,
          100.0,
          1.2,
          30.0
        },
        IsContinuous = true,
        EaseType = 1
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
        CharName = "5001023",
        Sound = "2-16daliwu-4",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_11",
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
        CharName = "5001023",
        Sound = "2-16daliwu-5",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "100102162_12",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_030",
            SoundVolume = 1.0,
            FadeOutTime = 6.0,
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
}