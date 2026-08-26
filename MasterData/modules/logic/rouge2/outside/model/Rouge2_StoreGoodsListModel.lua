-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_StoreGoodsListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_StoreGoodsListModel", package.seeall)

local Rouge2_StoreGoodsListModel = class("Rouge2_StoreGoodsListModel", ListScrollModel)

function Rouge2_StoreGoodsListModel:onInit()
	self:reInit()
end

function Rouge2_StoreGoodsListModel:reInit()
	self.stageId = nil
	self.goodsMoList = {}
end

function Rouge2_StoreGoodsListModel:copyListFromStoreConfig(stageId)
	if stageId == nil then
		logError("stageId is nil")

		return
	end

	if self.stageId == nil or self.stageId ~= stageId then
		if not self.goodsMoList then
			self.goodsMoList = {}
		else
			tabletool.clear(self.goodsMoList)
		end

		local rewardConfigList = Rouge2_OutSideConfig.instance:getRewardConfigListByStage(stageId)

		if rewardConfigList == nil then
			logError("stageId not found, id:" .. stageId)
		end

		for _, config in ipairs(rewardConfigList) do
			local storeMo = Rouge2_StoreModel.instance:getStoreMoById(config.id)

			if not storeMo then
				logError("storeMo not found, id:" .. config.id)
			else
				local goodsMo = Rouge2_StoreGoodsMo.New()

				goodsMo:init(storeMo)
				table.insert(self.goodsMoList, goodsMo)
			end
		end
	end

	self:setList(self.goodsMoList)
end

Rouge2_StoreGoodsListModel.instance = Rouge2_StoreGoodsListModel.New()

return Rouge2_StoreGoodsListModel
