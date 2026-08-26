-- chunkname: @modules/logic/versionactivity3_3/igor/model/IgorCampBasedMO.lua

module("modules.logic.versionactivity3_3.igor.model.IgorCampBasedMO", package.seeall)

local IgorCampBasedMO = class("IgorCampBasedMO", IgorBaseEntityMO)

function IgorCampBasedMO:init(id, campType)
	self.level = 1
	self.maxLevel = IgorConfig.instance:getBaseMaxLevel(id)

	self:initEntity(id, IgorEnum.SoldierType.Base, campType)
end

function IgorCampBasedMO:getConfig()
	return IgorConfig.instance:getBaseConfig(self.entityId, self.level)
end

function IgorCampBasedMO:isMaxLevel()
	return self.level >= self.maxLevel
end

function IgorCampBasedMO:getLevel()
	return self.level
end

function IgorCampBasedMO:getSpeed()
	return 0
end

function IgorCampBasedMO:addEntity(soldierId)
	self.gameMo:createSoldier(soldierId, self.campType)
end

return IgorCampBasedMO
