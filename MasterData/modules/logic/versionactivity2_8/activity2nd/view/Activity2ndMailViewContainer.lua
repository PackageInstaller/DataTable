-- chunkname: @modules/logic/versionactivity2_8/activity2nd/view/Activity2ndMailViewContainer.lua

module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndMailViewContainer", package.seeall)

local Activity2ndMailViewContainer = class("Activity2ndMailViewContainer", BaseViewContainer)

function Activity2ndMailViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity2ndMailView.New())

	return views
end

return Activity2ndMailViewContainer
