-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/skill/WeakPointSkillMO.lua

module("logic.battle.unit.comp.skill.WeakPointSkillMO", package.seeall)

local WeakPointSkillMO = class("WeakPointSkillMO", ActiveSkillMO)

function WeakPointSkillMO:reuse(activeSkillCO)
	WeakPointSkillMO.super.reuse(self, activeSkillCO)

	self._weakPointMaxHp = {}
	self._isLinkedWeakPoint = {}
	self._linkedTag = {}
end

function WeakPointSkillMO:reset()
	WeakPointSkillMO.super.reset(self)

	self._weakPointMaxHp = false
	self._isLinkedWeakPoint = {}
	self._linkedTag = {}
end

function WeakPointSkillMO:destroy()
	WeakPointSkillMO.super.destroy(self)

	self._weakPointMaxHp = nil
	self._isLinkedWeakPoint = nil
	self._linkedTag = nil
end

function WeakPointSkillMO:onAdded(unit)
	WeakPointSkillMO.super.onAdded(self, unit)
	self:_initStatusWeakPoint(BattleEnum.SkillStatus.Normal)

	if self._skillCOWrapper:hasStrenthening() then
		self:_initStatusWeakPoint(BattleEnum.SkillStatus.Strenthening)
	end
end

function WeakPointSkillMO:_initStatusWeakPoint(status)
	return
end

function WeakPointSkillMO:getWeakPointMaxHp()
	return
end

function WeakPointSkillMO:getLinkedTag()
	return
end

return WeakPointSkillMO
