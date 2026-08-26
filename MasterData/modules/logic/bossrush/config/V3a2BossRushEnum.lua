-- chunkname: @modules/logic/bossrush/config/V3a2BossRushEnum.lua

module("modules.logic.bossrush.config.V3a2BossRushEnum", package.seeall)

local V3a2BossRushEnum = _M

V3a2BossRushEnum.BossRankExp = "V3a2BossRushEnum_BossRankExp1_"
V3a2BossRushEnum.BossRankLockCount = 1
V3a2BossRushEnum.BossRankExpCurrencyConst = 10
V3a2BossRushEnum.RankLv = {
	Light = {
		iconStatus = "v3a2_bossrush_icon_pointlight2",
		txtColor = "#DB7D29"
	},
	Gray = {
		iconStatus = "v3a2_bossrush_icon_pointdark2",
		txtColor = "#838383"
	}
}
V3a2BossRushEnum.ResultRecord = {
	Normal = "v1a4_bossrush_resultview_txt_score",
	New = "v1a4_bossrush_resultview_txt_newrecord"
}
V3a2BossRushEnum.AnimName = {
	Switch = "switch",
	Lingqu = "lingqu",
	Unlock = "unlock",
	Idle = "idle"
}
V3a2BossRushEnum.AnimEventName = {
	PlayAudio_Appraise = "PlayAudio_Appraise",
	RecordScore = "RecordScore"
}
V3a2BossRushEnum.Variant = {
	[10] = "ui/materials/dynamic/ui_headicon_stylization_10.mat"
}

return V3a2BossRushEnum
