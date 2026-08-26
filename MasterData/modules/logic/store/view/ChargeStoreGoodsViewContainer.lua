-- chunkname: @modules/logic/store/view/ChargeStoreGoodsViewContainer.lua

module("modules.logic.store.view.ChargeStoreGoodsViewContainer", package.seeall)

local ChargeStoreGoodsViewContainer = class("ChargeStoreGoodsViewContainer", BaseViewContainer)

function ChargeStoreGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, ChargeStoreGoodsView.New())

	return views
end

function ChargeStoreGoodsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return ChargeStoreGoodsViewContainer
