-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinBuildingMO.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinBuildingMO", package.seeall)

local AssassinBuildingMO = pureTable("AssassinBuildingMO")

function AssassinBuildingMO:init(proto)
	self:initParams(proto.type, proto.level)
end

function AssassinBuildingMO:initParams(type, level)
	self.type = type
	self.level = level or 0
	self.config = AssassinConfig.instance:getBuildingLvCo(self.type, self.level == 0 and 1 or self.level)
	self.maxLevel = AssassinConfig.instance:getBuildingMaxLv(self.type)
end

function AssassinBuildingMO:getConfig()
	return self.config
end

function AssassinBuildingMO:getType()
	return self.type
end

function AssassinBuildingMO:getLv()
	return self.level
end

function AssassinBuildingMO:isMaxLv()
	return self.level >= self.maxLevel
end

return AssassinBuildingMO
