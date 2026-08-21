local empty = {}
return
{
  StoryId = 1001081801,
  Steps = {
    {
      UseSpineRes = true,
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
      ChangeScene = {
        OpenAnim = true,
        OpenEffect = 3,
        OpenEffectStyle = "StoryTitleObj5",
        OpenAnimTime = 4.5,
        TitleLanguageId = "1001081801_61",
        Title = "朝圣者"
      }
    },
    {
      AutoPlay = true,
      UseSpineRes = true,
      StepCD = 1.0,
      WorldDicId = -1,
      Background = {
        Image = "StoryBg8_37",
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
        ContentLanguageId = "1001081801_1",
        Content = "阶梯的尽头，并非想象中堆满金银的宝库，而是一个更为广阔、如同地下殿堂般的空间。",
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
          2.0,
          20.0
        },
        IsContinuous = true
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
        ContentLanguageId = "1001081801_2",
        Content = "这里的墙壁未经精细雕琢，保留着开凿时的粗犷痕迹，与博物馆上方的华丽风格截然不同，充满了原始而沉重的力量感。",
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
        Image = "StoryBg8_38",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 1.5,
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        ContentLanguageId = "1001081801_3",
        Content = "殿堂的中心，并非供奉着奇珍异宝，而是静静地安置着一座巨大的……石棺。",
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
            ContentLanguageId = "1001081801_5",
            Content = "这是？",
            Jump = 5
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      JumpId = 5,
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
        ContentLanguageId = "1001081801_6",
        Content = "贝尔蒂丝走上前，指尖轻轻拂过冰冷的棺盖，语气带着一种复杂的追忆。",
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
            RoleImg = "SP_1001009a",
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
                InsertAnimLifeTime = 2.0
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
        CharName = "贝尔蒂丝",
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
        ContentLanguageId = "1001081801_7",
        Content = "先祖萨尔维斯，他最初希望自己最终能长眠于他所热爱的艺术与秘密之中，与这座他委托建造的博物馆融为一体。",
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
            RoleImg = "SP_1001009a",
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
                InsertAnim = "E_down"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_idle",
                InsertAnimLifeTime = 2.0
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
        CharName = "贝尔蒂丝",
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
        ContentLanguageId = "1001081801_8",
        Content = "只是……他后来并未使用它。这个地方，最终也仅仅成了家族历史中一个模糊的逸闻。",
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
        ContentLanguageId = "1001081801_9",
        Content = "她的指尖似乎无意中触碰到什么，一阵低沉的轰鸣响起。",
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
            RoleImg = "SP_1001009a",
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
        ContentLanguageId = "1001081801_10",
        Content = "伴随石头摩擦的闷响，棺内景象逐渐呈现——",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter01_18",
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        ContentLanguageId = "1001081801_11",
        Content = "里面躺着的，正是消失数日的乌菲齐。",
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
        ContentLanguageId = "1001081801_12",
        Content = "他面容平静，仿佛只是沉睡，双手交叠于胸前，怀中紧紧抱着一幅油画。",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_072",
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        ContentLanguageId = "1001081801_13",
        Content = "他的一只手边，放着一把老式手枪，点滴猩红在额角绽放。",
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
        ContentLanguageId = "1001081801_14",
        Content = "而在他的另一只手中，则攥着一封厚厚的信。",
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
            RoleImg = "SP_1001009a",
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
            EyeAnim = {
              {
                InsertAnim = "E_sad"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 1.0
              },
              {
                InsertAnim = "M_sad"
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
        CharName = "贝尔蒂丝",
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
        ContentLanguageId = "1001081801_15",
        Content = "果然……",
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
        ContentLanguageId = "1001081801_16",
        Content = "贝尔蒂丝的声音低沉，没有太多惊讶，只有沉重的了然。",
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
            RoleImg = "SP_1001009a",
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
            EyeAnim = {
              {
                InsertAnim = "E_sad"
              }
            },
            MouthAnim = {
              {
                InsertAnim = "T_sad",
                InsertAnimLifeTime = 2.0
              },
              {
                InsertAnim = "M_sad"
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
        CharName = "贝尔蒂丝",
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
        ContentLanguageId = "1001081801_17",
        Content = "其实这一路上……也隐隐猜到了。",
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
        ContentLanguageId = "1001081801_18",
        Content = "我沉默地拿起了他手中的信。",
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
            RoleImg = "SP_1001009a",
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
        ContentLanguageId = "1001081801_19",
        Content = "……",
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
        Image = "UIStory_black",
        BgScale = 1.0,
        InsertAnimList = empty,
        ExtraBgScale = 1.0
      },
      Talking = {
        Level = 2,
        Type = 1,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "",
        FirstLinePos = -300,
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
        ContentLanguageId = "1001081801_20",
        Content = "致同为朝圣者的你：&    当你读到这些文字时，想必已通过了睡莲的指引、纪功柱的辉光，与那些在死与生边缘徘徊的石像对话过了——&    你已走完了我为你铺设的这条小小的“朝圣”之路。&    是的，这一切的谜题，从睡莲到纪功柱，从会动的雕塑到这间地宫，都是我精心安排的。&    我并非要为难你，而是怀着一种近乎悲悯的愿望：&    我希望你能像我曾经那样，一步一步，从艺术的表象潜入历史的暗流，最终……&    直面那个存在。",
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
        Type = 1,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "",
        FirstLinePos = -300,
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
        ContentLanguageId = "1001081801_21",
        Content = "    我花了数十年时间，陪伴着这些博纳罗蒂的杰作。&    我抚摸过每一道刻痕，试图理解大师凿下它们时的心境。&    起初，我和所有学者一样，只看到美与信仰。&    但渐渐地，那些隐藏在和谐之下的不谐和音，开始刺痛我的灵魂。&    为什么《昼》、《夜》、《晨》、《暮》的姿态如此痛苦？&    为什么卢比孔成圣的画作下，掩盖着截然不同的色彩？&    为什么雅弗利尔的石头……仿佛记得什么？&    我循着这些疑问，如同一个虔诚的朝圣者，在历史的尘埃中艰难跋涉。",
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
        Type = 1,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "",
        FirstLinePos = -300,
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
        ContentLanguageId = "1001081801_22",
        Content = "    每一步的发现，都让我既兴奋又恐惧。\r&    直到西斯廷枢机士，用我无法辩驳的证据，为我这漫长的朝圣之路，画上了终点。\r&    他证明了那个超越我们理解的存在，那个我们称之为“上帝之眸”的力量，是真实的。&    作为一个雅弗人，一个毕生追求知识与真相的学者，我理应为此狂喜——&    我们追寻了千年的神，终于露出了祂存在的科学证据。&    可是，当我看到那证据的核心时，我感到的不是敬畏，而是一种……源自生命本能的恐惧。&    柯西莫……你为何……要将“它”托付于我？",
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
        Type = 1,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "",
        FirstLinePos = -300,
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
        ContentLanguageId = "1001081801_23",
        Content = "    如果神的存在，是以那样的方式被证实……\r&    如果那“慈爱的注视”背后，是那样一种本质……\r&    那么，我们数千年的虔诚，我们所有的祈祷与奉献，究竟指向了什么？&    西斯廷阁下走在了一条通往神圣真相的、义无反顾的路上。&    而我没有他那般坚定的信仰，或者说，我没有他那般承受真相的勇气。&    我是个懦夫，我既无法全身心地信奉神，也无法抵抗证明它的诱惑。&    我无法背叛我的挚友，若必须将“它”公示给所有人才能证明神，那么不如让我自己成为“羔羊”。",
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
        Type = 1,
        ShowEffect = {
          Enable = true,
          AnimTime = 0.6
        },
        HideEffect = {
          AnimTime = 0.6
        },
        CharName = "",
        FirstLinePos = -300,
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
        ContentLanguageId = "1001081801_24",
        Content = "    若神当真存在，现在……我将于它的注视下沉眠……&    我既希望得到永恒的安宁，也希望能被慈爱的祂能给予我真正的慈悲。&    现在，看到这封信的你，已经看到了我……我的肉体，我的灵魂。&    我的结局是什么？我是否成为了证明神存在的论据？&    无论结果如何，已经同样走完朝圣之路的你，拥有使用这个真相的资格。&    请原谅我的懦弱。也请你……谨慎地使用你即将发现的真相。&    愿你的灵魂，能找到真正的安宁。&\n                                                                                                                                      乌菲齐。",
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
        Image = "StoryBg8_38",
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
        ContentLanguageId = "1001081801_49",
        Content = "……",
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
        ContentLanguageId = "1001081801_50",
        Content = "信中的字句充满了绝望后的释然与托付。",
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
        ContentLanguageId = "1001081801_51",
        Content = "与此同时，贝尔蒂丝已经小心地取出了乌菲齐怀中的那幅画。",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            IsBGM = true,
            Sound = "storybgm_072",
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
        ContentLanguageId = "1001081801_53",
        Content = "这并非只是一幅简单的画，它的横截宽度非比寻常，更像是一个盒子上印着一幅画作。",
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
        ContentLanguageId = "1001081801_54",
        Content = "贝尔蒂丝轻轻一动，便发现画框下方是一个隐藏的活页。她只是掀开一条缝隙，匆匆向内瞥了一眼，脸色瞬间变得无比苍白，仿佛看到了世间最恐怖的景象。",
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
        ContentLanguageId = "1001081801_55",
        Content = "她几乎是条件反射般地猛地将盖子合上。",
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
            ContentLanguageId = "1001081801_57",
            Content = "那里面是？",
            Jump = 56
          }
        },
        LimitTime = 8.0,
        TimeBarEffectName = "Ani_VX_TimeBar"
      }
    },
    {
      JumpId = 56,
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
        ContentLanguageId = "1001081801_58",
        Content = "我刚想询问那是否就是传说中的《上帝之眸》。",
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
        ContentLanguageId = "1001081801_59",
        Content = "就在这时——",
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
        ContentLanguageId = "1001081801_60",
        Content = "“窸窣……窣……”",
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
        Image = "StoryBg8_39",
        BgScale = 1.0,
        InsertAnimList = empty,
        FadeTime = 1.5,
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
            Enable = true,
            AnimTime = 0.6
          },
          HideEffect = {
            Enable = true,
            AnimTime = 0.6
          }
        },
        ContentLanguageId = "1001081801_61",
        Content = "金属摩擦的声音……从我们来时的阶梯方向传来。",
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
        ContentLanguageId = "1001081801_62",
        Content = "地宫入口的阴影处，一个高大、闪烁着冰冷金属光泽的身影，如同鬼魅般悄然显现——",
        NoteTextPos = 1,
        BgTalkPos = empty,
        BgTalkSetPos = empty,
      },
      Sound = {
        MaxSoundNum = 3,
        SoundDatas = {
          {
            Sound = "sfx_chapter02_16",
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
    }
  },
}