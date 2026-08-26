-- chunkname: @modules/logic/versionactivity2_2/act136/view/Activity136FullViewContainer.lua

module("modules.logic.versionactivity2_2.act136.view.Activity136FullViewContainer", package.seeall)

local Activity136FullViewContainer = class("Activity136FullViewContainer", BaseViewContainer)

function Activity136FullViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity136FullView.New())

	return views
end

return Activity136FullViewContainer
