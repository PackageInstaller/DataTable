-- chunkname: @modules/logic/decorate/define/DecorateEnum.lua

module("modules.logic.decorate.define.DecorateEnum", package.seeall)

local DecorateEnum = _M

DecorateEnum.DecorateUIParams = {
	[ItemEnum.SubType.SceneUIPackage] = {
		Tag = "p_mainsceneswitchview_title_2",
		Title = "p_mainsceneskinmaterialtipview2_txt_tab1"
	},
	[ItemEnum.SubType.MainSceneSkin] = {
		Tag = "p_mainsceneswitchview_title_2",
		Title = "main_switch_classify_title_1"
	},
	[ItemEnum.SubType.MainUISkin] = {
		Tag = "p_mainsceneswitchview_title_2",
		Title = "main_switch_classify_title_2"
	},
	[ItemEnum.SubType.FightCard] = {
		Tag = "p_mainsceneswitchview_title_3",
		Title = "fightuiswitch_classify_2"
	},
	[ItemEnum.SubType.FightFloatType] = {
		Tag = "p_mainsceneswitchview_title_3",
		Title = "fightuiswitch_classify_1"
	},
	[ItemEnum.SubType.PlayerBg] = {
		Title = "main_switch_classify_title_5"
	},
	[ItemEnum.SubType.Portrait] = {
		IsShowHeadBg = true,
		Title = "main_switch_classify_title_7"
	}
}
DecorateEnum.SceneStutas = {
	Unlock = 1,
	Lock = 2,
	LockCanGet = 3
}

return DecorateEnum
