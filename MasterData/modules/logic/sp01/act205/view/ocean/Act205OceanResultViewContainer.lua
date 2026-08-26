-- chunkname: @modules/logic/sp01/act205/view/ocean/Act205OceanResultViewContainer.lua

module("modules.logic.sp01.act205.view.ocean.Act205OceanResultViewContainer", package.seeall)

local Act205OceanResultViewContainer = class("Act205OceanResultViewContainer", BaseViewContainer)

function Act205OceanResultViewContainer:buildViews()
	local views = {}

	table.insert(views, Act205OceanResultView.New())

	return views
end

return Act205OceanResultViewContainer
