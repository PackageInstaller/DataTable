-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameAttackCountTriggerBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameAttackCountTriggerBuff", package.seeall)

local OriMatGameAttackCountTriggerBuff = class("OriMatGameAttackCountTriggerBuff", OriMatGameBuffBase)

function OriMatGameAttackCountTriggerBuff:initComplete()
	OriMatGameAttackCountTriggerBuff.super.initComplete(self)

	self._triggerCount = checknumber(self._tiggerParam[self:gPId()])
	self._changeValue = checknumber(self._tiggerParam[self:gPId()])
	self._curAttackCount = 0
	self._isTriggered = false
end

function OriMatGameAttackCountTriggerBuff:onAttack(target)
	self._curAttackCount = self._curAttackCount + 1

	if self._isTriggered then
		self._isTriggered = false

		GameUtil.callBack(self._unit.resetMode, self._unit, OriMatGameEnum.BuffChangeMode.BulletSizeIncreases)
		GameUtil.callBack(self._unit.updateAttr, self._unit, OriMatGameEnum.UnitAttrName.AtkMultiplier, -self._changeValue)
	end

	if not self._isTriggered and self._curAttackCount >= self:getCurTriggerCount() then
		self._curAttackCount = 0
		self._isTriggered = true

		GameUtil.callBack(self._unit.changeMode, self._unit, OriMatGameEnum.BuffChangeMode.BulletSizeIncreases)
		GameUtil.callBack(self._unit.updateAttr, self._unit, OriMatGameEnum.UnitAttrName.AtkMultiplier, self._changeValue)
	end
end

function OriMatGameAttackCountTriggerBuff:onRemove(unit)
	OriMatGameAttackCountTriggerBuff.super.onRemove(self, unit)

	if self._isTriggered then
		self._isTriggered = false

		GameUtil.callBack(self._unit.updateAttr, self._unit, OriMatGameEnum.UnitAttrName.AtkMultiplier, -self._changeValue)
	end
end

function OriMatGameAttackCountTriggerBuff:getCurTriggerCount()
	return Mathf.Max(0, self._triggerCount + checknumber(self._unit:getCurAttrValue(OriMatGameEnum.UnitAttrName.SkillTriggerCount)))
end

return OriMatGameAttackCountTriggerBuff
