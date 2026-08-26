-- chunkname: @modules/logic/monthcard/define/MonthCardViewDefine.lua

module("modules.logic.monthcard.define.MonthCardViewDefine", package.seeall)

local MonthCardViewDefine = {}

function MonthCardViewDefine.init(module_views)
	module_views.V2a9_FreeMonthCard_PanelView = {
		destroy = 0,
		container = "V2a9_FreeMonthCard_PanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/activity/v2a9_monthcard_panelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.V2a9_FreeMonthCard_FullView = {
		destroy = 0,
		container = "V2a9_FreeMonthCard_FullViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/activity/v2a9_monthcard_fullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.VersionActivity3_8FreeMonthCardPanelView = {
		destroy = 0,
		container = "VersionActivity3_8FreeMonthCardPanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/freemonthcard/v3a8_monthcard_panelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.VersionActivity3_8FreeMonthCardFullView = {
		destroy = 0,
		container = "VersionActivity3_8FreeMonthCardFullViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/freemonthcard/v3a8_monthcard_fullview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.VersionActivity3_8FreeMonthCardTaskView = {
		destroy = 0,
		container = "VersionActivity3_8FreeMonthCardTaskViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/freemonthcard/v3a8_monthcard_taskview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default
	}
end

return MonthCardViewDefine
