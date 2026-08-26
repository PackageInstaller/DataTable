-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetSameColor.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetSameColor", package.seeall)

local ArcadeSkillTargetSameColor = class("ArcadeSkillTargetSameColor", ArcadeSkillTargetBase)

function ArcadeSkillTargetSameColor:onFindTarget()
	local mo

	if self._context and self._context.target then
		mo = self:_getMainMonsterMO(self._context.target)
	else
		mo = self:_getMonsterMOByGridXY(self.gridX, self.gridY)
		mo = mo or self:_getMonsterMOByGridXY(self.gridX, self.gridY)
	end

	if mo then
		::label_1_0::

		local targetRace = ArcadeConfig.instance:getMonsterRace(mo:getId())

		if not targetRace then
			return
		end

		local monsterList = ArcadeGameModel.instance:getMonsterList()

		for _, monsterMO in ipairs(monsterList) do
			local adjId = monsterMO:getId()
			local race = ArcadeConfig.instance:getMonsterRace(adjId)

			if race == targetRace then
				self:addTarget(monsterMO)
			end
		end
	end
end

function ArcadeSkillTargetSameColor:_getMainMonsterMO(target)
	local entityType = target:getEntityType()

	if entityType == ArcadeGameEnum.EntityType.Monster then
		return target
	elseif entityType == ArcadeGameEnum.EntityType.Character then
		local atkGx, atkGy = target:getGridPos()
		local atkSx, atkSy = target:getSize()
		local ax, ay = ArcadeGameHelper.getFirsXYByDir(atkGx, atkGy, atkSx, atkSy, target:getDirection())

		return self:_getMonsterMOByGridXY(ax, ay)
	end
end

function ArcadeSkillTargetSameColor:_getMonsterMOByGridXY(ax, ay)
	if not ax or not ay then
		return nil
	end

	local monsterList = ArcadeGameModel.instance:getMonsterList()

	for _, target in ipairs(monsterList) do
		local gridX, gridY = target:getGridPos()
		local sizeX, sizeY = target:getSize()

		if ArcadeGameHelper.isRectXYIntersect(ax, ax, ay, ay, gridX, gridX + sizeX - 1, gridY, gridY + sizeY - 1) then
			return target
		end
	end
end

return ArcadeSkillTargetSameColor
