-- chunkname: @modules/logic/monthcard/view/VersionActivity3_8FreeMonthCardTaskViewContainer.lua

module("modules.logic.monthcard.view.VersionActivity3_8FreeMonthCardTaskViewContainer", package.seeall)

local VersionActivity3_8FreeMonthCardTaskViewContainer = class("VersionActivity3_8FreeMonthCardTaskViewContainer", BaseViewContainer)

function VersionActivity3_8FreeMonthCardTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_8FreeMonthCardTaskView.New())

	return views
end

return VersionActivity3_8FreeMonthCardTaskViewContainer
