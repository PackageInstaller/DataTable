local empty = {}
return
{
  StoryId = 5070701,
  Steps = {
    {
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Talking = {
        Level = 2,
        Type = 3,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "1001004",
        Sound = "7-7xin_2",
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
        Content = "5070701_1",
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
            Content = "5070701_2"
          },
          {
            Content = "5070701_3"
          }
        },
        IsTimeLimit = true,
        LimitTime = 3.0,
        TimeBarEffectName = "Ani_VX_TimeBar_3s"
      }
    }
  },
}