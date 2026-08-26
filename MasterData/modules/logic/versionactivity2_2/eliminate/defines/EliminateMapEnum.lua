-- chunkname: @modules/logic/versionactivity2_2/eliminate/defines/EliminateMapEnum.lua

module("modules.logic.versionactivity2_2.eliminate.defines.EliminateMapEnum", package.seeall)

local EliminateMapEnum = class("EliminateMapEnum")

EliminateMapEnum.DefaultChapterId = 1
EliminateMapEnum.MapViewChapterUnlockDuration = 0.5
EliminateMapEnum.MapViewOpenAnimLength = 0.667
EliminateMapEnum.ChapterStatus = {
	notOpen = 1,
	Lock = 3,
	Normal = 0
}
EliminateMapEnum.SortType = {
	Resource = 3,
	Rare = 1,
	Power = 2
}
EliminateMapEnum.PrefsKey = {
	RoleSelected = 3,
	RoleUnlock = 1,
	ChessUnlock = 2,
	ChessSelected = 4
}
EliminateMapEnum.TxtNormalPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#FEE5CD")
EliminateMapEnum.TxtNormalUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#C5C5C5")
EliminateMapEnum.TxtBossPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#FFEEE4")
EliminateMapEnum.TxtBossUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#DEC3BC")
EliminateMapEnum.NormalPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#CC7620")
EliminateMapEnum.NormalUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#947B63")
EliminateMapEnum.BossPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#D34A3D")
EliminateMapEnum.BossUnPassedColor = SLFramework.UGUI.GuiHelper.ParseColor("#A37C78")

return EliminateMapEnum
