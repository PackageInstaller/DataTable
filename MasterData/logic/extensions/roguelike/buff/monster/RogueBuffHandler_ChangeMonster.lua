-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/monster/RogueBuffHandler_ChangeMonster.lua

module("logic.extensions.roguelike.buff.monster.RogueBuffHandler_ChangeMonster", package.seeall)

local M = class("RogueBuffHandler_ChangeMonster", RogueBaseBuffHandler)

function M:ctor()
	self._triggerEvent = EventType.ROGUE_REFRESH_MONSTER_HP
	self._targetTriggerEvents = {}
	self._curHandlerProxy = nil
end

function M:onAdd(entity, buffMO)
	local curHp = entity.monsterProp:getHp()
	local dices = RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundCombatDice() or {}

	curHp = curHp + #dices

	self:changeMonster(entity, buffMO, curHp)
end

function M:onTrigger(triggerEvent, entity, buffMO, params)
	for k, v in pairs(self._targetTriggerEvents) do
		if triggerEvent == v and self._curHandlerProxy then
			self._curHandlerProxy:onTrigger(triggerEvent, entity, buffMO, params)
		end
	end

	if triggerEvent == self._triggerEvent then
		local curHp = entity.monsterProp:getHp()
		local dices = RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundCombatDice() or {}

		curHp = curHp + #dices

		self:changeMonster(entity, buffMO, curHp)
	end
end

function M:changeMonster(entity, buffMO, curHp)
	local replaceId = entity.monsterProp:getReplaceId()
	local monsterId = 0
	local handlerName = ""
	local params = string.split(buffMO:getBuffCO().params, "#")
	local buffCo
	local match = false

	for i = 1, #params, 2 do
		if curHp > tonumber(params[i]) and not match then
			match = true
			monsterId = tonumber(params[i + 1])

			local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(monsterId)

			if monsterCo.passiveEffect then
				buffCo = RoguelikeConfig.instance:getEffectById(monsterCo.passiveEffect)
				handlerName = buffCo.clientProgram
			end
		end
	end

	if monsterId ~= 0 and replaceId ~= monsterId then
		if self._curHandlerProxy then
			self._curHandlerProxy:onRemove(entity, buffMO)
			self._curHandlerProxy:returnSelf()
		end

		entity.monsterProp:setReplaceId(monsterId)

		self._curHandlerProxy = RogueBuffClsUtil.getHandlerCls(handlerName):createInstance()

		self._curHandlerProxy:onAdd(entity, buffMO)

		self._targetTriggerEvents = {}

		table.insert(self._targetTriggerEvents, self._curHandlerProxy:getTriggerEvent())

		self._curMonsterId = monsterId

		settimer(0.2, self.delayChangeMonsterModel, self, false)
	end
end

function M:delayChangeMonsterModel()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_CHANGE_MONSTER_MODEL, self._curMonsterId)
end

function M:onRemove(entity, buffMO)
	return
end

return M
