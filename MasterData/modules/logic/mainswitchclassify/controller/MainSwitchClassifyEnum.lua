-- chunkname: @modules/logic/mainswitchclassify/controller/MainSwitchClassifyEnum.lua

module("modules.logic.mainswitchclassify.controller.MainSwitchClassifyEnum", package.seeall)

local MainSwitchClassifyEnum = _M

MainSwitchClassifyEnum.Classify = {
	UI = 2,
	Scene = 1,
	Summon = 4,
	Click = 3
}
MainSwitchClassifyEnum.StyleClassifyInfo = {
	[MainSwitchClassifyEnum.Classify.Scene] = {
		Sort = 1,
		Logo = "mainsceneswitch_logo",
		Title = "main_switch_classify_title_1",
		Classify = MainSwitchClassifyEnum.Classify.Scene
	},
	[MainSwitchClassifyEnum.Classify.UI] = {
		Sort = 2,
		Logo = "mainsceneswitch_logo03",
		Title = "main_switch_classify_title_2",
		Classify = MainSwitchClassifyEnum.Classify.UI
	},
	[MainSwitchClassifyEnum.Classify.Click] = {
		Sort = 3,
		Logo = "mainsceneswitch_logo04",
		Title = "main_switch_classify_title_3",
		Classify = MainSwitchClassifyEnum.Classify.Click
	},
	[MainSwitchClassifyEnum.Classify.Summon] = {
		Sort = 4,
		Logo = "mainsceneswitch_logo05",
		Title = "main_switch_classify_title_4",
		Classify = MainSwitchClassifyEnum.Classify.Summon
	}
}
MainSwitchClassifyEnum.ItemInfo = {
	[ItemEnum.SubType.SceneUIPackage] = {
		Logo = "mainsceneswitch_logo06",
		LogoAnchor = {
			x = -560,
			y = 290
		}
	},
	[ItemEnum.SubType.MainSceneSkin] = {
		Logo = "mainsceneswitch_logo",
		Classify = MainSwitchClassifyEnum.Classify.Scene,
		LogoAnchor = {
			x = -510,
			y = 290
		}
	},
	[ItemEnum.SubType.MainUISkin] = {
		Logo = "mainsceneswitch_logo03",
		Classify = MainSwitchClassifyEnum.Classify.UI,
		LogoAnchor = {
			x = -560,
			y = 290
		}
	}
}
MainSwitchClassifyEnum.SwitchAnimDelayTime = 0
MainSwitchClassifyEnum.ClassifyShowInfo = {
	[MainSwitchClassifyEnum.Classify.UI] = {
		TitleLogo = "mainsceneswitch_logo03",
		Classify = MainSwitchClassifyEnum.Classify.UI
	},
	[MainSwitchClassifyEnum.Classify.Click] = {
		TitleLogo = "mainsceneswitch_logo04",
		Classify = MainSwitchClassifyEnum.Classify.Click
	}
}

return MainSwitchClassifyEnum
