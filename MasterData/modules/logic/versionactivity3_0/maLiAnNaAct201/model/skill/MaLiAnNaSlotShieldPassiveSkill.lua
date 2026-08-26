-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/skill/MaLiAnNaSlotShieldPassiveSkill.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaSlotShieldPassiveSkill", package.seeall)

local MaLiAnNaSlotShieldPassiveSkill = class("MaLiAnNaSlotShieldPassiveSkill", MaLiAnNaSkillBase)

function MaLiAnNaSlotShieldPassiveSkill:init(id, param)
	MaLiAnNaSlotShieldPassiveSkill.super.init(self, id, nil)

	self._skillType = Activity201MaLiAnNaEnum.SkillType.passive
	self._effect = param
	self._startAngle = self._effect[2]
	self._angleRange = self._effect[3]
	self._hpMax = self._effect[4]
	self._hp = self._effect[5] or 0
	self._speed = self._effect[6] or 1
	self._hpUpCd = self._effect[7] or 3000
end

function MaLiAnNaSlotShieldPassiveSkill:update(deltaTime)
	self._cd = math.max(0, self._cd - deltaTime)

	if self._cd == 0 then
		self:_updateHp(self._speed * deltaTime)
	end
end

function MaLiAnNaSlotShieldPassiveSkill:getAngleAndRange()
	return self._startAngle, self._angleRange
end

function MaLiAnNaSlotShieldPassiveSkill:canUseSkill(slot, solider)
	if self:getHp() <= 0 then
		return false
	end

	if slot == nil or solider == nil then
		return false
	end

	local movePath = solider:getMoveSlotPathPoint()
	local curIndex = solider:getCurMoveIndex()
	local lastSlotId = movePath[curIndex - 1]

	if lastSlotId == nil or lastSlotId == 0 then
		return false
	end

	local lastSlot = Activity201MaLiAnNaGameModel.instance:getSlotById(lastSlotId)
	local posX, posY = lastSlot:getPosXY()
	local curSlotX, curSlotY = slot:getPosXY()

	return (MathUtil.is_point_in_sector(posX, posY, curSlotX, curSlotY, 2000, self._startAngle, self._angleRange))
end

function MaLiAnNaSlotShieldPassiveSkill:soliderAttack(hp)
	if self._cd == 0 then
		self._cd = self._hpUpCd
	end

	self:_updateHp(-hp)

	return self:getHp() > 0
end

function MaLiAnNaSlotShieldPassiveSkill:_updateHp(diff)
	self._hp = math.floor(math.min(self._hpMax, math.max(self._hp + diff, 0)))
end

function MaLiAnNaSlotShieldPassiveSkill:getHp()
	return self._hp
end

function MaLiAnNaSlotShieldPassiveSkill:destroy()
	self._soliderId = nil
	self._config = nil
end

return MaLiAnNaSlotShieldPassiveSkill
