local empty = {}
return
{
  StoryId = 1001060601,
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
        Title = "1001060601_1"
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
        Content = "1001060601_2",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_058",
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
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1002025",
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 7.1
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.6
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.46
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.55
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.98
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.58
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.23
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.14
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.32
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.07
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.83
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.36
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.71
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.35
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.65
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
        CharName = "5001107",
        Sound = "6-6jumin_1",
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
        Content = "1001060601_3",
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
            RoleImg = "SP_1001004",
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
              0.4
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
                InsertAnimLifeTime = 1.2
              },
              {
                InsertAnim = "M_surprise",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.8
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
                InsertAnimLifeTime = 0.41
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.1
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.32
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.62
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.3
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
        CharName = "1001004",
        Sound = "6-6xin_1",
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
        Content = "1001060601_4",
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
            RoleImg = "SP_1002025",
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 14.8
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.5
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.71
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.29
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.07
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.05
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.17
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.59
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.31
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.64
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.53
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.45
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.68
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
        CharName = "5001107",
        Sound = "6-6jumin_2",
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
        Content = "1001060601_5",
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
            RoleImg = "SP_1002025",
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
        Content = "1001060601_6",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
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
      Character = {
        ParentLevel = 1,
        CharacterInfos = {
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001004",
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
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.1
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.2
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
                InsertAnimLifeTime = 1.25
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.52
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.77
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.39
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
        CharName = "1001004",
        Sound = "6-6xin_2",
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
        Content = "1001060601_7",
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
            RoleImg = "SP_1002025",
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
                InsertAnim = "B_thanks"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.0
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 10.9
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
                InsertAnimLifeTime = 0.46
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.3
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.21
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.83
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.24
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.14
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 6.67
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.09
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.79
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
        CharName = "5001107",
        Sound = "6-6jumin_3",
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
        Content = "1001060601_8",
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
            RoleImg = "SP_1002025",
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
        Content = "1001060601_9",
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
                InsertAnim = "B_hi"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 5.3
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
                InsertAnimLifeTime = 1.17
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.09
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.1
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.43
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.14
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.31
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.83
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
        Sound = "6-6azi_1",
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
        Content = "1001060601_10",
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
            RoleImg = "SP_1002025",
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
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 11.0
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.54
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.33
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.28
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.37
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.58
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.51
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.74
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.32
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.89
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.63
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.43
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.61
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.2
              }
            },
          },
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
              Effect = 1,
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
                InsertAnim = "B_hi"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 5.3
              },
              {
                InsertAnim = "M_idle"
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
        CharName = "5001107",
        CharIcon = "",
        Sound = "6-6jumin_4",
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
        Content = "1001060601_11",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "M_surprise",
                InsertAnimLifeTime = 0.9
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.6
              },
              {
                InsertAnim = "M_surprise"
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
                InsertAnimLifeTime = 0.46
              },
              {
                InsertAnim = "M_surprise",
                InsertAnimLifeTime = 0.57
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.22
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.1
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.44
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.9
              },
              {
                InsertAnim = "M_surprise",
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
        Sound = "6-6azi_2",
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
        Content = "1001060601_12",
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
            RoleImg = "SP_1002025",
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060601_13",
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
            RoleImg = "SP_1002025",
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
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 13.0
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
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.51
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.98
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.34
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.95
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.66
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.38
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.09
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.39
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.66
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.44
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.41
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.24
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.31
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.16
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.31
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
        CharName = "5001107",
        CharIcon = "",
        Sound = "6-6jumin_5",
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
        Content = "1001060601_14",
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
            RoleImg = "SP_1002025",
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
                InsertAnimLifeTime = 8.6
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
                InsertAnimLifeTime = 0.44
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.59
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.42
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.16
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.13
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.3
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.23
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.55
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
        CharName = "5001107",
        CharIcon = "",
        Sound = "6-6jumin_6",
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
        Content = "1001060601_15",
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
                InsertAnim = "E_smile"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "M_surprise"
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
        CharName = "1001021",
        Sound = "6-6azi_3",
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
        Content = "1001060601_16",
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
            RoleImg = "SP_1001001",
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
              Effect = 1,
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            BodyAnim = {
              {
                InsertAnim = "B_thinking"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.9
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
                InsertAnimLifeTime = 0.89
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
        Sound = "6-6ling_1",
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
        Content = "1001060601_17",
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
      },
      Selection = {
        Branch = true,
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = {
          {
            Content = "1001060601_18",
            Jump = 19
          },
          {
            Content = "1001060601_19",
            Jump = 19
          },
          {
            Content = "1001060601_20",
            Jump = 19
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
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1001004",
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
                InsertAnimLifeTime = 0.1
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.7
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.5
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
                InsertAnimLifeTime = 0.35
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.56
              },
              {
                InsertAnim = "M_serious",
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
        CharName = "1001004",
        Sound = "6-6xin_3",
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
        Content = "1001060601_21",
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
            RoleImg = "SP_1002025",
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
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.7
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 8.9
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.1
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
                InsertAnimLifeTime = 2.72
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.43
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.01
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.48
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.23
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.21
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.75
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.35
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.46
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.35
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.69
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.28
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.33
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
        CharName = "5001107",
        Sound = "6-6jumin_7",
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
        Content = "1001060601_22",
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
            RoleImg = "SP_1001004",
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
        CharName = "1001004",
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
        Content = "1001060601_23",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (4.5)"
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
        CharIcon = "",
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
        Content = "1001060601_24",
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
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              Effect = 1,
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
                InsertAnimLifeTime = 6.5
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
                InsertAnimLifeTime = 0.68
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.31
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.19
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.47
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.34
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
        Sound = "6-6azi_4",
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
        Content = "1001060601_25",
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
            RoleImg = "SP_1002025",
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
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 17.5
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
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.3
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.77
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.05
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.67
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.68
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.83
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.67
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.38
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.42
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.56
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.07
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.58
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.3
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.37
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.58
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.32
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
        CharName = "5001107",
        CharIcon = "",
        Sound = "6-6jumin_8",
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
        Content = "1001060601_26",
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
            RoleImg = "SP_1001004",
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
        CharName = "1001004",
        CharIcon = "",
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
        Content = "1001060601_27",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
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
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1001001",
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
        CharIcon = "",
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
        Content = "1001060601_28",
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
        CharName = "1001021",
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
        Content = "1001060601_29",
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
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "M_sad",
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 5.5
              },
              {
                InsertAnim = "M_sad"
              }
            },
            MouthAnim_TC = empty,
            MouthAnim_EN = {
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.72
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.29
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.17
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.31
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.73
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.32
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 3.3
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
        Sound = "6-6azi_5",
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
        Content = "1001060601_30",
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
            RoleImg = "SP_1002025",
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
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_thanks"
              }
            },
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 5.0
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.36
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.17
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.95
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.41
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.54
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.4
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
        CharName = "5001107",
        Sound = "6-6jumin_9",
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
        Content = "1001060601_31",
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
            RoleImg = "SP_1001004",
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060601_32",
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
            RoleImg = "SP_1001004",
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
                InsertAnimLifeTime = 4.6
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
                InsertAnimLifeTime = 3.57
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.09
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.75
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
        CharName = "1001004",
        Sound = "6-6xin_4",
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
        Content = "1001060601_33",
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
            RoleImg = "SP_1002025",
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 6.0
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
                InsertAnimLifeTime = 0.47
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.27
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.33
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.47
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.17
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.35
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.83
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.24
              }
            },
          },
          {
            SubLevel = 1,
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1001004",
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
                InsertAnimLifeTime = 4.6
              },
              {
                InsertAnim = "M_idle"
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
        CharName = "5001107",
        Sound = "6-6jumin_10",
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
        Content = "1001060601_34",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
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
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1001004",
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.4
              },
              {
                InsertAnim = "M_surprise"
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
                InsertAnimLifeTime = 2.02
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.63
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.77
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
        CharName = "1001004",
        Sound = "6-6xin_5",
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
        Content = "1001060601_35",
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
            RoleImg = "SP_1002025",
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.8
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.6
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
                InsertAnimLifeTime = 0.85
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.51
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.36
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.24
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.57
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.51
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.36
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
        CharName = "5001107",
        Sound = "6-6jumin_11",
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
        Content = "1001060601_36",
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
            RoleImg = "SP_1002025",
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
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.7
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.9
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.8
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 5.3
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
                InsertAnimLifeTime = 3.62
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.73
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.97
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.07
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
        CharName = "5001107",
        Sound = "6-6jumin_12",
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
        Content = "1001060601_37",
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
            RoleImg = "SP_1002025",
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
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 5.9
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.3
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.1
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
                InsertAnimLifeTime = 2.01
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.37
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.22
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.15
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.91
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.97
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.6
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
        CharName = "5001107",
        Sound = "6-6jumin_13",
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
        Content = "1001060601_38",
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
              Enable = true,
              Effect = 1,
              AnimTime = 0.6
            },
            HideEffect = {
              Effect = 1,
              AnimTime = 0.6
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.5
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.9
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.4
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
                InsertAnimLifeTime = 0.63
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.18
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.82
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.58
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.78
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.63
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 1.78
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 0.15
              },
              {
                InsertAnim = "M_serious",
                InsertAnimLifeTime = 0.23
              }
            },
          },
          {
            SubLevel = 1,
            RolePos = 7,
            RoleScale = 1.0,
            RoleImg = "SP_1002025",
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
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 5.9
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.3
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 4.1
              },
              {
                InsertAnim = "M_idle"
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
        CharName = "1001021",
        Sound = "6-6azi_6",
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
        Content = "1001060601_39",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (7)"
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
            RoleImg = "SP_1002025",
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
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.1
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.6
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.3
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.1
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 6.4
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
                InsertAnimLifeTime = 0.67
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.15
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.51
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.4
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.91
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.87
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.11
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.66
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.33
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.08
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.05
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.27
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.55
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.45
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.32
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.32
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
        CharName = "5001107",
        CharIcon = "",
        Sound = "6-6jumin_14",
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
        Content = "1001060601_40",
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
        CharName = "1001021",
        Sound = "6-6azi_7",
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
        Content = "1001060601_41",
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
              Effect = 1,
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060601_42",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (8)"
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
      Selection = {
        Branch = true,
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = {
          {
            Content = "1001060601_43",
            Jump = 42
          },
          {
            Content = "1001060601_44",
            Jump = 42
          },
          {
            Content = "1001060601_45",
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060601_46",
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.7
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
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.17
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
        Sound = "6-6ling_2",
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
        Content = "1001060601_47",
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060601_48",
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
      Background = {
        Image = "UIstory_black",
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "1001060601_49",
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
                InsertAnim = "E_smile"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.7
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.8
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.9
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 1.1
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
                InsertAnimLifeTime = 1.74
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.33
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 2.47
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.09
              },
              {
                InsertAnim = "T_smile",
                InsertAnimLifeTime = 0.13
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
        Sound = "6-6azi_8",
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
        Content = "1001060601_50",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      ChangeScene = {
        OpenAnim = true,
        OpenAnimTime = 1.0
      },
      TimelineData = {
        NextStep = true,
        TimelineStepName = "step (9)"
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
            RoleImg = "SP_1002025",
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
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 3.0
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
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.77
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.18
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.28
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.13
              },
              {
                InsertAnim = "M_smile",
                InsertAnimLifeTime = 0.24
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
        CharName = "5001107",
        CharIcon = "",
        Sound = "6-6jumin_15",
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
        Content = "1001060601_51",
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
  TimelineRes = "storytimeline_1001060601",
  HideGlobalHero = true
}