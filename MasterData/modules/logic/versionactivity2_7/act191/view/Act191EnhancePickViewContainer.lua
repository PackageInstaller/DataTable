-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191EnhancePickViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191EnhancePickViewContainer", package.seeall)

local Act191EnhancePickViewContainer = class("Act191EnhancePickViewContainer", BaseViewContainer)

function Act191EnhancePickViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191EnhancePickView.New())

	return views
end

return Act191EnhancePickViewContainer
