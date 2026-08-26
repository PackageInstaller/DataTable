-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameGoodsMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameGoodsMO", package.seeall)

local ArcadeGameGoodsMO = class("ArcadeGameGoodsMO", ArcadeGameBaseInteractiveMO)

function ArcadeGameGoodsMO:onCtor(extraParam)
	self._goodsCollectionId = extraParam.collectionId
	self._isDiscount = extraParam.isDiscount
end

function ArcadeGameGoodsMO:getGoodsCollectionId()
	return self._goodsCollectionId
end

function ArcadeGameGoodsMO:getEventOptionParam()
	return self:getGoodsCollectionId()
end

function ArcadeGameGoodsMO:getRes()
	local collectionId = self:getGoodsCollectionId()

	return ArcadeConfig.instance:getCollectionResPath(collectionId)
end

function ArcadeGameGoodsMO:getIcon()
	local collectionId = self:getGoodsCollectionId()

	return ArcadeConfig.instance:getCollectionIcon(collectionId)
end

function ArcadeGameGoodsMO:getInteractDesc()
	local collectionId = self:getGoodsCollectionId()

	return ArcadeConfig.instance:getCollectionDesc(collectionId, true)
end

function ArcadeGameGoodsMO:getDesc()
	return self:getInteractDesc()
end

function ArcadeGameGoodsMO:getName()
	local collectionId = self:getGoodsCollectionId()

	return ArcadeConfig.instance:getCollectionName(collectionId)
end

function ArcadeGameGoodsMO:getScale()
	local collectionId = self:getGoodsCollectionId()
	local scaleArr = ArcadeConfig.instance:getCollectionScale(collectionId)

	if scaleArr and type(scaleArr) == "table" then
		return tonumber(scaleArr[1]), tonumber(scaleArr[2])
	end
end

function ArcadeGameGoodsMO:getPosOffset()
	local collectionId = self:getGoodsCollectionId()
	local posArr = ArcadeConfig.instance:getCollectionPosOffset(collectionId)

	if posArr and type(posArr) == "table" then
		return tonumber(posArr[1]), tonumber(posArr[2])
	end
end

function ArcadeGameGoodsMO:getIsDiscount()
	return self._isDiscount
end

function ArcadeGameGoodsMO:getPrice()
	local collectionId = self:getGoodsCollectionId()
	local price = ArcadeConfig.instance:getCollectionPrice(collectionId) or 0
	local isDiscount = self:getIsDiscount()

	if isDiscount then
		local goodsDiscount = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.GoodsDiscount)

		price = math.floor(price * (1000 - goodsDiscount) / 1000)
	end

	return price
end

return ArcadeGameGoodsMO
