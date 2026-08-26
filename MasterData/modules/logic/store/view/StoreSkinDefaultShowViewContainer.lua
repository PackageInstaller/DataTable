-- chunkname: @modules/logic/store/view/StoreSkinDefaultShowViewContainer.lua

module("modules.logic.store.view.StoreSkinDefaultShowViewContainer", package.seeall)

local StoreSkinDefaultShowViewContainer = class("StoreSkinDefaultShowViewContainer", BaseViewContainer)

function StoreSkinDefaultShowViewContainer:buildViews()
	local views = {}

	table.insert(views, StoreSkinDefaultShowView.New())

	return views
end

return StoreSkinDefaultShowViewContainer
