local BaseMainFSM = strictclass("BaseMainFSM", require("framework.fsm"))

function BaseMainFSM:Init()
  BaseMainFSM.super.Init(self)
  self._parameters = {
    toDeeplink = false,
    toFirstAward = true,
    toAccount = true,
    storyId = 0,
    toStory = false,
    toNormal = false,
    toUnloadStory = false,
    startDialogId = 0,
    returnwelfareBegin = false,
    welfareBegin = false,
    totleSignBrgin = false,
    toMonthCardDailyReward = false,
    resonanceBegin = false,
    toSimpleShow = false,
    noticeBegin = false,
    autoPopUpGift = false,
    witchSkillGuideId = 0,
    toFunctionUnlock = false,
    haveFSMHandleOrMainCityGuide = false,
    mainFSMEnd = false
  }
  self._states = {
    "Init",
    "Normal",
    "DeepLink",
    "FirstAward",
    "Account",
    "LoadStory",
    "Story",
    "UnloadStory",
    "GuideDialog",
    "ReturnWelfare",
    "Welfare",
    "TotleSign",
    "MonthCardDailyReward",
    "Resonance",
    "SimpleShow",
    "Notice",
    "PopUpGift",
    "WitchSkillGuide",
    "FunctionUnlock",
    "OpenPreMainCityBattleDialog"
  }
  self._transGraphs = {
    {
      from = "Init",
      to = "Normal",
      conditions = {
        {
          parameterName = "toNormal",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "Normal",
      to = "FirstAward",
      conditions = {
        {
          parameterName = "toFirstAward",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "FirstAward",
      to = "Account",
      conditions = {
        {
          parameterName = "toFirstAward",
          op = "eq",
          value = false
        },
        {
          parameterName = "toAccount",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "Normal",
      to = "LoadStory",
      conditions = {
        {
          parameterName = "toAccount",
          op = "eq",
          value = false
        },
        {
          parameterName = "storyId",
          op = "ne",
          value = 0
        },
        {
          parameterName = "storyId",
          op = "ne",
          value = 2002
        }
      }
    },
    {
      from = "Account",
      to = "LoadStory",
      conditions = {
        {
          parameterName = "toAccount",
          op = "eq",
          value = false
        },
        {
          parameterName = "storyId",
          op = "ne",
          value = 0
        },
        {
          parameterName = "storyId",
          op = "ne",
          value = 2002
        }
      }
    },
    {
      from = "LoadStory",
      to = "Story",
      conditions = {
        {
          parameterName = "toStory",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "Story",
      to = "UnloadStory",
      conditions = {
        {
          parameterName = "toUnloadStory",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "Account",
      to = "GuideDialog",
      conditions = {
        {
          parameterName = "toAccount",
          op = "eq",
          value = false
        },
        {
          parameterName = "startDialogId",
          op = "ne",
          value = 0
        },
        {
          parameterName = "storyId",
          op = "eq",
          value = 0
        }
      }
    },
    {
      from = "Account",
      to = "GuideDialog",
      conditions = {
        {
          parameterName = "toAccount",
          op = "eq",
          value = false
        },
        {
          parameterName = "startDialogId",
          op = "ne",
          value = 0
        },
        {
          parameterName = "storyId",
          op = "eq",
          value = 2002
        }
      }
    },
    {
      from = "UnloadStory",
      to = "GuideDialog",
      conditions = {
        {
          parameterName = "startDialogId",
          op = "ne",
          value = 0
        },
        {
          parameterName = "storyId",
          op = "eq",
          value = 0
        },
        {
          parameterName = "toNormal",
          op = "eq",
          value = false
        }
      }
    },
    {
      from = "GuideDialog",
      to = "ReturnWelfare",
      conditions = {
        {
          parameterName = "startDialogId",
          op = "eq",
          value = 0
        },
        {
          parameterName = "returnwelfareBegin",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "ReturnWelfare",
      to = "Welfare",
      conditions = {
        {
          parameterName = "returnwelfareBegin",
          op = "eq",
          value = false
        },
        {
          parameterName = "welfareBegin",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "Welfare",
      to = "TotleSign",
      conditions = {
        {
          parameterName = "welfareBegin",
          op = "eq",
          value = false
        },
        {
          parameterName = "totleSignBrgin",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "TotleSign",
      to = "MonthCardDailyReward",
      conditions = {
        {
          parameterName = "totleSignBrgin",
          op = "eq",
          value = false
        },
        {
          parameterName = "toMonthCardDailyReward",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "MonthCardDailyReward",
      to = "Resonance",
      conditions = {
        {
          parameterName = "toMonthCardDailyReward",
          op = "eq",
          value = false
        },
        {
          parameterName = "resonanceBegin",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "Resonance",
      to = "SimpleShow",
      conditions = {
        {
          parameterName = "resonanceBegin",
          op = "eq",
          value = false
        },
        {
          parameterName = "toSimpleShow",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "SimpleShow",
      to = "Notice",
      conditions = {
        {
          parameterName = "toSimpleShow",
          op = "eq",
          value = false
        },
        {
          parameterName = "noticeBegin",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "Notice",
      to = "PopUpGift",
      conditions = {
        {
          parameterName = "noticeBegin",
          op = "eq",
          value = false
        },
        {
          parameterName = "autoPopUpGift",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "PopUpGift",
      to = "WitchSkillGuide",
      conditions = {
        {
          parameterName = "autoPopUpGift",
          op = "eq",
          value = false
        },
        {
          parameterName = "witchSkillGuideId",
          op = "ne",
          value = 0
        }
      }
    },
    {
      from = "WitchSkillGuide",
      to = "FunctionUnlock",
      conditions = {
        {
          parameterName = "witchSkillGuideId",
          op = "eq",
          value = 0
        },
        {
          parameterName = "toFunctionUnlock",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "FunctionUnlock",
      to = "Normal",
      conditions = {
        {
          parameterName = "toFunctionUnlock",
          op = "eq",
          value = false
        },
        {
          parameterName = "toNormal",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "DeepLink",
      to = "Normal",
      conditions = {
        {
          parameterName = "toDeeplink",
          op = "eq",
          value = false
        },
        {
          parameterName = "toNormal",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "Normal",
      to = "DeepLink",
      conditions = {
        {
          parameterName = "toDeeplink",
          op = "eq",
          value = true
        },
        {
          parameterName = "toNormal",
          op = "eq",
          value = false
        }
      }
    },
    {
      from = "UnloadStory",
      to = "Normal",
      conditions = {
        {
          parameterName = "storyId",
          op = "eq",
          value = 0
        },
        {
          parameterName = "toNormal",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "Normal",
      to = "OpenPreMainCityBattleDialog",
      conditions = {
        {
          parameterName = "haveFSMHandleOrMainCityGuide",
          op = "eq",
          value = false
        },
        {
          parameterName = "mainFSMEnd",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "OpenPreMainCityBattleDialog",
      to = "Normal",
      conditions = {
        {
          parameterName = "haveFSMHandleOrMainCityGuide",
          op = "eq",
          value = false
        },
        {
          parameterName = "mainFSMEnd",
          op = "eq",
          value = false
        }
      }
    },
    {
      from = "Account",
      to = "Normal",
      conditions = {
        {
          parameterName = "toAccount",
          op = "eq",
          value = false
        },
        {
          parameterName = "startDialogId",
          op = "eq",
          value = 0
        },
        {
          parameterName = "storyId",
          op = "eq",
          value = 0
        },
        {
          parameterName = "toNormal",
          op = "eq",
          value = true
        }
      }
    }
  }
  self._initialState = "Init"
  self:CheckError()
end

return BaseMainFSM
