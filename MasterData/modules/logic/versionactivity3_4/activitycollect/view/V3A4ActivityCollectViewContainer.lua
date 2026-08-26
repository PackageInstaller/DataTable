-- chunkname: @modules/logic/versionactivity3_4/activitycollect/view/V3A4ActivityCollectViewContainer.lua

module("modules.logic.versionactivity3_4.activitycollect.view.V3A4ActivityCollectViewContainer", package.seeall)

local V3A4ActivityCollectViewContainer = class("V3A4ActivityCollectViewContainer", BaseViewContainer)

function V3A4ActivityCollectViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A4ActivityCollectView.New())

	return views
end

return V3A4ActivityCollectViewContainer
