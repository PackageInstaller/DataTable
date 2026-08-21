local empty = {}
return
{
  StoryId = 4041603,
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "4041603_1",
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
            Content = "4041603_2",
            Jump = 3
          },
          {
            Content = "4041603_3",
            Jump = 3
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "4041603_4",
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
        ParentLevel = 3,
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
                InsertAnim = "B_head4"
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
        Content = "4041603_5",
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
            Content = "4041603_6",
            Jump = 6
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
        ParentLevel = 3,
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
                InsertAnim = "B_head3"
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
        Content = "4041603_7",
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
            Content = "4041603_9",
            Jump = 8
          },
          {
            Content = "4041603_10",
            Jump = 8
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
        ParentLevel = 3,
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
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "4041603_11",
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
          },
          {
            Sound = "Sound_anjiu_01",
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
        ParentLevel = 3,
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
                InsertAnim = "B_shake"
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
        Content = "4041603_13",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    }
  },
}