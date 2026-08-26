-- chunkname: @modules/logic/commonbufftip/CommonBuffTipEnum.lua

module("modules.logic.commonbufftip.CommonBuffTipEnum", package.seeall)

local CommonBuffTipEnum = _M

CommonBuffTipEnum.Pivot = {
	Left = Vector2(0, 1),
	Right = Vector2(1, 1),
	Down = Vector2(1, 0),
	Center = Vector2(0.5, 0.5)
}
CommonBuffTipEnum.DefaultInterval = 50
CommonBuffTipEnum.BottomMargin = 50
CommonBuffTipEnum.TipWidth = 560
CommonBuffTipEnum.Anchor = {
	[ViewName.SkillTipView] = Vector2(-303.39, 57.22754),
	[ViewName.SkillTipView3] = Vector2(-303.39, 57.22754),
	[ViewName.FightFocusView] = Vector2(-225.47, 117.6),
	[ViewName.CharacterExSkillView] = Vector2(98.11, 266.6),
	[ViewName.V2a1_BossRush_OfferRoleView] = Vector2(-180, 100),
	[ViewName.TowerAssistBossTalentView] = Vector2(341, -210),
	[ViewName.TowerSkillTipView] = Vector2(874, 279)
}

return CommonBuffTipEnum
