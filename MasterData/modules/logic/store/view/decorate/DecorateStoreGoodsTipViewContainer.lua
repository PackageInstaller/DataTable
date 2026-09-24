-- chunkname: @modules/logic/store/view/decorate/DecorateStoreGoodsTipViewContainer.lua

module("modules.logic.store.view.decorate.DecorateStoreGoodsTipViewContainer", package.seeall)

local DecorateStoreGoodsTipViewContainer = class("DecorateStoreGoodsTipViewContainer", BaseViewContainer)

function DecorateStoreGoodsTipViewContainer:buildViews()
	local views = {}

	table.insert(views, DecorateStoreGoodsTipView.New())

	return views
end

return DecorateStoreGoodsTipViewContainer
