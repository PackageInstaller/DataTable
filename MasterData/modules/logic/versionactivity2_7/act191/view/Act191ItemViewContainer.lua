-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191ItemViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191ItemViewContainer", package.seeall)

local Act191ItemViewContainer = class("Act191ItemViewContainer", BaseViewContainer)

function Act191ItemViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191ItemView.New())

	return views
end

return Act191ItemViewContainer
