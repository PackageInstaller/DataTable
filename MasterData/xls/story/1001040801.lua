local empty = {}
return
{
  StoryId = 1001040801,
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "",
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
            Sound = "sfx_chapter_qian_compere",
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
        OpenEffectStyle = "StoryTitleObj1",
        OpenAnimTime = 4.5,
        Title = "1001040801_1"
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_81",
        BgScale = 1.0,
        InsertAnimList = empty,
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_2",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_040",
            SoundVolume = 0.7,
            FadeInTime = 2.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "Sound_compere_loop",
            SoundVolume = 1.0,
            HideSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "scene_ambience_BusDriving",
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
        Content = "1001040801_3",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_4",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_5",
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
            RoleImg = "SP_1002015",
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
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.3
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
                InsertAnimLifeTime = 0.73
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
        CharName = "5001037",
        Sound = "4-8zhantan_1",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_6",
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
          fadeInTime = 1.0,
          playSpeed = 1.0,
          Pos = {
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_think"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.2
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
                InsertAnimLifeTime = 1.11
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
        CharName = "5001037",
        Sound = "4-8zhantan_2",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_7",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.7
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.1
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.1
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
                InsertAnimLifeTime = 6.43
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
        CharName = "5001037",
        Sound = "4-8zhantan_3",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_8",
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
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_02",
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
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_4",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_9",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Camera = {
        BackgroundMove = true,
        Start = {
          -1000.0,
          1000.0,
          2.0
        },
        End = {
          1000.0,
          -1000.0,
          2.0,
          20.0
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
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_5",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_10",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_6",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_11",
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
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_04",
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
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_7",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_12",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Camera = {
        BackgroundMove = true,
        Start = {
          1000.0,
          0.0,
          1.5
        },
        End = {
          -1000.0,
          0.0,
          1.5,
          20.0
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
            RoleImg = "SP_1002015",
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
            Grey = 255,
            LoopAnimName = "fan",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "fan_on"
              }
            },
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
        CharName = "5001037",
        Sound = "4-8zhantan_8",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_13",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
            Grey = 255,
            LoopAnimName = "fan",
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
        CharName = "5001037",
        Sound = "4-8zhantan_9",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_14",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
            Grey = 255,
            LoopAnimName = "fan",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "fan_eye"
              }
            },
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
        CharName = "5001037",
        Sound = "4-8zhantan_10",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_15",
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
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_03",
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
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_11",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_16",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Camera = {
        BackgroundMove = true,
        Start = {
          1000.0,
          -1000.0,
          1.5
        },
        End = {
          -1000.0,
          1000.0,
          1.0,
          20.0
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
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_12",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_17",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_13",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_18",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_14",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_19",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_15",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_20",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
        CharName = "5001037",
        Sound = "4-8zhantan_16",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_21",
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
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_81",
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
            RoleImg = "SP_1002015",
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
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "fan_off"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.1
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.4
              },
              {
                InsertAnim = "M_idle"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.26
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.09
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.45
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.63
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.55
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.29
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.11
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.63
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
        CharName = "5001037",
        Sound = "4-8zhantan_17",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_22",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Camera = {
        BackgroundMove = true,
        Start = {
          0.0,
          0.0,
          1.0
        },
        End = {
          0.0,
          0.0,
          1.0,
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
      UseSpineRes = true,
      StepCD = 1.0,
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
        Content = "",
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
            Content = "1001040801_23",
            Jump = 24
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
            RoleImg = "SP_1002015",
            ChangeParentName = "",
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
            BodyAnim = {
              {
                InsertAnim = "B_shake"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.8
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.8
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
                InsertAnimLifeTime = 4.33
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
        CharName = "5001037",
        Sound = "4-8zhantan_18",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_24",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.9
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.7
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.1
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
                InsertAnimLifeTime = 0.9
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.16
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.25
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.65
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.38
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.69
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
        CharName = "5001037",
        Sound = "4-8zhantan_19",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_25",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_smile"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.1
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.2
              },
              {
                InsertAnim = "M_smile"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.22
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.22
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.14
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.04
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.09
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "M_smile",
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
        CharName = "5001037",
        Sound = "4-8zhantan_20",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_26",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.2
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 4.3
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
                InsertAnimLifeTime = 1.24
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.76
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.9
              },
              {
                InsertAnim = "M_smile",
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
        CharName = "5001037",
        Sound = "4-8zhantan_21",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_27",
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
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_81",
        BgScale = 1.0,
        InsertAnimList = empty,
        IsShake = true,
        shakeHoldTime = 1.0,
        ShakeData = {
          1.0,
          0.0,
          0.0
        },
        shakeStyle = 2,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1002015",
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
        Content = "1001040801_28",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_Memory_2",
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
            Sound = "storybgm_040",
            SoundVolume = 1.0,
            HideSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter04_11",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "scene_ambience_BusDriving",
            SoundVolume = 1.0,
            HideSound = true,
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
            Content = "1001040801_29",
            Jump = 30
          },
          {
            Content = "1001040801_30",
            Jump = 30
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_thinking"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_confused"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.2
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
                InsertAnimLifeTime = 2.96
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
        CharName = "1001001",
        Sound = "4-8ling_1",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_31",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_32",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter04_12",
            Delay = 0.5,
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
        CharName = "1001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_33",
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_thinking"
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
                InsertAnimLifeTime = 1.07
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
        Sound = "4-8ling_2",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_34",
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
            Content = "1001040801_35",
            Jump = 35
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
        Content = "1001040801_36",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter04_29",
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_37",
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
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.8
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
                InsertAnimLifeTime = 1.56
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
        Sound = "4-8ling_3",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_38",
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
            Content = "1001040801_39",
            Jump = 39
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
        CharName = "1001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_40",
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
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_hand"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.2
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.4
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
                InsertAnimLifeTime = 2.55
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.0
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
        CharName = "1001001",
        Sound = "4-8ling_4",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_41",
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
            Content = "1001040801_42",
            Jump = 42
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
        Content = "1001040801_43",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter01_13",
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
        CloseDelay = 1.5
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_67",
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
        CharName = "1001001",
        Sound = "4-8ling_5",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_44",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_006",
            IsLoop = true,
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter04_12",
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
          0.0,
          0.0,
          1.0
        },
        End = {
          0.0,
          0.0,
          1.0,
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
        Content = "1001040801_45",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter04_13",
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
            Content = "1001040801_46",
            Jump = 46
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
              AnimTime = 0.6
            },
            HideEffect = {
              AnimTime = 0.6
            },
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_think"
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
        CharName = "1001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_47",
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
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_open"
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
        CharName = "1001001",
        Sound = "4-8ling_6",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_48",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter04_12",
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
        Image = "StoryBg4_70",
        BgScale = 1.0,
        InsertAnimList = empty,
        IsShake = true,
        shakeHoldTime = 0.7,
        ShakeData = {
          0.0,
          0.0,
          0.0
        },
        shakeStyle = 2,
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
              AnimTime = 0.6
            },
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_surprise"
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
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_49",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter04_14",
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
          0.0,
          0.0,
          1.0
        },
        End = {
          0.0,
          0.0,
          1.0,
          0.0
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
            Content = "1001040801_50",
            Jump = 50
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_67",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
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
              AnimTime = 0.6
            },
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_thinking"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_think"
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
        CharName = "1001001",
        Sound = "4-8ling_7",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_51",
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
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_open"
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
        CharName = "1001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_52",
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
        CharName = "1001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_53",
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
              AnimTime = 0.6
            },
            MoveData = {
              0.0,
              0.0,
              0.0
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "bird_off"
              }
            },
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
        Content = "1001040801_54",
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
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
                InsertAnim = "B_noisy"
              }
            },
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
        CharName = "5001002",
        Sound = "Sound_anjiu_01",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_55",
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
        CharName = "1001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_56",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
            Content = "1001040801_57",
            Jump = 57
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
            LoopAnimName = "hip",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_58",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
            LoopAnimName = "hip",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_59",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_70",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
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
        CharName = "1001001",
        Sound = "4-8ling_8",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_60",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
                InsertAnim = "B_scare"
              }
            },
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_61",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_69",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_noisy"
              }
            },
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
        Content = "1001040801_62",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter01_32",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_63",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_64",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_65",
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
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_66",
        BgScale = 1.0,
        InsertAnimList = empty,
        shakeHoldTime = 99999.0,
        ShakeData = {
          99999.0,
          0.0,
          0.0
        },
        shakeStyle = 1,
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_66",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "scene_ambience_BusDriving",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter04_15",
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
      Background = {
        Image = "StoryBg4_73",
        BgScale = 1.0,
        InsertAnimList = empty,
        shakeHoldTime = 33333332.0,
        ShakeData = {
          0.0,
          0.0,
          0.0
        },
        shakeStyle = 1,
        FadeTime = 0.5,
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
        CharName = "1001001",
        Sound = "4-8ling_9",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_67",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
                InsertAnim = "B_scare"
              }
            },
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
        CharName = "5001002",
        Sound = "Sound_anjiu_03",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_68",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_69",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_76",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_70",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_71",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_75",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
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
        CharName = "1001001",
        Sound = "4-8ling_10",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_72",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
            LoopAnimName = "hip",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_73",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
            LoopAnimName = "hip",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_74",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
            LoopAnimName = "hip",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_75",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_74",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
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
        CharName = "1001001",
        Sound = "4-8ling_11",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_76",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
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
        FadeTime = 1.0,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_77",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter04_16",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter01_13",
            Delay = 0.3,
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_78",
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
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_66",
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
      Selection = {
        Branch = true,
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = {
          {
            Content = "1001040801_79",
            Jump = 79
          },
          {
            Content = "1001040801_80",
            Jump = 79
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
            RolePos = 2,
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
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "weapon_off"
              }
            },
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
        CharName = "1001001",
        Sound = "4-8ling_12",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_81",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_73",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 2,
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
        CharName = "1001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_82",
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
            RolePos = 2,
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
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "E_serious"
              }
            },
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
        CharName = "1001001",
        Sound = "4-8ling_13",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_83",
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
            Content = "1001040801_84",
            Jump = 83
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_66",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
        ExtraBgScale = 1.0
      },
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 2,
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
              Effect = 1,
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
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_85",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_006",
            SoundVolume = 1.0,
            FadeOutTime = 3.0,
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
        Content = "1001040801_86",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
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
          Res = "Fx_St_white",
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
            RolePos = 3,
            RoleScale = 1.0,
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
        CharName = "5001002",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_87",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Effects = {
        {
          Level = 3,
          Res = "Fx_St_Memory",
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
            RoleImg = "SP_1001001_1",
            ChangeParentName = "Talk",
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
          Level = 3,
          Res = "Fx_St_white",
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
          Level = 3,
          Res = "Fx_St_Memory",
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
      Selection = {
        Branch = true,
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = {
          {
            Content = "1001040801_88",
            Jump = 88
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_75",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_89",
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
        CharName = "1001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_90",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_76",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
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
        CharName = "1001001",
        Sound = "4-8ling_14",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_91",
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
        CharName = "1001001",
        Sound = "4-8ling_15",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_92",
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
          AnimTime = 0.6
        },
        HideEffect = {
          Enable = true,
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
        Content = "",
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
            Content = "1001040801_93",
            Jump = 93
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
        CharName = "1001001",
        Sound = "4-8ling_16",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_94",
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
        CharName = "1001001",
        Sound = "4-8ling_17",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_95",
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
        CharName = "1001001",
        Sound = "4-8ling_18",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_96",
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
          AnimTime = 0.6
        },
        HideEffect = {
          Enable = true,
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
        Content = "",
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
            Content = "1001040801_97",
            Jump = 97
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
        CharName = "1001001",
        Sound = "4-8ling_19",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_98",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 0.5,
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
        Content = "1001040801_99",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_015",
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_100",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_101",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_102",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_103",
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
            Content = "1001040801_104",
            Jump = 104
          },
          {
            Content = "1001040801_105",
            Jump = 104
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_66",
        BgScale = 1.0,
        InsertAnimList = empty,
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
        CharName = "1001001",
        Sound = "4-8ling_20",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_106",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_107",
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
        CharName = "1001001",
        Sound = "4-8ling_21",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_108",
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
        CharName = "1001001",
        Sound = "4-8ling_22",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_109",
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
        CharName = "1001001",
        Sound = "4-8ling_23",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_110",
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
        CharName = "1001001",
        Sound = "4-8ling_24",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_111",
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
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_66",
        BgScale = 1.0,
        InsertAnimList = empty,
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_112",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
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
        Content = "1001040801_113",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_114",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_115",
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
        CharName = "1001001",
        Sound = "4-8ling_25",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_116",
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
              Enable = true,
              Effect = 1,
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
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_117",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_118",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_119",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_120",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_121",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_122",
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
            Content = "1001040801_123",
            Jump = 122
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
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
        CharName = "1001001",
        Sound = "4-8ling_26",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_124",
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
        CharName = "1001001",
        Sound = "4-8ling_27",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_125",
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
        CharName = "1001001",
        Sound = "4-8ling_28",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_126",
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
              Effect = 1,
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
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_127",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_74",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 0.5,
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
        IsShake = true,
        ShakeData = {
          1.0,
          10.0,
          10.0,
          0.0,
          0.0
        },
        CharName = "1001001",
        Sound = "4-8ling_29",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_128",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_129",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter04_11",
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
      MustPlay = true,
      StepCD = 0.8,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg4_74",
        BgScale = 1.0,
        InsertAnimList = empty,
        IsShake = true,
        shakeHoldTime = 1.0,
        ShakeData = {
          0.0,
          0.0,
          0.0
        },
        shakeStyle = 2,
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
        CharName = "5001001",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_130",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "Sound_CarAccident",
            SoundVolume = 1.0,
            ShowSound = true,
            Show = empty,
            Hide = empty,
          },
          {
            Sound = "sfx_chapter04_21",
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
      AutoPlay = true,
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
        Content = "1001040801_131",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_015",
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
        Content = "1001040801_132",
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
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "1001040801_133",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      ChangeScene = {
        OpenAnimTime = 1.0,
        CloseAnim = true,
        CloseDelay = 1.5
      }
    }
  },
}