-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameResource.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameResource", package.seeall)

local ArcadeGameResource = class("ArcadeGameResource")

function ArcadeGameResource:ctor(id)
	self.id = id

	local initVal = ArcadeConfig.instance:getAttributeInitVal(self.id)

	self:setCount(initVal)
	self:setGainRate()
	self:setUseDiscount()
end

function ArcadeGameResource:setCount(count)
	local numCount = tonumber(count)

	if not numCount then
		numCount = 0

		logError(string.format("ArcadeGameResource:setCount error, count:%s is not number", count))
	end

	local min = ArcadeConfig.instance:getAttributeMin(self.id, true)
	local max = self:getMax()

	self.count = Mathf.Clamp(numCount, min, max)
end

function ArcadeGameResource:setGainRate(rate)
	self.gainRate = tonumber(rate) or 0
end

function ArcadeGameResource:setUseDiscount(discount)
	self.useDiscount = tonumber(discount) or 0
end

function ArcadeGameResource:addCount(addCount)
	if addCount <= 0 then
		return
	end

	local realAddCount = addCount * (1000 + self.gainRate) / 1000

	if self.id == ArcadeGameEnum.CharacterResource.GameCoin then
		ArcadeGameModel.instance:addGainCoinNum(realAddCount)
	end

	local newCount = self.count + realAddCount

	self:setCount(newCount)
end

function ArcadeGameResource:subCount(subCount)
	if subCount <= 0 then
		return
	end

	local newCount = self.count - subCount * (1000 - self.useDiscount) / 1000

	self:setCount(newCount)
end

function ArcadeGameResource:getMax()
	return ArcadeConfig.instance:getAttributeMax(self.id, true)
end

function ArcadeGameResource:getCount()
	return self.count or 0
end

function ArcadeGameResource:getGainRate()
	return self.gainRate or 0
end

function ArcadeGameResource:getUseDiscount()
	return self.useDiscount or 0
end

return ArcadeGameResource
