-- chunkname: @modules/logic/store/view/DecorateStoreGoodsTipViewContainer.lua

module("modules.logic.store.view.DecorateStoreGoodsTipViewContainer", package.seeall)

local DecorateStoreGoodsTipViewContainer = class("DecorateStoreGoodsTipViewContainer", BaseViewContainer)

function DecorateStoreGoodsTipViewContainer:buildViews()
	local views = {}

	table.insert(views, DecorateStoreGoodsTipView.New())

	return views
end

return DecorateStoreGoodsTipViewContainer
