-- chunkname: @modules/logic/summon/defines/SummonEnum.lua

module("modules.logic.summon.defines.SummonEnum", package.seeall)

local SummonEnum = _M

SummonEnum.SummonSceneId = 501
SummonEnum.SummonEquipSceneId = 502
SummonEnum.SummonCharScenePath = "scenes/v3a4_m_s06_summon/v3a4_m_s06_summon_p.prefab"
SummonEnum.SummonEquipPreloadPath = {
	EquipUISR = "scenes/m_s03_xx/s03_ui_sr.prefab",
	EquipBoomR = "scenes/m_s03_xx/equip_r.prefab",
	EquipUIN = "scenes/m_s03_xx/s03_ui_n.prefab",
	EquipBoomN = "scenes/m_s03_xx/equip_n.prefab",
	EquipUISSR = "scenes/m_s03_xx/s03_ui_ssr.prefab",
	EquipUIR = "scenes/m_s03_xx/s03_ui_r.prefab",
	EquipBoomSR = "scenes/m_s03_xx/equip_sr.prefab",
	EquipBoomSSR = "scenes/m_s03_xx/equip_ssr.prefab"
}
SummonEnum.SummonCharPreloadPath = {
	UIN = "scenes/m_s06_summon/s06_ui_n.prefab",
	SceneSRStep1 = "scenes/m_s06_summon/s06_effect_sr_chuxian_1.prefab",
	UIR = "scenes/m_s06_summon/s06_ui_r.prefab",
	SceneNWheel = "scenes/m_s06_summon/s06_effect_n_lunzhuan.prefab",
	SceneRStep3 = "scenes/m_s06_summon/s06_effect_r_chuxian_3.prefab",
	SceneSSRStep2 = "scenes/m_s06_summon/s06_effect_ssr_chuxian_2.prefab",
	SceneSSRStep1 = "scenes/m_s06_summon/s06_effect_ssr_chuxian_1.prefab",
	SceneSSRWheel = "scenes/m_s06_summon/s06_effect_ssr_lunzhuan.prefab",
	SceneRWheel = "scenes/m_s06_summon/s06_effect_r_lunzhuan.prefab",
	SceneRollWaterL = "scenes/m_s06_summon/s06_effect_ssr_shuihua_zuo.prefab",
	SceneRStep1 = "scenes/m_s06_summon/s06_effect_r_chuxian_1.prefab",
	SceneNBoom = "scenes/m_s06_summon/s06_effect_n_baofa.prefab",
	SceneRStep2 = "scenes/m_s06_summon/s06_effect_r_chuxian_2.prefab",
	SceneSRStep3 = "scenes/m_s06_summon/s06_effect_sr_chuxian_3.prefab",
	SceneNStep3 = "scenes/m_s06_summon/s06_effect_n_chuxian_3.prefab",
	SceneSRBoom = "scenes/m_s06_summon/s06_effect_sr_baofa.prefab",
	UISSR = "scenes/m_s06_summon/s06_ui_ssr.prefab",
	SceneRBoom = "scenes/m_s06_summon/s06_effect_r_baofa.prefab",
	SceneSSRStep3 = "scenes/m_s06_summon/s06_effect_ssr_chuxian_3.prefab",
	UISR = "scenes/m_s06_summon/s06_ui_sr.prefab",
	SceneSRWheel = "scenes/m_s06_summon/s06_effect_sr_lunzhuan.prefab",
	SceneRollWaterR = "scenes/m_s06_summon/s06_effect_ssr_shuihua_you.prefab",
	SceneSSRBoom = "scenes/m_s06_summon/s06_effect_ssr_baofa.prefab",
	SceneSRStep2 = "scenes/m_s06_summon/s06_effect_sr_chuxian_2.prefab",
	SceneNStep1 = "scenes/m_s06_summon/s06_effect_n_chuxian_1.prefab",
	SceneNStep2 = "scenes/m_s06_summon/s06_effect_n_chuxian_2.prefab"
}
SummonEnum.SummonLuckyBagPreloadPath = {
	UILuckyBag = "scenes/m_s06_summon/s06_ui_luckybag.prefab"
}
SummonEnum.SummonPreloadPath = tabletool.copy(SummonEnum.SummonEquipPreloadPath)

for k, v in pairs(SummonEnum.SummonCharPreloadPath) do
	SummonEnum.SummonPreloadPath[k] = v
end

SummonEnum.SummonQualityDefine = {
	"N",
	"N",
	"R",
	"SR",
	"SSR"
}
SummonEnum.TenAnimationName = "m_s06_summon_anim_a"
SummonEnum.SingleAnimationName = "m_s06_summon_anim_b"
SummonEnum.EquipTenAnimationName = "m_s03_xx_p_a"
SummonEnum.EquipSingleAnimationName = "m_s03_xx_p_b"
SummonEnum.SummonSkipCharacterAnimationName = "m_s06_summon_anim_c"
SummonEnum.SummonSkipAnimationName = "none"
SummonEnum.InitialStateAnimationName = "m_s06_summon_anim_in"
SummonEnum.InitialStateEquipAnimationName = "m_s03_xx_p_in"
SummonEnum.GuideInitialStateAnimationName = "m_s06_summon_anim_story02"
SummonEnum.SummonOpenAnimationName = "m_s06_summon_anim_story01"
SummonEnum.SummonFogAnimationName = "m_s06_summon_anim_story02"
SummonEnum.SummonWheelAnimationName = "m_s06_summon_anim_story03"
SummonEnum.SummonCharAnimationEnter = "open"
SummonEnum.SummonCharAnimationSwitch = "switch"
SummonEnum.SummonEquipAnimationSwitch = "switch"
SummonEnum.AnimationName = {
	[SummonEnum.SummonPreloadPath.UIN] = "m_s06_summon_anim_b04",
	[SummonEnum.SummonPreloadPath.UIR] = "m_s06_summon_anim_b03",
	[SummonEnum.SummonPreloadPath.UISR] = "m_s06_summon_anim_b02",
	[SummonEnum.SummonPreloadPath.UISSR] = "m_s06_summon_anim_b01",
	[SummonEnum.SummonPreloadPath.EquipUIN] = "m_s06_summon_anim_b04",
	[SummonEnum.SummonPreloadPath.EquipUIR] = "m_s06_summon_anim_b03",
	[SummonEnum.SummonPreloadPath.EquipUISR] = "m_s06_summon_anim_b02",
	[SummonEnum.SummonPreloadPath.EquipUISSR] = "m_s06_summon_anim_b01",
	[SummonEnum.SummonLuckyBagPreloadPath.UILuckyBag] = "m_s06_summon_anim_b01"
}
SummonEnum.UIMaterialPath = {
	[SummonEnum.SummonPreloadPath.UIN] = {
		"s06_ui_obj_a/s06_ui_obj_d001",
		"s06_ui_obj_a_mirror/s06_ui_obj_d001"
	},
	[SummonEnum.SummonPreloadPath.UIR] = {
		"s06_ui_obj_a/s06_ui_obj_c001",
		"s06_ui_obj_a_mirror/s06_ui_obj_c001"
	},
	[SummonEnum.SummonPreloadPath.UISR] = {
		"s06_ui_obj_a/s06_ui_obj_b001",
		"s06_ui_obj_a_mirror/s06_ui_obj_b001"
	},
	[SummonEnum.SummonPreloadPath.UISSR] = {
		"s06_ui_obj_a/s06_ui_obj_a001",
		"s06_ui_obj_a_mirror/s06_ui_obj_a001"
	},
	[SummonEnum.SummonPreloadPath.EquipUIN] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[SummonEnum.SummonPreloadPath.EquipUIR] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[SummonEnum.SummonPreloadPath.EquipUISR] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[SummonEnum.SummonPreloadPath.EquipUISSR] = {
		"s03_ui_obj_a/s03_ui_obj_a001"
	},
	[SummonEnum.SummonLuckyBagPreloadPath.UILuckyBag] = {
		"s06_ui_obj_a",
		"s06_ui_obj_a_mirror"
	}
}
SummonEnum.BoomEquipEffectAnimationName = {
	[SummonEnum.SummonPreloadPath.EquipBoomN] = "s03_ui_ssr_in",
	[SummonEnum.SummonPreloadPath.EquipBoomR] = "s03_ui_ssr_in",
	[SummonEnum.SummonPreloadPath.EquipBoomSR] = "s03_ui_ssr_in",
	[SummonEnum.SummonPreloadPath.EquipBoomSSR] = "s03_ui_ssr_in"
}
SummonEnum.EquipUIAnim = {
	RootGachaStartRare3 = "_white",
	RootGachaIn = "go_controller_in",
	LightGacha10 = "shiying02_x10_in",
	RootGachaStartRare4 = "_purple",
	RootGachaStartRare5 = "_golden",
	RootGachaStart1Prefix = "go_controller_summonequip_x1",
	RootGachaStart10Prefix = "go_controller_summonequip_x10",
	LightGacha1 = "shiying01_x1_in"
}
SummonEnum.EquipFloatIconFrameNode = "s03_ui_obj_a"
SummonEnum.EquipFloatIconFrameBeforeOpen = "scenes/dynamic/m_s03_xx/textures/m_s03_ui_obj.png"
SummonEnum.EquipFloatIconFrameOpened = "scenes/dynamic/m_s03_xx/textures/m_s03_ui_open.png"
SummonEnum.EquipDefaultIconPath = "singlebg/summon/equip/xray.png"
SummonEnum.Type = {
	CustomPick = 7,
	StrongCustomOnePick = 12,
	Newbie = 1,
	LuckyBag = 5,
	MultiProbUp4 = 4,
	CoBranding = 21,
	ProbUp = 3,
	Limit = 6,
	Normal = 2
}
SummonEnum.ResultType = {
	Char = 1,
	Equip = 2,
	MaxCount = 2
}
SummonEnum.SummonCallingType = {
	Summon = 1,
	SummonSimulation = 2
}
SummonEnum.TabContentIndex = {
	CharNormal = 1,
	CharNewbie = 3,
	EquipNormal = 2,
	EquipProbUp = 5,
	CharProbUp = 4
}
SummonEnum.Type2PageIndex = {
	SummonEnum.TabContentIndex.CharNewbie,
	SummonEnum.TabContentIndex.CharNormal,
	SummonEnum.TabContentIndex.CharProbUp,
	SummonEnum.TabContentIndex.CharProbUp,
	SummonEnum.TabContentIndex.CharProbUp,
	SummonEnum.TabContentIndex.CharProbUp,
	SummonEnum.TabContentIndex.CharProbUp,
	[10] = SummonEnum.TabContentIndex.EquipNormal,
	[11] = SummonEnum.TabContentIndex.EquipProbUp,
	[21] = SummonEnum.TabContentIndex.CharProbUp
}
SummonEnum.Type2Result = {
	SummonEnum.ResultType.Char,
	SummonEnum.ResultType.Char,
	SummonEnum.ResultType.Char,
	SummonEnum.ResultType.Char,
	SummonEnum.ResultType.Char,
	SummonEnum.ResultType.Char,
	SummonEnum.ResultType.Char,
	[10] = SummonEnum.ResultType.Equip,
	[11] = SummonEnum.ResultType.Equip
}
SummonEnum.GuidePoolId = 2
SummonEnum.GuideIdSet = {
	[163] = 1,
	[103] = 1
}
SummonEnum.HistoryColor = {
	"#272525bf",
	"#272525bf",
	"#272525bf",
	"#aa7e1d",
	"#bc4d02"
}
SummonEnum.HistoryNameStarFormat = {
	"%s",
	"%s",
	"%s",
	"%s(5    )",
	"%s(6    )"
}
SummonEnum.DetailParagraphType = {
	SpaceOne = 1,
	Normal = 0
}
SummonEnum.BannerFlagType = {
	Limit = 3,
	Activity = 2,
	LimitReprint = 6,
	Cobrand = 5,
	Reprint = 4,
	Newbie = 1
}
SummonEnum.TenSummonAgainOpen = false
SummonEnum.MultiProbUp4ShowRate = 25
SummonEnum.LuckyBagRare = 5
SummonEnum.CustomPickRare = 5
SummonEnum.PoolId = {
	Normal = 2,
	QuNiang = 16111
}
SummonEnum.ChooseNeedFirstHeroIds = {
	3025
}
SummonEnum.ChooseNeedMiddleHeroIds = {
	3108
}
SummonEnum.CurrencyShowAddItemIds = {
	140001,
	140002
}
SummonEnum.CharacterCoBrandingGiftView = {
	SummonCharacterCoBranding291 = "V2a9_LinkGiftView2",
	SummonCharacterCoBranding292 = "V2a9_LinkGiftView"
}
SummonEnum.ShowHighStoreById = {
	[33171] = true
}
SummonEnum.InfallibleItemState = {
	Using = 1,
	Unused = 0,
	Used = 2
}
SummonEnum.OldNewBiePoolId = {
	[1] = true
}
SummonEnum.NewbieFinishSortOrder = 100
SummonEnum.DefaultTagStyle = 1

return SummonEnum
