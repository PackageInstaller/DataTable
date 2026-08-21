local empty = {}
return
{
  StoryId = 201103,
  Steps = {
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Selection = {
        FightBranch = true,
        ShowEffect = 1,
        HideEffect = 1,
        FadeTime = 0.6,
        SelectionList = {
          {
            Content = "201103_1",
            Jump = 2
          },
          {
            Content = "201103_2",
            Jump = 2
          }
        },
        IsTimeLimit = true,
        LimitTime = 3.0,
        TimeBarEffectName = "Ani_VX_TimeBar_3s"
      }
    },
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Talking = {
        Level = 2,
        Type = 3,
        ShowEffect = {
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        BackgroundBlurType = 1,
        CharName = "1001001",
        Sound = "1-2ling-31",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "201103_3",
        CaptionsTime = 5.0,
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
        Type = 3,
        ShowEffect = {
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        BackgroundBlurType = 1,
        CharName = "1001001",
        Sound = "1-2ling-32",
        SceneTalkPosY = -340.0,
        HeadInfo = {
          ShowEffect = {
            AnimTime = 0.6
          },
          HideEffect = {
            AnimTime = 0.6
          }
        },
        Content = "201103_4",
        CaptionsTime = 2.0,
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      }
    }
  },
}