-- chunkname: @modules/logic/versionactivity3_2/activitycollect/view/V3A2ActivityCollectViewContainer.lua

module("modules.logic.versionactivity3_2.activitycollect.view.V3A2ActivityCollectViewContainer", package.seeall)

local V3A2ActivityCollectViewContainer = class("V3A2ActivityCollectViewContainer", BaseViewContainer)

function V3A2ActivityCollectViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A2ActivityCollectView.New())

	return views
end

return V3A2ActivityCollectViewContainer
