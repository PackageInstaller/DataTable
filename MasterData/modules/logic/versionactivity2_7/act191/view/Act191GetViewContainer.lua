-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191GetViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191GetViewContainer", package.seeall)

local Act191GetViewContainer = class("Act191GetViewContainer", BaseViewContainer)

function Act191GetViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191GetView.New())

	return views
end

return Act191GetViewContainer
