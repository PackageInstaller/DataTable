-- chunkname: @modules/logic/activitywelfare/subview/VersionActivity3_8NoviceSignViewContainer.lua

module("modules.logic.activitywelfare.subview.VersionActivity3_8NoviceSignViewContainer", package.seeall)

local VersionActivity3_8NoviceSignViewContainer = class("VersionActivity3_8NoviceSignViewContainer", BaseViewContainer)

function VersionActivity3_8NoviceSignViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_8NoviceSignView.New())

	return views
end

return VersionActivity3_8NoviceSignViewContainer
