-- chunkname: @modules/logic/monthcard/view/VersionActivity3_8FreeMonthCardFullViewContainer.lua

module("modules.logic.monthcard.view.VersionActivity3_8FreeMonthCardFullViewContainer", package.seeall)

local VersionActivity3_8FreeMonthCardFullViewContainer = class("VersionActivity3_8FreeMonthCardFullViewContainer", BaseViewContainer)

function VersionActivity3_8FreeMonthCardFullViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_8FreeMonthCardFullView.New())

	return views
end

return VersionActivity3_8FreeMonthCardFullViewContainer
