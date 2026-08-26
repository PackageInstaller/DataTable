-- chunkname: @modules/logic/versionactivity3_3/igor/model/IgorSoldierMO.lua

module("modules.logic.versionactivity3_3.igor.model.IgorSoldierMO", package.seeall)

local IgorSoldierMO = class("IgorSoldierMO", IgorBaseEntityMO)

function IgorSoldierMO:init(id, campType)
	self.config = IgorConfig.instance:getSoldierConfig(id)

	local type = self.config.type

	self:initEntity(id, type, campType)
end

function IgorSoldierMO:onInit()
	self.counterDict = {}

	local config = self:getConfig()
	local attr = GameUtil.splitString2(config.counter, true)

	for _, v in ipairs(attr) do
		self.counterDict[v[1]] = v[2]
	end
end

function IgorSoldierMO:getConfig()
	return self.config
end

function IgorSoldierMO:getDamageCounter(targetType)
	return self.counterDict[targetType] or 1000
end

return IgorSoldierMO
