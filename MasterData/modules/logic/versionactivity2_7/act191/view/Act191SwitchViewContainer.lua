-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191SwitchViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191SwitchViewContainer", package.seeall)

local Act191SwitchViewContainer = class("Act191SwitchViewContainer", BaseViewContainer)

function Act191SwitchViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191SwitchView.New())

	return views
end

return Act191SwitchViewContainer
