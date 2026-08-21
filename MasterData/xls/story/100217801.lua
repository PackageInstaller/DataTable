local empty = {}
return
{
  StoryId = 100217801,
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
            Sound = "sfx_chapter_personal_compere",
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
        OpenEffectStyle = "StoryTitleCom",
        OpenAnimTime = 4.5,
        Title = "100217801_1"
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg3_01",
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
            RoleImg = "SP_1001012",
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
        Content = "100217801_2",
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
            SoundVolume = 1.0,
            FadeInTime = 2.0,
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
            RoleImg = "SP_1001012",
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
            Content = "100217801_3",
            Jump = 4
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
            RoleImg = "SP_1001012",
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
                InsertAnim = "E_sad"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "M_serious"
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "100217801_4",
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
            RoleImg = "SP_1001012",
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
                InsertAnim = "E_serious2"
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
        CharName = "1001012",
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
        Content = "100217801_5",
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
            RoleImg = "SP_1001012",
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
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_serious"
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
        CharName = "1001012",
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
        Content = "100217801_6",
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
            RoleImg = "SP_1001012",
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
                InsertAnim = "B_glass"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_serious"
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
        Content = "100217801_7",
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
            RoleImg = "SP_1001012",
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
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_serious"
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
        CharName = "1001012",
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
        Content = "100217801_8",
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
            RoleImg = "SP_1001012",
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
              2.0,
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
          },
          {
            SubLevel = 1,
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1002016",
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
                InsertAnim = "B_nod"
              }
            },
            EyeAnim = empty,
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
        CharName = "5001047",
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
        Content = "100217801_9",
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
            RoleImg = "SP_1001012",
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
              3.0,
              0.5
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
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
            MouthAnim_EN = empty,
          },
          {
            SubLevel = 1,
            RolePos = 6,
            RoleScale = 1.0,
            RoleImg = "SP_1002016",
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
        CharName = "1001012",
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
        Content = "100217801_10",
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
            RoleImg = "SP_1001012",
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
              3.0,
              0.5
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
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_serious"
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
        CharName = "1001012",
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
        Content = "100217801_11",
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
            RoleImg = "SP_1001012",
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
              0.0,
              2.0,
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
          },
          {
            SubLevel = 1,
            RolePos = 4,
            RoleScale = 1.0,
            RoleImg = "SP_1002017",
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
                InsertAnim = "B_hand"
              }
            },
            EyeAnim = empty,
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
        CharName = "5001048",
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
        Content = "100217801_12",
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        Content = "100217801_13",
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
            RoleImg = "SP_1001012",
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
              2.0,
              0.5
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
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
        CharName = "1001012",
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
        Content = "100217801_14",
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
            RolePos = 4,
            RoleScale = 1.0,
            RoleImg = "SP_1002017",
            ChangeParentName = "",
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
            BodyAnim = {
              {
                InsertAnim = "B_hand"
              }
            },
            EyeAnim = empty,
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
        CharName = "5001048",
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
        Content = "100217801_15",
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
            RolePos = 4,
            RoleScale = 1.0,
            RoleImg = "SP_1002017",
            ChangeParentName = "",
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
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_serious"
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
        CharName = "5001048",
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
        Content = "100217801_16",
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
            RolePos = 4,
            RoleScale = 1.0,
            RoleImg = "SP_1002017",
            ChangeParentName = "",
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
                InsertAnim = "T_serious",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_serious"
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
        CharName = "5001048",
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
        Content = "100217801_17",
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
            RolePos = 4,
            RoleScale = 1.0,
            RoleImg = "SP_1002017",
            ChangeParentName = "",
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
            BodyAnim = {
              {
                InsertAnim = "B_thinking"
              }
            },
            EyeAnim = empty,
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
        CharName = "5001048",
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
        Content = "100217801_18",
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
            RoleImg = "SP_1001012",
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
              2.0,
              0.5
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_think2"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_surprise"
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
        CharName = "1001012",
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
        Content = "100217801_19",
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
            RoleImg = "SP_1001012",
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
              2.0,
              0.5
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_sigh"
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
        CharName = "1001012",
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
        Content = "100217801_20",
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
            RoleImg = "SP_1001012",
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
              2.0,
              0.5
            },
            Grey = 100,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = {
              {
                InsertAnim = "E_serious"
              }
            },
            MouthAnim = empty,
            MouthAnim_TC = empty,
            MouthAnim_EN = empty,
          },
          {
            SubLevel = 1,
            RolePos = 4,
            RoleScale = 1.0,
            RoleImg = "SP_1002017",
            ChangeParentName = "",
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
            BodyAnim = {
              {
                InsertAnim = "B_nod"
              }
            },
            EyeAnim = empty,
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
        CharName = "5001048",
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
        Content = "100217801_21",
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
            RoleImg = "SP_1001012",
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
              0.0,
              3.0,
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
          },
          {
            SubLevel = 1,
            RolePos = 4,
            RoleScale = 1.0,
            RoleImg = "SP_1002017",
            ChangeParentName = "",
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
        Content = "100217801_22",
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
            RoleImg = "SP_1001012",
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
              3.0,
              0.5
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = {
              {
                InsertAnim = "B_glass"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_sad"
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
        CharName = "1001012",
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
        Content = "100217801_23",
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
            RoleImg = "SP_1001012",
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
              3.0,
              0.5
            },
            Grey = 255,
            LoopAnimName = "idle",
            IsBodyReset = true,
            BodyAnim = empty,
            EyeAnim = empty,
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
        CharName = "1001012",
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
        Content = "100217801_24",
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