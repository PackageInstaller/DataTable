-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondBeAttackBy.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondBeAttackBy", package.seeall)

local ArcadeSkillCondBeAttackBy = class("ArcadeSkillCondBeAttackBy", ArcadeSkillCondBase)

function ArcadeSkillCondBeAttackBy:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._atkDirStr = params[2]
end

function ArcadeSkillCondBeAttackBy:onIsCondSuccess()
	local atkType = self._context.attackType
	local atker = self._context.atker
	local target = self._context.target
	local hitDirection = ArcadeGameHelper.getStr2Dir(self._atkDirStr)

	if atkType and atker and target and atker:getDirection() == self:_toAtkDir(hitDirection) then
		local atkGx, atkGy = atker:getGridPos()
		local atkSx, atkSy = atker:getSize()
		local ax, ay = ArcadeGameHelper.getFirsXYByDir(atkGx, atkGy, atkSx, atkSy, atker:getDirection())
		local gridX, gridY = target:getGridPos()
		local sizeX, sizeY = target:getSize()

		if ArcadeGameHelper.isRectXYIntersect(ax, ax, ay, ay, gridX, gridX + sizeX - 1, gridY, gridY + sizeY - 1) then
			return true
		end
	end

	return false
end

function ArcadeSkillCondBeAttackBy:_toAtkDir(dir)
	if dir == ArcadeEnum.Direction.Up then
		return ArcadeEnum.Direction.Down
	elseif dir == ArcadeEnum.Direction.Down then
		return ArcadeEnum.Direction.Up
	elseif dir == ArcadeEnum.Direction.Left then
		return ArcadeEnum.Direction.Right
	elseif dir == ArcadeEnum.Direction.Right then
		return ArcadeEnum.Direction.Left
	end
end

return ArcadeSkillCondBeAttackBy
