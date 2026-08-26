-- chunkname: @modules/logic/activitywelfare/subview/VersionActivity3_8NewWelfareViewContainer.lua

module("modules.logic.activitywelfare.subview.VersionActivity3_8NewWelfareViewContainer", package.seeall)

local VersionActivity3_8NewWelfareViewContainer = class("VersionActivity3_8NewWelfareViewContainer", BaseViewContainer)

function VersionActivity3_8NewWelfareViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_8NewWelfareView.New())

	return views
end

return VersionActivity3_8NewWelfareViewContainer
