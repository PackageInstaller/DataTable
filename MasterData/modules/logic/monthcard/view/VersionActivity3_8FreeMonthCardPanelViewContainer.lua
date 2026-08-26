-- chunkname: @modules/logic/monthcard/view/VersionActivity3_8FreeMonthCardPanelViewContainer.lua

module("modules.logic.monthcard.view.VersionActivity3_8FreeMonthCardPanelViewContainer", package.seeall)

local VersionActivity3_8FreeMonthCardPanelViewContainer = class("VersionActivity3_8FreeMonthCardPanelViewContainer", BaseViewContainer)

function VersionActivity3_8FreeMonthCardPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_8FreeMonthCardPanelView.New())

	return views
end

return VersionActivity3_8FreeMonthCardPanelViewContainer
