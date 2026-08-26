-- chunkname: @modules/logic/sp01/act205/view/ocean/Act205OceanShowViewContainer.lua

module("modules.logic.sp01.act205.view.ocean.Act205OceanShowViewContainer", package.seeall)

local Act205OceanShowViewContainer = class("Act205OceanShowViewContainer", BaseViewContainer)

function Act205OceanShowViewContainer:buildViews()
	local views = {}

	table.insert(views, Act205OceanShowView.New())

	return views
end

return Act205OceanShowViewContainer
