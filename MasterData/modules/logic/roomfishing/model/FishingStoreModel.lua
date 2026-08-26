-- chunkname: @modules/logic/roomfishing/model/FishingStoreModel.lua

module("modules.logic.roomfishing.model.FishingStoreModel", package.seeall)

local FishingStoreModel = class("FishingStoreModel", BaseModel)

function FishingStoreModel:onInit()
	return
end

function FishingStoreModel:reInit()
	self:onInit()
end

function FishingStoreModel:getStoreGroupMO()
	return (StoreModel.instance:getStoreMO(StoreEnum.StoreId.RoomFishingStore))
end

function FishingStoreModel:checkUpdateStoreActivity()
	local actId
	local updateStoreMo = self:getStoreGroupMO()
	local goodsList = updateStoreMo and updateStoreMo:getGoodsList() or {}

	for _, mo in pairs(goodsList) do
		local goodsActId = mo.config.activityId

		if not actId then
			if goodsActId ~= 0 then
				actId = goodsActId
			end
		elseif actId ~= goodsActId then
			logError(string.format("FishingStoreModel.checkUpdateStoreActivity error, actId inconsistent：%s", goodsActId))

			return goodsActId
		end
	end

	return actId
end

FishingStoreModel.instance = FishingStoreModel.New()

return FishingStoreModel
