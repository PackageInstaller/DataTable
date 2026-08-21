local empty = {}
return
{
  StoryId = 101110,
  AlphaEffectEnd = true,
  Steps = {
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Character = {
        ParentLevel = 3,
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
                InsertAnimLifeTime = 1.2
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.2
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
                InsertAnimLifeTime = 1.07
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.16
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.81
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
        Sound = "1-2ling-68",
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
        Content = "101110_1",
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
        ParentLevel = 3,
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
            BodyAnim = {
              {
                InsertAnim = "B_thinking"
              }
            },
            EyeAnim = {
              {
                InsertAnim = "E_confused",
                InsertAnimDelay = 2.0
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_think",
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
                InsertAnimLifeTime = 0.19
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.98
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.84
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.5
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
        Sound = "1-2ling-69",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "101110_2",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    }
  },
}