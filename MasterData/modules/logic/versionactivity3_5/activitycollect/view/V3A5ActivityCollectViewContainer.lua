-- chunkname: @modules/logic/versionactivity3_5/activitycollect/view/V3A5ActivityCollectViewContainer.lua

module("modules.logic.versionactivity3_5.activitycollect.view.V3A5ActivityCollectViewContainer", package.seeall)

local V3A5ActivityCollectViewContainer = class("V3A5ActivityCollectViewContainer", BaseViewContainer)

function V3A5ActivityCollectViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A5ActivityCollectView.New())

	return views
end

return V3A5ActivityCollectViewContainer
