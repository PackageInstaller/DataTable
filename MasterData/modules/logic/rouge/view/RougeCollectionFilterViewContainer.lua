-- chunkname: @modules/logic/rouge/view/RougeCollectionFilterViewContainer.lua

module("modules.logic.rouge.view.RougeCollectionFilterViewContainer", package.seeall)

local RougeCollectionFilterViewContainer = class("RougeCollectionFilterViewContainer", BaseViewContainer)

function RougeCollectionFilterViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeCollectionFilterView.New())

	return views
end

return RougeCollectionFilterViewContainer
