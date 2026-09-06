-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/model/WaterTianYanEnum.lua

module("logic.extensions.watertianyan.data.WaterTianYanEnum", package.seeall)

local WaterTianYanEnum = {}

WaterTianYanEnum.ViewTypes_MainView = "mainview"
WaterTianYanEnum.ViewTypes_ClgMainView = "clgmainview"
WaterTianYanEnum.ViewTypes_ClgBuildView = "clgbuildview"
WaterTianYanEnum.ViewTypes_BuffView = "buffview"
WaterTianYanEnum.ViewTypes_TipView = "tipview"
WaterTianYanEnum.ViewNames = {
	[305001] = {
		[WaterTianYanEnum.ViewTypes_MainView] = ViewName.WaterTianYanMainView,
		[WaterTianYanEnum.ViewTypes_ClgMainView] = ViewName.WaterTianYanClgMainView,
		[WaterTianYanEnum.ViewTypes_ClgBuildView] = ViewName.WaterTianYanClgBuildView,
		[WaterTianYanEnum.ViewTypes_BuffView] = ViewName.WaterTianYanBuffView,
		[WaterTianYanEnum.ViewTypes_TipView] = ViewName.WaterTianYanTipView
	},
	[305002] = {
		[WaterTianYanEnum.ViewTypes_MainView] = ViewName.MiracleDiShiTianMainView,
		[WaterTianYanEnum.ViewTypes_ClgMainView] = ViewName.MiracleDiShiTianClgMainView,
		[WaterTianYanEnum.ViewTypes_ClgBuildView] = ViewName.MiracleDiShiTianClgBuildView,
		[WaterTianYanEnum.ViewTypes_BuffView] = ViewName.MiracleDiShiTianBuffView,
		[WaterTianYanEnum.ViewTypes_TipView] = ViewName.MiracleDiShiTianTipView
	},
	[305003] = {
		[WaterTianYanEnum.ViewTypes_MainView] = ViewName.DivineMiuKeMainView,
		[WaterTianYanEnum.ViewTypes_ClgMainView] = ViewName.DivineMiuKeClgMainView,
		[WaterTianYanEnum.ViewTypes_ClgBuildView] = ViewName.DivineMiuKeClgBuildView,
		[WaterTianYanEnum.ViewTypes_BuffView] = ViewName.DivineMiuKeBuffView,
		[WaterTianYanEnum.ViewTypes_TipView] = ViewName.DivineMiuKeTipView
	}
}

return WaterTianYanEnum
