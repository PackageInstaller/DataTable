-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191EnhanceTipViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191EnhanceTipViewContainer", package.seeall)

local Act191EnhanceTipViewContainer = class("Act191EnhanceTipViewContainer", BaseViewContainer)

function Act191EnhanceTipViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191EnhanceTipView.New())

	return views
end

return Act191EnhanceTipViewContainer
