-- chunkname: @modules/logic/store/model/ActivityStoreModel.lua

module("modules.logic.store.model.ActivityStoreModel", package.seeall)

local ActivityStoreModel = class("ActivityStoreModel", BaseModel)

function ActivityStoreModel:onInit()
	self.activityGoodsInfosDict = nil
end

function ActivityStoreModel:reInit()
	self:onInit()
end

function ActivityStoreModel:initActivityGoodsInfos(activityId, goodsInfos)
	self.activityGoodsInfosDict = self.activityGoodsInfosDict or {}

	local activityGoodsInfos = {}
	local activityStoreMo

	for _, goodsInfo in ipairs(goodsInfos) do
		activityStoreMo = ActivityStoreMo.New()

		activityStoreMo:init(activityId, goodsInfo)

		activityGoodsInfos[activityStoreMo.id] = activityStoreMo
	end

	self.activityGoodsInfosDict[activityId] = activityGoodsInfos
end

function ActivityStoreModel:updateActivityGoodsInfos(activityId, goodsInfo)
	local activityGoodsInfos = self.activityGoodsInfosDict[activityId]
	local activityStoreMo = activityGoodsInfos[goodsInfo.id]

	if not activityStoreMo then
		activityStoreMo = ActivityStoreMo.New()

		activityStoreMo:init(activityId, goodsInfo)

		activityGoodsInfos[activityStoreMo.id] = activityStoreMo
	else
		activityStoreMo:updateData(goodsInfo)
	end
end

function ActivityStoreModel:getActivityGoodsBuyCount(activityId, goodsId)
	local dict = self.activityGoodsInfosDict

	if not dict or not dict[activityId] or not dict[activityId][goodsId] then
		return 0
	end

	return dict[activityId][goodsId].buyCount or 0
end

ActivityStoreModel.instance = ActivityStoreModel.New()

return ActivityStoreModel
