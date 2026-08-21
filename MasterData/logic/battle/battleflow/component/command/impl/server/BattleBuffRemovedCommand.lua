-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleBuffRemovedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleBuffRemovedCommand", package.seeall)

local BattleBuffRemovedCommand = class("BattleBuffRemovedCommand", BattleCommandBase)

function BattleBuffRemovedCommand:parseServerCommand(cmdParser, buffTriggeredEventNO)
	local cmd = BattleBuffRemovedCommand:createInstance()

	cmd:setEntityId(buffTriggeredEventNO.entity)
	cmd:setBuffIds(buffTriggeredEventNO.ids)
	cmdParser:addCommand(cmd)
end

function BattleBuffRemovedCommand:onInit()
	self._entityId = 0
	self._buffIds = {}
	self._timelineTask = TimelineTask.New()
end

function BattleBuffRemovedCommand:onClear()
	self._entityId = 0

	BattleTableUtil.clearTable(self._buffIds)
	self._timelineTask:clear()
end

function BattleBuffRemovedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)
	local buffIds = self._buffIds

	if self:hasRemoveEffect(battleFlow) then
		self:doCameraFollow(battleFlow, runningContext)

		local duaration = runningContext:getParam(BattleCmdRunningContext.Param_AdjustFollowCenterTime)

		self._timelineTask:addTask(duaration, self._removeBuff, self)
		self._timelineTask:addTask(duaration + BattleConst.DelayZeroPointFive)
		self._timelineTask:addFinishListener(self._onTimelineTaskFinish, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start(battleFlow)
	else
		self:_removeBuff(battleFlow)
		self:finish(true)
	end
end

function BattleBuffRemovedCommand:_onTimelineTaskFinish()
	self:finish(true)
end

function BattleBuffRemovedCommand:_removeBuff(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		return
	end

	local buffIds = self._buffIds
	local removeBuffCodes = BattleTableUtil.getTempList()

	for _, buffId in ipairs(buffIds) do
		local buffMO = unit.buff:getBuffMO(buffId)

		if buffMO then
			local buffCO = buffMO:getBuffCO()

			if buffCO.effectCode > 0 then
				unit.effectPlayer:stopLoopEffect(buffCO.effectCode)
			end

			self:_processBuffLinkes(unit, buffCO)
			table.insert(removeBuffCodes, buffMO:getBuffCode())
		end
	end

	if #removeBuffCodes == 0 then
		BattleTableUtil.releaseTempList(removeBuffCodes)

		return
	end

	unit.uiProxy:playBuffRemoveAnim(removeBuffCodes)

	for _, buffId in ipairs(buffIds) do
		unit.buff:removeBuff(buffId)
	end

	if not self:_containsAnyDizzyOrSleep(unit) then
		unit.property:inactiveState(BattleEnum.State.DIZZY_OR_SLEEP)
		unit.stateEffect:refreshStateEffect()
	end

	BattleTableUtil.releaseTempList(removeBuffCodes)
end

function BattleBuffRemovedCommand:_containsAnyDizzyOrSleep(unit)
	local allBuff = unit.buff:getAllBuff()

	for _, buffMO in pairs(allBuff) do
		if not unit.property:isImmuneBuff(buffMO:getBuffCode()) and BuffCOUtil.isDizzyOrSleep(buffMO:getBuffCO()) then
			return true
		end
	end

	return false
end

function BattleBuffRemovedCommand:_processBuffLinkes(unit, buffCO)
	if not BuffCOUtil.isLink(buffCO) then
		return
	end

	local effectPlayer = BattleMgr.instance:getEffectPlayer()
	local effectCode = buffCO.linkEffectCode

	effectPlayer:removeLinkLineContainsEntityId(effectCode, unit.property:getEntityId())
end

function BattleBuffRemovedCommand:doCameraFollow(battleFlow, runningContext)
	local cmd = BattleAdjustFollowCenterCommand:create(0, self._entityId)

	cmd:execute(battleFlow, runningContext)
end

function BattleBuffRemovedCommand:hasRemoveEffect(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		return false
	end

	local buffIds = self._buffIds

	for _, buffId in ipairs(buffIds) do
		local buffMO = unit.buff:getBuffMO(buffId)

		if buffMO and not unit.property:isImmuneBuff(buffMO:getBuffCode()) and BuffCOUtil.isDizzyOrSleep(buffMO:getBuffCO()) then
			return true
		end
	end

	return false
end

function BattleBuffRemovedCommand:toString()
	return string.format("[buff removed command entityId = %s,buffIds = %s]", self._entityId, BattleTableUtil.arrayToString(self._buffIds))
end

function BattleBuffRemovedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleBuffRemovedCommand:setBuffIds(buffIds)
	if buffIds then
		table.insertto(self._buffIds, buffIds)
	end

	return self
end

return BattleBuffRemovedCommand
