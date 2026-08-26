-- chunkname: @modules/logic/udimo/model/UdimoMO.lua

module("modules.logic.udimo.model.UdimoMO", package.seeall)

local UdimoMO = pureTable("UdimoMO")
local USE_SIGN = 1

function UdimoMO:ctor()
	self.id = nil
	self.isUse = nil
	self.getTime = nil
	self.fightCount = 0
	self.heroCoverDay = 0
	self.assistCount = 0
	self.trainCritterCount = 0
end

function UdimoMO:init(info)
	self.id = info.udimoId

	self:setUse(info.isUse == USE_SIGN)

	self.getTime = info.getTime
	self.fightCount = info.fightCount
	self.heroCoverDay = info.heroCoverDay
	self.assistCount = info.assistCount
	self.trainCritterCount = info.trainCritterCount
end

function UdimoMO:setUse(isUse)
	self.isUse = isUse
end

function UdimoMO:getId()
	return self.id
end

function UdimoMO:getIsUse()
	return self.isUse
end

function UdimoMO:getGetTime()
	return self.getTime
end

function UdimoMO:getInfoDataList()
	return {
		self.heroCoverDay,
		self.assistCount,
		self.trainCritterCount,
		self.fightCount
	}
end

return UdimoMO
