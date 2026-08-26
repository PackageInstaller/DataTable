-- chunkname: @modules/logic/versionactivity2_8/activity2nd/view/Activity2ndShowSkinViewContainer.lua

module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndShowSkinViewContainer", package.seeall)

local Activity2ndShowSkinViewContainer = class("Activity2ndShowSkinViewContainer", BaseViewContainer)

function Activity2ndShowSkinViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity2ndShowSkinView.New())

	return views
end

return Activity2ndShowSkinViewContainer
