-- chunkname: @modules/logic/store/model/StoreChargeGoodsItemListModel.lua

module("modules.logic.store.model.StoreChargeGoodsItemListModel", package.seeall)

local StoreChargeGoodsItemListModel = class("StoreChargeGoodsItemListModel", ListScrollModel)

function StoreChargeGoodsItemListModel:setMOList(moList, storeId)
	self._moList = {}

	if moList then
		for _, mo in pairs(moList) do
			if mo.config.belongStoreId == storeId then
				table.insert(self._moList, mo)
			end
		end

		if #self._moList > 1 then
			table.sort(self._moList, self._sortFunction)
		end
	end

	self:setList(self._moList)
end

function StoreChargeGoodsItemListModel._sortFunction(x, y)
	local xConfig = StoreConfig.instance:getChargeGoodsConfig(x.id)
	local yConfig = StoreConfig.instance:getChargeGoodsConfig(y.id)

	if xConfig.order ~= yConfig.order then
		return xConfig.order < yConfig.order
	end

	return xConfig.id < yConfig.id
end

StoreChargeGoodsItemListModel.instance = StoreChargeGoodsItemListModel.New()

return StoreChargeGoodsItemListModel
