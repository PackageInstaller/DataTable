-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191EnhanceViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191EnhanceViewContainer", package.seeall)

local Act191EnhanceViewContainer = class("Act191EnhanceViewContainer", BaseViewContainer)

function Act191EnhanceViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191EnhanceView.New())

	return views
end

return Act191EnhanceViewContainer
