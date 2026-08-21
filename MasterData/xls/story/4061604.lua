local empty = {}
return
{
  StoryId = 4061604,
  AlphaEffectEnd = true,
  Steps = {
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
        BackgroundBlurType = 1,
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
                InsertAnim = "E_surprise"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.2
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.55
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.24
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.94
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 1.06
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.85
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.52
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.35
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.51
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 0.8
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.24
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
                InsertAnimLifeTime = 0.35
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.24
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.31
              },
              {
                InsertAnim = "M_idle",
                InsertAnimLifeTime = 0.56
              },
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 1.99
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
        Sound = "6-16xin_5",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "4061604_1",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    }
  },
}