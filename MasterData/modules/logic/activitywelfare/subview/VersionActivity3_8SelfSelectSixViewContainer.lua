-- chunkname: @modules/logic/activitywelfare/subview/VersionActivity3_8SelfSelectSixViewContainer.lua

module("modules.logic.activitywelfare.subview.VersionActivity3_8SelfSelectSixViewContainer", package.seeall)

local VersionActivity3_8SelfSelectSixViewContainer = class("VersionActivity3_8SelfSelectSixViewContainer", BaseViewContainer)

function VersionActivity3_8SelfSelectSixViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_8SelfSelectSixView.New())

	return views
end

return VersionActivity3_8SelfSelectSixViewContainer
