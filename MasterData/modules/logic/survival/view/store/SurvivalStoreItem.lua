-- chunkname: @modules/logic/survival/view/store/SurvivalStoreItem.lua

module("modules.logic.survival.view.store.SurvivalStoreItem", package.seeall)

local SurvivalStoreItem = class("SurvivalStoreItem", SimpleListItem)

function SurvivalStoreItem:onInit()
	self.goStoreGoodsItem = gohelper.findChild(self.viewGO, "#go_storegoodsitem")

	local param = GameFacade.createSimpleListParam(SurvivalStoreGoodsItem)

	self.goodsList = GameFacade.createSimpleListComp(self.viewGO, param, self.goStoreGoodsItem, self.viewContainer)
end

function SurvivalStoreItem:onItemShow(data)
	self.goods = data.goods

	table.sort(self.goods, self.sortGoods)
	self.goodsList:setData(self.goods)
end

function SurvivalStoreItem.sortGoods(mo1, mo2)
	local cfg1 = mo1.config
	local cfg2 = mo2.config
	local goods1SellOut = mo1:isSoldOut()
	local goods2SellOut = mo2:isSoldOut()

	if goods1SellOut ~= goods2SellOut then
		return goods2SellOut
	end

	if cfg1.order ~= cfg2.order then
		return cfg1.order < cfg2.order
	end

	return cfg1.id < cfg2.id
end

return SurvivalStoreItem
