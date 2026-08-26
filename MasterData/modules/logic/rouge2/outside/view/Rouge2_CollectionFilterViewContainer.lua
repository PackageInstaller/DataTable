-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionFilterViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionFilterViewContainer", package.seeall)

local Rouge2_CollectionFilterViewContainer = class("Rouge2_CollectionFilterViewContainer", BaseViewContainer)

function Rouge2_CollectionFilterViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_CollectionFilterView.New())

	return views
end

return Rouge2_CollectionFilterViewContainer
