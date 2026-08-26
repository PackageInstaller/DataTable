-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameFloorMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameFloorMO", package.seeall)

local ArcadeGameFloorMO = class("ArcadeGameFloorMO", ArcadeGameBaseUnitMO)

function ArcadeGameFloorMO:onCtor()
	self._curCdRound = 0
	self._entityType = ArcadeGameEnum.EntityType.Floor

	local skill = ArcadeConfig.instance:getFloorSkill(self.id)

	if skill then
		self._skillSetMO:addSkillById(skill)
	end
end

function ArcadeGameFloorMO:setCdRound(round)
	self._curCdRound = tonumber(round)

	if not self._curCdRound or self._curCdRound < 1 then
		self._curCdRound = 0
	end
end

function ArcadeGameFloorMO:getCfg()
	return (ArcadeConfig.instance:getFloorCfg(self.id, true))
end

function ArcadeGameFloorMO:getSize()
	if not self._sizeX then
		self._sizeX, self._sizeY = ArcadeConfig.instance:getFloorSize(self.id)
	end

	return self._sizeX, self._sizeY
end

function ArcadeGameFloorMO:getRes()
	return ArcadeConfig.instance:getFloorRes(self.id)
end

function ArcadeGameFloorMO:getCdRound()
	return self._curCdRound
end

function ArcadeGameFloorMO:getLimitRound()
	return ArcadeConfig.instance:getFloorLimitRound(self.id)
end

return ArcadeGameFloorMO
