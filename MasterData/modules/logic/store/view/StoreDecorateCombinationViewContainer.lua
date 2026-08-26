-- chunkname: @modules/logic/store/view/StoreDecorateCombinationViewContainer.lua

module("modules.logic.store.view.StoreDecorateCombinationViewContainer", package.seeall)

local StoreDecorateCombinationViewContainer = class("StoreDecorateCombinationViewContainer", BaseViewContainer)

function StoreDecorateCombinationViewContainer:buildViews()
	local views = {}

	table.insert(views, StoreDecorateCombinationView.New())
	table.insert(views, StoreDecorateCombinationBanner.New())

	return views
end

return StoreDecorateCombinationViewContainer
