-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotAttackCountTriggerBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotAttackCountTriggerBuff", package.seeall)

local DefendCarrotAttackCountTriggerBuff = class("DefendCarrotAttackCountTriggerBuff", DefendCarrotBuffBase)

function DefendCarrotAttackCountTriggerBuff:initComplete()
	DefendCarrotAttackCountTriggerBuff.super.initComplete(self)

	self._triggerCount = checknumber(self._tiggerParam[self:gPId()])
	self._changeValue = checknumber(self._tiggerParam[self:gPId()])
	self._curAttackCount = 0
	self._isTriggered = false
end

function DefendCarrotAttackCountTriggerBuff:onAttack(target)
	self._curAttackCount = self._curAttackCount + 1

	if self._isTriggered then
		self._isTriggered = false

		GameUtil.callBack(self._unit.resetMode, self._unit, DefendCarrotEnum.BuffChangeMode.BulletSizeIncreases)
		GameUtil.callBack(self._unit.updateAttr, self._unit, DefendCarrotEnum.UnitAttrName.AtkMultiplier, -self._changeValue)
	end

	if not self._isTriggered and self._curAttackCount >= self:getCurTriggerCount() then
		self._curAttackCount = 0
		self._isTriggered = true

		GameUtil.callBack(self._unit.changeMode, self._unit, DefendCarrotEnum.BuffChangeMode.BulletSizeIncreases)
		GameUtil.callBack(self._unit.updateAttr, self._unit, DefendCarrotEnum.UnitAttrName.AtkMultiplier, self._changeValue)
	end
end

function DefendCarrotAttackCountTriggerBuff:onRemove(unit)
	DefendCarrotAttackCountTriggerBuff.super.onRemove(self, unit)

	if self._isTriggered then
		self._isTriggered = false

		GameUtil.callBack(self._unit.updateAttr, self._unit, DefendCarrotEnum.UnitAttrName.AtkMultiplier, -self._changeValue)
	end
end

function DefendCarrotAttackCountTriggerBuff:getCurTriggerCount()
	return Mathf.Max(0, self._triggerCount + checknumber(self._unit:getCurAttrValue(DefendCarrotEnum.UnitAttrName.SkillTriggerCount)))
end

return DefendCarrotAttackCountTriggerBuff
