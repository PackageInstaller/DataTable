-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/SkillAttackPointHandlerUtil.lua

module("logic.battle.skill.attackpoint.SkillAttackPointHandlerUtil", package.seeall)

local SkillAttackPointHandlerUtil = {}
local kEventKey2HandlerClass = {
	buffAdded = BuffSkillAttackPointHandler,
	cured = CureSkillAttackPointHandler,
	positionChanged = TransportSkillAttackPointHandler,
	damaged = DamageSkillAttackPointHandler,
	groupEvent = GroupEventSkillAttackPointHandler,
	entitiesAdded = EntitiesAddedAttackPointHandler,
	modelChanged = ModelChangedAttackPointHandler,
	entitiesSwapped = EntitiesSwappedAttackPointHandler
}

function SkillAttackPointHandlerUtil.containsHandler(eventNO)
	for eventKey, _ in pairs(kEventKey2HandlerClass) do
		if BattleCmdUtil.hasField(eventNO, eventKey) then
			return true
		end
	end

	return false
end

function SkillAttackPointHandlerUtil.parseEventNO2Handler(eventNO)
	for eventKey, handlerClass in pairs(kEventKey2HandlerClass) do
		if BattleCmdUtil.hasField(eventNO, eventKey) then
			local handler = handlerClass:parseEventNO(eventNO[eventKey])

			if BattleLog.enableLog then
				BattleLog.log(string.format("add attack point handler %s", handler:toString()))
			end

			return handler
		end
	end
end

function SkillAttackPointHandlerUtil.buildAttackPointHandlers(handlers, context)
	SkillAttackPointHandlerUtil._mergeAttackPointHandlers(handlers, context)

	for _, handler in pairs(handlers) do
		handler:build(context)
	end

	local pointTimeList = context:getPointTimeList()

	if #pointTimeList <= 0 then
		local goTimeline = context:getTimelineGameObject()

		if BattleLog.enableError then
			BattleLog.error("Cannot find any attackpoint of", goTimeline.name)
		end
	end
end

function SkillAttackPointHandlerUtil._mergeAttackPointHandlers(handlers, context)
	local enitity2DamageHandler = BattleTableUtil.getTempList()
	local removeHandlerIdxList = BattleTableUtil.getTempList()
	local attackInfo = context:getAttackInfo()
	local continuousType = attackInfo:getContinuousType()
	local isMultiStageDamge = continuousType == BattleEnum.SkillContinuousType.MUTI_TIMELINE or continuousType == BattleEnum.SkillContinuousType.LOOP_TIMELINE

	for i, handler in pairs(handlers) do
		if OOPUtil.isInstanceOf(handler, DamageSkillAttackPointHandler) then
			if not enitity2DamageHandler[handler:getEnitityId()] then
				enitity2DamageHandler[handler:getEnitityId()] = handler

				if isMultiStageDamge then
					handler:addStageDamage(handler:getDamage())
					handler:setMultiStageStatus(isMultiStageDamge)
				end
			else
				local damageHandler = enitity2DamageHandler[handler:getEnitityId()]

				if isMultiStageDamge then
					damageHandler:addStageDamage(handler:getDamage())
				end

				damageHandler:setDamage(damageHandler:getDamage() + handler:getDamage())
				damageHandler:setHpDecrement(damageHandler:getHpDecrement() + handler:getHpDecrement())
				damageHandler:setWeakPointDamage(damageHandler:getWeakPointDamage() + handler:getWeakPointDamage())
				table.insert(removeHandlerIdxList, i)
			end
		end
	end

	for i = #removeHandlerIdxList, 1, -1 do
		table.remove(handlers, removeHandlerIdxList[i])
	end

	BattleTableUtil.releaseTempList(enitity2DamageHandler)
	BattleTableUtil.releaseTempList(removeHandlerIdxList)
end

function SkillAttackPointHandlerUtil.clearAttackPointHandlers(handlers, context)
	for _, handler in pairs(handlers) do
		handler:clear(context)
	end
end

function SkillAttackPointHandlerUtil.executeAttackPointHandlers(handlers, context, weight, amplitude)
	for _, handler in pairs(handlers) do
		if BattleLog.enableLog then
			BattleLog.log(string.format("execute attack point handler %s", handler:toString()))
		end

		handler:handleAttackPoint(context, weight, amplitude)
	end
end

function SkillAttackPointHandlerUtil.executeLastAttackPointHandlers(handlers, context)
	for _, handler in pairs(handlers) do
		handler:handleLastAttackPoint(context)
	end
end

return SkillAttackPointHandlerUtil
