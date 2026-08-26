-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameAttribute.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameAttribute", package.seeall)

local ArcadeGameAttribute = class("ArcadeGameAttribute")

ArcadeGameAttribute.ATTR_BASE = "base"
ArcadeGameAttribute.ATTR_RATE = "rate"
ArcadeGameAttribute.ATTR_INCR = "increase"

local ATTR_NAME_KEYS = {
	"base",
	"rate",
	"increase"
}

ArcadeGameAttribute.ATTR_NAME_KEYS = ATTR_NAME_KEYS

local ATTR_NAME_MAP = {}

for _, keyName in ipairs(ATTR_NAME_KEYS) do
	ATTR_NAME_MAP[keyName] = true
end

function ArcadeGameAttribute:ctor(id, base)
	self.id = id
	self.base = base or 0
	self.rate = 0
	self.increase = 0
end

function ArcadeGameAttribute:getValue()
	local initVal = ArcadeConfig.instance:getAttributeInitVal(self.id)
	local value = math.floor((initVal + self.base) * (1000 + self.rate) / 1000 + self.increase)
	local min = ArcadeConfig.instance:getAttributeMin(self.id, true)
	local max = ArcadeConfig.instance:getAttributeMax(self.id, true)

	value = Mathf.Clamp(value, min, max)

	return value
end

function ArcadeGameAttribute:getBase()
	return self.base
end

function ArcadeGameAttribute:getRate()
	return self.rate
end

function ArcadeGameAttribute:getIncrease()
	return self.increase
end

function ArcadeGameAttribute:setBase(base)
	local numBase = tonumber(base)

	if not numBase then
		numBase = 0

		logError(string.format("ArcadeGameAttribute:setBase error, base:%s is not number", base))
	end

	self.base = numBase
end

function ArcadeGameAttribute:setRate(rate)
	local numRate = tonumber(rate)

	if not numRate then
		numRate = 0

		logError(string.format("ArcadeGameAttribute:setRate error, rate:%s is not number", rate))
	end

	self.rate = numRate
end

function ArcadeGameAttribute:setIncrease(increase)
	local numIncrease = tonumber(increase)

	if not numIncrease then
		numIncrease = 0

		logError(string.format("ArcadeGameAttribute:setIncrease error, increase:%s is not number", increase))
	end

	self.increase = numIncrease
end

function ArcadeGameAttribute:setValByName(keyName, value)
	if ATTR_NAME_MAP[keyName] then
		self[keyName] = tonumber(value)
	end
end

function ArcadeGameAttribute:addValByName(keyName, value)
	if ATTR_NAME_MAP[keyName] then
		self[keyName] = self[keyName] or self[keyName] + tonumber(value)
	end
end

function ArcadeGameAttribute:setByAttr(attr)
	local keyList = ATTR_NAME_KEYS

	for _, keyName in ipairs(keyList) do
		if attr[keyName] then
			self:setValByName(keyName, attr[keyName])
		end
	end
end

function ArcadeGameAttribute:addByAttr(attr)
	local keyList = ATTR_NAME_KEYS

	for _, keyName in ipairs(keyList) do
		if attr[keyName] then
			self:addValByName(keyName, attr[keyName])
		end
	end
end

function ArcadeGameAttribute:reset()
	local keyList = ATTR_NAME_KEYS

	for _, keyName in ipairs(keyList) do
		self[keyName] = 0
	end
end

return ArcadeGameAttribute
