-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/impl/RogueProp.lua

module("logic.extensions.roguelike.unit.impl.RogueProp", package.seeall)

local M = class("RogueProp", RogueUnitBase)

function M:_initComponents()
	self:_addComponent("buff", RogueUnitCompBuffs)
end

function M:_init()
	self._const = RoguelikeConst

	M.super._init(self)
	self:setEvent(true)
end

function M:OnDestroy()
	self:setEvent(false)
	goutil.destroy(self.go)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_MONSTER_COMBAT_BEGIN, self._onCombatBegin, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_MONSTER_COMBAT_END, self._onCombatEnd, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_MONSTER_TAKE_DAMAGE, self._onMonsterTakeDamage, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_MONSTER_HP, self._onMonsterHpChange, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ROUND_END, self._onRoundEnd, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_MONSTER_COMBAT_BEGIN, self._onCombatBegin, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_MONSTER_COMBAT_END, self._onCombatEnd, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_MONSTER_TAKE_DAMAGE, self._onMonsterTakeDamage, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_MONSTER_HP, self._onMonsterHpChange, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ROUND_END, self._onRoundEnd, self)
	end
end

function M:_onCombatBegin()
	self:triggerBuff(EventType.ROGUE_MONSTER_COMBAT_BEGIN)
end

function M:_onCombatEnd()
	self:triggerBuff(EventType.ROGUE_MONSTER_COMBAT_END)

	local buffMos = self.buff:getAllBuff()

	for k, v in pairs(buffMos) do
		v:getBuffHandler():onRemove(self, v)
	end
end

function M:_onMonsterTakeDamage(sender, damage)
	self:triggerBuff(EventType.ROGUE_MONSTER_TAKE_DAMAGE, damage)
end

function M:_onMonsterHpChange(sender, monsterId, hp)
	self:triggerBuff(EventType.ROGUE_REFRESH_MONSTER_HP)
end

function M:_onRoundEnd()
	self:triggerBuff(EventType.ROGUE_ROUND_END)
end

function M:triggerByProgram(program)
	local buffMos = self.buff:getAllBuff()

	for k, v in pairs(buffMos) do
		print("道具", program, v:getClientProgram())

		if v:getClientProgram() == program then
			return self:triggerBuff(nil, nil, program)
		end
	end

	return false
end

function M:triggerBuff(eventType, params, program)
	local buffMos = self.buff:getAllBuff()
	local conditionMos = self.buff:getAllCondition()

	if TableUtil.getLen(conditionMos) > 0 then
		local isPass = true

		for k, v in pairs(conditionMos) do
			if not v:isTrigger() then
				isPass = false
			end
		end

		if not isPass then
			print("没有全部满足触发条件")

			return false
		end

		for k, v in pairs(buffMos) do
			if v:getClientProgram() == program then
				local trigger, par = v:getBuffHandler():onTrigger(eventType, self, v, params)

				return v:getBuffHandler():onTrigger(eventType, self, v, params)
			end

			v:getBuffHandler():onTrigger(eventType, self, v, params)
		end

		return true
	end

	local exec = false
	local param

	for k, v in pairs(buffMos) do
		local trigger, par = v:getBuffHandler():onTrigger(eventType, self, v, params)

		if trigger then
			exec = true
			param = par
		end
	end

	return exec, param
end

return M
