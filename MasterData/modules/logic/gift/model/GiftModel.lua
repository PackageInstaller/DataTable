-- chunkname: @modules/logic/gift/model/GiftModel.lua

module("modules.logic.gift.model.GiftModel", package.seeall)

local GiftModel = class("GiftModel", BaseModel)

function GiftModel:onInit()
	self._multipleChoiceIndex = 0
	self._multipleChoiceId = 0
	self._needProps = {}
end

function GiftModel:reset()
	self._multipleChoiceIndex = 0
	self._multipleChoiceId = 0
	self._needProps = {}
end

function GiftModel:setMultipleChoiceIndex(index)
	self._multipleChoiceIndex = index
end

function GiftModel:getMultipleChoiceIndex()
	return self._multipleChoiceIndex
end

function GiftModel:setMultipleChoiceId(id)
	self._multipleChoiceId = id
end

function GiftModel:getMultipleChoiceId()
	return self._multipleChoiceId
end

function GiftModel:setNeedGift(propId)
	table.insert(self._needProps, propId)
end

function GiftModel:isGiftNeed(propId)
	for _, v in pairs(self._needProps) do
		if v == propId then
			return true
		end
	end

	return false
end

GiftModel.instance = GiftModel.New()

return GiftModel
