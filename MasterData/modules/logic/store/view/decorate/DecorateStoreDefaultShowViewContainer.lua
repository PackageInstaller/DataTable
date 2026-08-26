-- chunkname: @modules/logic/store/view/decorate/DecorateStoreDefaultShowViewContainer.lua

module("modules.logic.store.view.decorate.DecorateStoreDefaultShowViewContainer", package.seeall)

local DecorateStoreDefaultShowViewContainer = class("DecorateStoreDefaultShowViewContainer", BaseViewContainer)

function DecorateStoreDefaultShowViewContainer:buildViews()
	local views = {}

	table.insert(views, DecorateStoreDefaultShowView.New())

	return views
end

return DecorateStoreDefaultShowViewContainer
