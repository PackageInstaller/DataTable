-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleBuffTriggeredCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleBuffTriggeredCommand", package.seeall)

local BattleBuffTriggeredCommand = class("BattleBuffTriggeredCommand", BattleCommandBase)

function BattleBuffTriggeredCommand:parseServerCommand(cmdParser, buffTriggeredEventNO)
	if BattleCmdUtil.isStepEndedThenStepAgainTrigger(cmdParser, buffTriggeredEventNO) then
		if not cmdParser:hasFlag(BattleCmdParser.Flag_AfterMain) then
			local sequence = BattleSequenceCommand:createInstance()

			cmdParser:pushCmdContainer(sequence)
			self:_parseServerCommandWithoutCheck(cmdParser, buffTriggeredEventNO)
			cmdParser:popCmdContainer()
			cmdParser:setParam(BattleCmdParser.Param_AfterStepEndedCommand, sequence)

			return
		end

		local stepAgainCommand = self:_createAsStepAgain(buffTriggeredEventNO)

		cmdParser:setParam(BattleCmdParser.Param_AfterStepEndedCommand, stepAgainCommand)
	end

	self:_parseServerCommandWithoutCheck(cmdParser, buffTriggeredEventNO)
end

function BattleBuffTriggeredCommand:_parseServerCommandWithoutCheck(cmdParser, buffTriggeredEventNO)
	if not cmdParser:hasFlag(BattleCmdParser.Flag_EntityStep) then
		cmdParser:addCommand(BattleAdjustFollowCenterCommand:create(buffTriggeredEventNO.entity, 0))
	end

	local cmd = BattleBuffTriggeredCommand:createInstance()

	cmd:setEntityId(buffTriggeredEventNO.entity)
	cmd:setBuffCode(buffTriggeredEventNO.code)
	cmdParser:addCommand(cmd)

	local resultCollection = BattlePerformanceResultCollection:createInstance()

	resultCollection:parseEventNOList(buffTriggeredEventNO.effects)
	cmdParser:setParam(BattleCmdParser.Param_PerformanceResultCollection, resultCollection)

	local sequenceCommand = BattleSequenceCommand:createInstance()

	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.normalList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.hpChangedList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.specialPropertyModifiedList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.buffRemovedList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.entityDeadList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.triggeringList))
	sequenceCommand:addCommand(BattleParallelCommand:create(cmdParser, resultCollection.tagEventList))
	cmd:setEffectCommand(sequenceCommand)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.weakPointBrokenList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.afterPerformanceList)
	cmdParser:clearReusableParam(BattleCmdParser.Param_PerformanceResultCollection)
end

function BattleBuffTriggeredCommand:_createAsStepAgain(buffTriggeredEventNO)
	local cmd = BattleBuffTriggeredCommand:createInstance()

	cmd:setEntityId(buffTriggeredEventNO.entity)
	cmd:setSkillCode(buffTriggeredEventNO.code)
	cmd:setEffectCommand(BattleStepAgainCommand:create(buffTriggeredEventNO.entity))

	return cmd
end

function BattleBuffTriggeredCommand:onInit()
	self._entityId = 0
	self._buffCode = 0
	self._effectCommand = false
	self._timelineTask = TimelineTask.New()
	self._remainTaskCount = 0
	self._runningContext = false
end

function BattleBuffTriggeredCommand:onClear(interrupt)
	if self._effectCommand then
		self._effectCommand:safeInterrupt()

		self._effectCommand = false
	end

	self._entityId = 0
	self._buffCode = 0
	self._effectCommand = false

	self._timelineTask:clear()

	self._remainTaskCount = 0
	self._runningContext = false
end

function BattleBuffTriggeredCommand:execute(battleFlow, runningContext)
	self._runningContext = runningContext

	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleBuffTriggeredCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	local buffCO = BuffConfig.instance:getBuffCO(self._buffCode)

	unit.bubble:showBubble(BattleEnum.BubbleType.BUFF_TRIGGER_HINT, self._buffCode, BattleConst.DelayOne)

	if buffCO.triggerEffectCode > 0 then
		unit.effectPlayer:playEffect(buffCO.triggerEffectCode)
	end

	local halfAnimationTime = BattleConst.DelayZeroPointFive

	self._remainTaskCount = 2

	self._timelineTask:addTask(halfAnimationTime, self._onPlayTriggerEffects, self)
	self._timelineTask:addTask(halfAnimationTime + BattleConst.DelayZeroPointOne)
	self._timelineTask:addFinishListener(self._onTimelineTaskFinish, self)
	self._timelineTask:setTimeScale(BattleTime.timeScale)
	self._timelineTask:start(battleFlow)
end

function BattleBuffTriggeredCommand:onCommandFinish(cmd, success)
	self._effectCommand = false

	self:_onTimelineTaskFinish()
end

function BattleBuffTriggeredCommand:_onTimelineTaskFinish()
	self._remainTaskCount = self._remainTaskCount - 1

	if self._remainTaskCount <= 0 then
		self:finish(true)
	end
end

function BattleBuffTriggeredCommand:_onPlayTriggerEffects(context)
	if not self._effectCommand then
		self:_onTimelineTaskFinish()

		return
	end

	self._effectCommand:setCommandHandler(self)
	self._effectCommand:execute(context, self._runningContext)
end

function BattleBuffTriggeredCommand:toString()
	return string.format("[buff triggered command entityId = %s,buffCode = %s]", self._entityId, self._buffCode)
end

function BattleBuffTriggeredCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleBuffTriggeredCommand:setBuffCode(buffCode)
	self._buffCode = buffCode

	return self
end

function BattleBuffTriggeredCommand:setEffectCommand(effectCommand)
	self._effectCommand = effectCommand

	return self
end

return BattleBuffTriggeredCommand
